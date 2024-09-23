TOP ?= $(shell git rev-parse --show-toplevel)

.PHONY: help tools_lite tools tools_bsg tidy bleach_all

include $(TOP)/Makefile.common
include $(TOP)/Makefile.tools

all: apply_patches

help:
	@echo "usage: make [tools, tools_lite, tools_bsg, tidy, bleach_all]"

override TARGET_DIRS := $(BP_TOOLS_BIN_DIR) $(BP_TOOLS_LIB_DIR) $(BP_TOOLS_INCLUDE_DIR) $(BP_TOOLS_TOUCH_DIR)
$(TARGET_DIRS):
	mkdir -p $@

# checkout submodules, but not recursively
checkout: | $(TARGET_DIRS)
	git fetch --all
	git submodule sync --recursive
	git submodule update --init

patch_tag ?= $(addprefix $(BP_TOOLS_TOUCH_DIR)/patch.,$(shell $(GIT) rev-parse HEAD))
apply_patches: | $(patch_tag)
$(patch_tag):
	$(MAKE) checkout
	git submodule update --init --recursive --recommend-shallow
	$(call patch_if_new,$(axe_dir),$(BP_TOOLS_PATCH_DIR)/axe)
	$(call patch_if_new,$(yosys_dir),$(BP_TOOLS_PATCH_DIR)/yosys)
	touch $@
	@echo "Patching successful, ignore errors"

tools_lite: apply_patches
	$(MAKE) verilator
	$(MAKE) dromajo

## This target makes the tools needed for the BlackParrot RTL
tools: tools_lite
	$(MAKE) spike
	$(MAKE) surelog
	$(MAKE) yosys
	$(MAKE) axe

tools_bsg: tools bsg_cadenv
	# Fails on first build attempt
	$(MAKE) bsg_sv2v || $(MAKE) bsg_sv2v
	$(MAKE) bsg_fakeram

## This target just wipes the whole repo clean.
#  Use with caution.
bleach_all:
	cd $(TOP); git clean -fdx; git submodule deinit -f .

