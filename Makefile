.ONESHELL:
.DELETE_ON_ERROR:
export SHELL     := bash
export SHELLOPTS := pipefail:errexit
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rule

CLASSPATH = ""
GITROOT   = $(shell git rev-parse --show-toplevel)

# Adapted from https://suva.sh/posts/well-documented-makefiles/
.PHONY: help
help: ## Display this help.
help:
	@awk 'BEGIN {FS = ": ##"; printf "Usage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z0-9_\.\-\/% ]+: ##/ { printf "  %-45s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

COMPLETED := 01 02 03 04 05
CHIPS     := $(shell git ls-files -co $(patsubst %,projects/%/*.hdl, $(COMPLETED)))
HACKS     := $(shell git ls-files -co $(patsubst %,projects/%/*.asm, $(COMPLETED)))
TESTED    := $(CHIPS:.hdl=.out.TESTED) $(HACKS:.asm=.hack.TESTED)

.TESTED: ## Test everything!
.TESTED: $(TESTED)
	touch .TESTED

projects/00/project0.zip: ## Build the submission zip archive.
projects/00/project0.zip: projects/00/file.txt
	zip $@ $<

%.out %.out.TESTED: ## Test all the HDL chips against a known good implementation.
%.out %.out.TESTED: %.tst %.hdl
	if $(GITROOT)/tools/HardwareSimulator.sh $<; then touch $@; else exit 1; fi

%.hack: ## Assemble a hack program.
%.hack: %.asm
	$(GITROOT)/tools/Assembler.sh $<

%.hack %.hack.TESTED: ## Test that a hack program works as expected.
%.hack %.hack.TESTED: %.tst
	if $(GITROOT)/tools/CPUEmulator.sh $<; then touch $@; else exit 1; fi

clean: ## Remove all build artifacts.
	rm $(TESTED)
