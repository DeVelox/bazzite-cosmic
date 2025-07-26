#!/bin/bash

set -ouex pipefail

# Tagged
# dnf5 -y install @cosmic-desktop

# Nightly COPR
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install cosmic-desktop --setopt=install_weak_deps=True
dnf5 -y copr disable ryanabx/cosmic-epoch

# systemctl disable sddm.service
systemctl disable gdm.service
systemctl enable cosmic-greeter.service

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true

