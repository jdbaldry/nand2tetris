GITROOT = $(shell git rev-parse --show-toplevel)
include $(GITROOT)/common.mk

project0.zip: ## Build the submission zip archive.
project0.zip: file.txt
	zip $@ $<
