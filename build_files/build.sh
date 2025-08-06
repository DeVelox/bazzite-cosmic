#!/bin/bash

set -ouex pipefail

if [ -n "$EXTRA_APPS" ]; then
    dnf5 -y install "$EXTRA_APPS"
fi

# Tagged
# dnf5 -y install @cosmic-desktop

# Nightly COPR
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install cosmic-desktop --setopt=install_weak_deps=True
dnf5 -y copr disable ryanabx/cosmic-epoch

# systemctl disable sddm.service
systemctl disable gdm.service
systemctl enable cosmic-greeter.service

# Gamescope session
dnf5 -y copr enable bazzite-org/bazzite
dnf5 -y install gamescope-session-plus gamescope-session-steam
dnf5 -y copr disable bazzite-org/bazzite

sed -i 's/export CLIENTCMD="steam -gamepadui -steamos3 -steampal -steamdeck"/export CLIENTCMD="steam -gamepadui -steamos3"/' /usr/share/gamescope-session-plus/sessions.d/steam

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true

