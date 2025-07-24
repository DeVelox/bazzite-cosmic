#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Tagged
# dnf5 -y install @cosmic-desktop

# Nightly COPR
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install cosmic-desktop --setopt=install_weak_deps=True
dnf5 -y copr disable ryanabx/cosmic-epoch

systemctl disable sddm.service
systemctl enable cosmic-greeter.service
