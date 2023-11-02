#!/bin/bash

set -ex

wget https://gitea.local/haxwithaxe/setup-scripts/raw/branch/debian-oneshot/debian-oneshot.sh \
	-O /tmp/ansible-setup.sh
set +x # Don't show the vault password in the log
echo "$ANSIBLE_VAULT_PASSWORD" > /tmp/ansible-vault-password
set -x
bash /tmp/ansible-setup.sh https://gitweb.local/haxwithaxe/ansible-debian-base.git main --vault-password-file /tmp/ansible-vault-password
rm -rf /home/*/.ansible /tmp/ansible-setup.sh
shred -ux /tmp/ansible-vault-password
