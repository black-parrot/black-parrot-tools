![BlackParrot Logo](docs/bp_logo.png)


# BlackParrot Tools Repository

This is a wrapper repo for tools used to run evaluations for [BlackParrot](https://github.com/black-parrot/black-parrot). 
Generally, this repo is included as part of a complete simulation environment.
However, the tools can be built directly here as well.
For most users, the following makefile targets will be the most useful:


    make tools_lite;     # minimal set of simulation tools
    make tools;          # standard tools
    make tools_bsg;      # additional tools for BSG users


There are also common Makefile targets to maintain the repository:


    make checkout;       # checkout submodules. Should be done before building tools
    make bleach_all;     # wipes the whole repo clean. Use with caution
    make help;           # prints information about documented targets


For advanced usage or debugging, standardized targets are provided for each tool.
By default, these targets will only run if needed.
Following is an example of these targets for building [Verilator](https://github.com/verilator/verilator):


    make patch.verilator;   # checks out submodules and applies patches
    make repatch.verilator; # forces patch
    make build.verilator;   # builds the verilator binary
    make rebuild.verilator; # forces build


## Repository Structure

Ideally, users will never have to dig around in here.
Just in case, here is a brief overview of the important files in the repository.
Submodules are omitted; explore them by following their hyperlinks.
Files marked with [x] are not often interesting to users while files marked with [r] are useful to read and files marked with [w] may require user configuration. 

    +---black-parrot-tools
        |---.gitlab-ci.common.yml # [x] YAML macros
        |---.gitlab-ci.yml        # [r] CI pipelines for building images
        |---Makefile              # [r] toplevel targets to run
        |---Makefile.common       # [x] macros, not often modified by users
        |---Makefile.env          # [w] black-parrot-tools settings
        |---mk
            |---Makefile.tools              # [r] specific tool build targets
        |---docker
            |---Dockerfile.centos7          # [r] Dockerfile for centos7
            |---Dockerfile.ubuntu24.04      # [r] Dockerfile for ubuntu24.04
            |---entrypoint.centos7.sh       # [x] entrypoint wrapper for centos7
            |---entrypoint.ubuntu24.04.sh   # [x] entrypoint wrapper for ubuntu24.04
            |---Makefile                    # [r] targets to create and run docker containers
            |---requirements.txt            # [r] python requirements for docker image
        |---ci
           |---common
              |---run-ci.sh                 # [r] wrapper script to run ci script on GitLab
              |---run-local.sh              # [r] wrapper script to run ci script locally
              |---functions.sh              # [x] helper functions for bash scripts
           |---functions.sh            # [w] helper functions for this repo
           |---smoke-verilator.sh      # [w] test that verilator is installed correctly
           |---smoke-yosys.sh          # [w] test that yosys is installed correctly


## Important Flags

Most variables have sensible defaults.
However, you may find these useful to override.

    BP_DIR          ?= $(TOP)             ; # root, nominally black-parrot-tools/
    BP_WORK_DIR     ?= $(BP_DIR)/work     ; # intermediate build directory
    BP_INSTALL_DIR  ?= $(BP_DIR)/install  ; # final installation directory

Additionally, if you have a different versions of Unix utilities you may find it useful to override their command in Makefile.common

## Docker Containerization

We provide Dockerfiles in docker/ to (mostly) match our internal build environments.
For performance, it is best to run natively if possible.
However, these are considered "self-documenting" examples of how to build these environments from scratch.
We also play clever tricks to allow users to mount the current repo in the image so that permissions are passed through.


    # Set the appropriate flags for your docker environment:
    #   DOCKER_PLATFORM: OS for the base image (e.g. ubuntu24.04, ...)
    #   USE_LOCAL_CREDENTIALS: whether to create the docker volume with your local uid/gid
    make -C docker docker-image; # creates a black-parrot-tools docker image
    make -C docker docker-run;   # mounts black-parrot-tools as a docker container


## Issues

For maintenance tractability we provide very limited support for this repository.
Please triage build problems to see if they are with this repo or the tools themselves.
Most often, issues with building individual tools should be reported in their respective upstream repository.
Any issues reported with this repo should be reproducible by at least one of the provided Docker containers.
Issue categories we appreciate:
  - Makefile bugs / incompatibilities
  - Dockerfile bugs / incompatibilities
  - OS-specific build tweaks
  - Upstream links breaking

## PRs

We will gratefully accept PRs for:
  - Tool version bumps
  - New OS support through Dockerfiles (along with necessary Makefile changes)
  - GitLab CI enhancements

## GitLab CI Packaging

We provide packaged releases of these tools on [GitLab](https://gitlab.com/bespoke-silicon-group/black-parrot-tools/-/packages).
These releases are highly experimental and there is no guarantee they will work on your machine, especially if there are OS differences.

