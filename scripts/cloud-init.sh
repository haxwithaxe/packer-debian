#!/bin/bash

set -eux

export DEBIAN_NONINTERACTIVE=true

apt install -y cloud-init ssh-import-id

# Enable a bunch of datasources. Borrowed from Ubuntu's `/etc/cloud/cloud.cfg.d/90_dpkg.cfg`.
echo 'datasource_list: [ NoCloud, ConfigDrive, OpenNebula, DigitalOcean, Azure, AltCloud, OVF, MAAS, GCE, OpenStack, CloudSigma, SmartOS, Bigstep, Scaleway, AliYun, Ec2, CloudStack, Hetzner, IBMCloud, Oracle, Exoscale, RbxCloud, UpCloud, VMware, Vultr, LXD, None ]' > /etc/cloud/cloud.cfg.d/90_datasources.cfg
