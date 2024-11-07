TOP ?= $(shell git rev-parse --show-toplevel)
include $(TOP)/Makefile.common
include $(TOP)/Makefile.env

include $(BP_TOOLS_MK_DIR)/Makefile.tools

checkout: ## checkout submodules, but not recursively
	@$(MKDIR) -p $(BP_TOOLS_BIN_DIR) \
		$(BP_TOOLS_LIB_DIR) \
		$(BP_TOOLS_INCLUDE_DIR) \
		$(BP_TOOLS_TOUCH_DIR) \
		$(BP_TOOLS_TOUCH_DIR) \
		$(BP_TOOLS_WORK_DIR)
	@$(GIT) fetch --all
	@$(GIT) submodule sync --recursive
	@$(GIT) submodule update --init

apply_patches: ## applies patches to submodules
apply_patches: build.patch
$(eval $(call bsg_fn_build_if_new,patch,$(CURDIR),$(BP_TOOLS_TOUCH_DIR)))
%/.patch_build: checkout
	@$(GIT) submodule sync --recursive
	@$(GIT) submodule update --init --recursive --recommend-shallow
	@$(call patch_if_new,$(BP_TOOLS_AXE_DIR),$(BP_TOOLS_PATCH_DIR)/axe)
	@$(call patch_if_new,$(BP_TOOLS_YOSYS_DIR),$(BP_TOOLS_PATCH_DIR)/yosys)
	@$(ECHO) echo "Patching successful, ignore errors"

tools_lite: ## minimal set of simulation tools
tools_lite: apply_patches
	@$(MAKE) build.boost
	@$(MAKE) build.verilator
	@$(MAKE) build.dromajo

tools: ## standard tools
tools: tools_lite
	@$(MAKE) build.spike
	@$(MAKE) build.surelog
	@$(MAKE) build.yosys
	@$(MAKE) build.axe

tools_bsg: ## Additional tools for BSG users
tools_bsg: tools 
	# Fails on first build attempt
	@$(MAKE) build.bsg_sv2v || $(MAKE) build.bsg_sv2v
	@$(MAKE) build.bsg_fakeram

