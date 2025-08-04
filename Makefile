TOP ?= $(shell git rev-parse --show-toplevel)
include $(TOP)/Makefile.common
include $(TOP)/Makefile.env

include $(BP_MK_DIR)/Makefile.*

tools_lite: ## minimal set of simulation tools
tools_lite:
	@+$(MAKE) build.verilator
	@+$(MAKE) build.dromajo
	@$(call bsg_fn_strip_binaries, $(BP_INSTALL_DIR))

tools: ## standard tools
tools: tools_lite
	@+$(MAKE) build.spike
	@+$(MAKE) build.surelog
	@+$(MAKE) build.yosys
	@+$(MAKE) build.yslang
	@+$(MAKE) build.axe
	@$(call bsg_fn_strip_binaries, $(BP_INSTALL_DIR))

tools_bsg: ## additional tools for BSG users
tools_bsg: tools 
	# Fails on first build attempt for some reason
	@+$(MAKE) build.bsg_sv2v || :
	@+$(MAKE) build.bsg_sv2v
	@+$(MAKE) build.bsg_fakeram
	@$(call bsg_fn_strip_binaries, $(BP_INSTALL_DIR))

