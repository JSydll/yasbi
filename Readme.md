# YoT: Yocto-driven IoT devices

This project aims at creating a custom reference distro for embedded devices (like the Raspi 3 
and possibly later some more hardware platforms) in the context of connected products / IoT. 

It leverages existing software layers from the Yocto/OpenEmbedded community where possible and 
extends configurations / default settings where necessary.

The main idea is to have the build 

## Requirements for the image
- Basic, headless image
- Security features enabled by default
- Ssh-able without runtime configuration
- Wifi-enabled without runtime configuration
- Wrapper layer that fetches a repository, builds it with CMake, puts it in the image and 
  configures a systemd service to have it running

## Documentation 

- [Explanation of the repository structure](doc/structure.md)
- [Software foundation and dependencies](doc/dependencies.md)
- [Scripts for execution and convenience](doc/scripts.md)
- [Configuration of the build process and image](doc/configuration.md)
- [Resources and further reading](doc/resources.md)

## Prerequisites

Clone this repo and run `sudo ./install-deps.sh` to get required Ubuntu packages for a Yocto build.

## Execution

- Run `source ./scripts/init.sh` to initialize the yocto environment and to issue custom commands.
- Run `./scripts/build-minimal.sh` to build a minimal image. You can forward additional parameters 
  to the bitbake command by adding them to this call.
   
## Configuration

Customizing the image works via environment variables. The currently supported set of 
variables (aside from those natively used by Yocto) can be found in the `.env.sample` 
file. Details how it works are documented on the [Configuration page](doc/configuration.md).

## Main contents

Aside from collecting the required layers and configuring them, this projects adds 
scripts to configure the images as well as some custom layers with additional functionality. 
Among these are:

- `meta-connectivity` with some foundational features like compile-time wifi configuration
- `meta-application` providing a wrapper for a CMake-based application built and deployed in the image


## To dos
- Wifi AP mode?
- Remove meta-yocto-bsp?
- Replace IMAGE_INSTALL_append s in layer.confs with CORE_IMAGE_EXTRA_INSTALL to be safe all packages get deployed (also in minimal image)?
- Firewall setup (iptables)
- Overlay fs w/ data partition filling whole space
- Enable build-time configuration of ssh
  - ports
  - installed pub keys
- Testing the image
- Configure swupdate layer
- Configure security layer