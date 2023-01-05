TOP ?= $(shell git rev-parse --show-toplevel)

.PHONY: help tools_lite tools tools_bsg tidy bleach_all

include $(TOP)/Makefile.common
include $(TOP)/Makefile.tools

help:
	@echo "usage: make [tools, tools_lite, tools_bsg, tidy, bleach_all]"

TOOL_TARGET_DIRS := $(BP_TOOLS_BIN_DIR) $(BP_TOOLS_LIB_DIR) $(BP_TOOLS_INCLUDE_DIR) $(BP_TOOLS_TOUCH_DIR)
$(TOOL_TARGET_DIRS):
	mkdir -p $@

tools_lite: $(TOOL_TARGET_DIRS)
	$(MAKE) verilator
	$(MAKE) dromajo

## This target makes the tools needed for the BlackParrot RTL
tools: tools_lite
	$(MAKE) surelog
	$(MAKE) axe

tools_bsg: tools bsg_cadenv
	$(MAKE) bsg_sv2v

bsg_cadenv: $(BSG_CADENV_DIR)
$(BSG_CADENV_DIR):
	-git clone git@github.com:bespoke-silicon-group/bsg_cadenv.git $@

tidy:
	git submodule deinit -f verilator dromajo surelog axe bsg_sv2v

clean.tools:
	rm -rf $(BP_TOOLS_TOUCH_DIR)

## This target just wipes the whole repo clean.
#  Use with caution.
bleach_all:
	cd $(TOP); git clean -fdx; git submodule deinit -f .

