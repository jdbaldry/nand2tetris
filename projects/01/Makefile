include ../../common.mk

%.out: ## Produce the truth table output from an HDL chip.
%.out: %.tst %.hdl
	$(GITROOT)/tools/HardwareSimulator.sh $<

.PHONY: test
test: ## Test all the HDL chips against a known good implementation.
test:
	CLASSPATH="" $(GITROOT)/tools/test-chips 01
