# What is ISC Kea DHCP

Kea is the next generation of DHCP software, developed by Internet Systems Consortium (ISC). It supports both the DHCPv4 and DHCPv6 protocols along with their extensions, e.g. prefix delegation and dynamic updates to DNS.

Kea has following services

1. Standard features
    - DHCP4
    - DHCP6
    - High Availability
    - Dynamic DNS updates
   - Host reservations
1. REST Api

> Please follow this article that explains how to setup Kea for a [Small Office or Home Use](https://kb.isc.org/docs/kea-configuration-for-small-office-or-home-use)

![ISC Kea Logo](https://gitlab.isc.org/uploads/-/system/project/avatar/26/kea-logo-100x70.png?width=64)

## Purpose

Currently most of the DHCP servers are managed manually. With Kea REST Api, we can move the standard dhcp features to work from inside a container and automate the leases/reservations via REST api (Kea Control Agent).

# How to use this image

## Usage

Due to image size and vulnerabilities, this is alpine based solution.

### Environment Variables

| Variable Name          | Purpose                                                                                                                  | Default Value    |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------ | ---------------- |
| KEA_SERVICE (required) | The service that we want to run. Values that can be passed dhcp4 , dhcp6, dhcp-ddns & ctrl-agent. This is case sensitive | dhcp4            |
| TZ                     | Time zone                                                                                                                | America/New_York |

> NOTE: For kea to work we need to provide configuration. These containers will not start if the proper configuration is not provided.

#### Example: 
```
docker run -d --name dhcp4 -e "KEA_SERVICE=dhcp4" -v "./kea-dhcp4.conf:/etc/kea/kea-dhcp4.conf" sarinsgroup/isc-kea-dhcp:stable
```

### docker-compose.yml

```docker
version: "3.8"

services:
    dhcp4:
    image: sarinsgroup/isc-kea-dhcp
    container_name: dhcp4    
    environment:
        - KEA_SERVICE=dhcp4
    volumes:
        - ./kea-dhcp4.conf:/etc/kea/kea-dhcp4.conf

    dhcp6:
    image: sarinsgroup/isc-kea-dhcp
    container_name: dhcp6    
    environment:
        - KEA_SERVICE=dhcp6
    volumes:
        - ./kea-dhcp4.conf:/etc/kea/kea-dhcp4.conf

    ddns:
    image: sarinsgroup/isc-kea-dhcp
    container_name: dhcp-ddns    
    environment:
        - KEA_SERVICE=dhcp-ddns
    volumes:
        - ./kea-dhcp-ddns.conf:/etc/kea/kea-dhcp-ddns.conf

    ctrlagent:
    image: sarinsgroup/isc-kea-dhcp
    container_name: ctrl-agent    
    environment:
        - KEA_SERVICE=ctrl-agent
    volumes:
        - ./kea-ctrl-agent.conf:/etc/kea/kea-ctrl-agent.conf

```

## Configuraions

### Basic configurations samples can be downloaded from

- dhcp4 - https://raw.githubusercontent.com/SarinsGroup/isc-kea-dhcp/main/docker/kea/kea-dhcp4.conf
- dhcp6 - https://raw.githubusercontent.com/SarinsGroup/isc-kea-dhcp/main/docker/kea/kea-dhcp6.conf
- dhcp-ddns - https://raw.githubusercontent.com/SarinsGroup/isc-kea-dhcp/main/docker/kea/kea-dhcp-ddns.conf
- ctrl-agent - https://raw.githubusercontent.com/SarinsGroup/isc-kea-dhcp/main/docker/kea/kea-ctrl-agent.conf

### For advance configurations refer

- dhcp4 - https://kea.readthedocs.io/en/latest/arm/dhcp4-srv.html#dhcpv4-server-configuration
- dhcp6 - https://kea.readthedocs.io/en/latest/arm/dhcp6-srv.html#dhcpv6-server-configuration
- dhcp-ddns - https://kea.readthedocs.io/en/latest/arm/ddns.html#configuring-the-dhcp-ddns-server
- ctrl-agent - https://kea.readthedocs.io/en/latest/arm/agent.html#configuration

# License

The core Kea daemons are open source, shared under [MPL2.0 licensing](https://www.mozilla.org/en-US/MPL/2.0/). These images follows the same guidelines and encourages everyone to make contribution back to this repo.

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
