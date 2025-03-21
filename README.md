![BlackParrot Logo](docs/bp_logo.png)


# BlackParrot Tools Repository

This is a wrapper repo for tools used to run evaluations for [BlackParrot](https://github.com/black-parrot/black-parrot). 
Generally, this repo is included as part of a complete simulation environment.
However, the tools can be built directly here as well.
For most users, the following makefile targets will be the most useful.


    make bleach_all;     # wipes the whole repo clean. Use with caution
    make help;           # prints information about targets
    make checkout;       # checkout submodules
    make tools_lite;     # minimal set of simulation tools
    make tools;          # standard tools
    make tools_bsg;      # additional tools for BSG users


For advanced usage or debugging, standardized targets are provided for each tool.
By default, these targets will only run if needed.
Following is an example of these targets for building [Verilator](https://github.com/verilator/verilator)


    make patch.verilator; # checks out submodules and applies patches
    make repatch.verilator; # Forces patch
    make build.verilator; # builds the verilator binary
    make rebuild.verilator; # forces build


## Docker Containerization

We provide Dockerfiles in docker/ to (mostly) match our internal build environments.
For performance, it is best to run natively if possible.
However, these are considered "self-documenting" examples of how to build these environments from scratch.
We also play clever tricks to allow users to mount the current repo in the image so that permissions are passed through.


    # Set the appropriate flags for your docker environment:
    #   DOCKER_PLATFORM: OS for the base image (e.g. ubuntu24.04, ...)
    #   USE_LOCAL_CREDENTIALS: whether to create the docker volume with your local uid/gid
    make docker-image; # creates a black-parrot-tools docker image
    make docker-run; # mounts black-parrot-tools as a docker container


## Issues

For maintenance tractability we provide very limited support for this repository.
Please triage build problems to see if they are with this repo or the tools themselves.
Most often, issues with building individual tools should be reported in their respective upstream repository.
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

