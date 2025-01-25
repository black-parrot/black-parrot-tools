TOP ?= $(shell git rev-parse --show-toplevel)
include $(TOP)/Makefile.common
include $(TOP)/Makefile.env

include $(BP_TOOLS_MK_DIR)/Makefile.tools
include $(BP_TOOLS_MK_DIR)/Makefile.docker

checkout: ## checkout submodules
	@$(MKDIR) -p $(BP_TOOLS_BIN_DIR) \
		$(BP_TOOLS_LIB_DIR) \
		$(BP_TOOLS_INCLUDE_DIR) \
		$(BP_TOOLS_TOUCH_DIR) \
		$(BP_TOOLS_WORK_DIR)
	# Synchronize any pending updates
	@$(GIT) submodule sync
	@$(GIT) submodule init
	# Disable long checkouts
	@$(GIT) -C $(BP_TOOLS_YSLANG_DIR) config --local submodule.tests/third_party/croc.update none
	@$(GIT) -C $(BP_TOOLS_YSLANG_DIR) config --local submodule.tests/third_party/yosys.update none
	@$(GIT) submodule sync --recursive
	# Do the checkout
	@$(GIT) submodule update --init --recursive

tools_lite: ## minimal set of simulation tools
tools_lite: checkout
	@$(MAKE) build.boost
	@$(MAKE) build.verilator
	@$(MAKE) build.dromajo

tools: ## standard tools
tools: tools_lite
	@$(MAKE) build.spike
	@$(MAKE) build.surelog
	@$(MAKE) build.yosys
	@$(MAKE) build.yslang
	@$(MAKE) build.axe

tools_bsg: ## Additional tools for BSG users
tools_bsg: tools 
	# Fails on first build attempt
	@$(MAKE) build.bsg_sv2v || $(MAKE) build.bsg_sv2v
	@$(MAKE) build.bsg_fakeram

