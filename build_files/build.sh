#!/bin/bash

set -ouex pipefail

# Tagged
# dnf5 -y install @cosmic-desktop

# Nightly COPR
dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install cosmic-desktop --setopt=install_weak_deps=True
dnf5 -y copr disable ryanabx/cosmic-epoch

if [[ "$BASE_IMAGE" =~ "gnome" ]]; then
    systemctl disable gdm.service
else
    systemctl disable sddm.service
fi
systemctl enable cosmic-greeter.service

# Gamescope session
dnf5 -y copr enable bazzite-org/bazzite
dnf5 -y install gamescope-session-plus gamescope-session-steam
dnf5 -y copr disable bazzite-org/bazzite

sed -i 's/ -steampal -steamdeck//' /usr/share/gamescope-session-plus/sessions.d/steam

# Extra apps
if [ -n "$EXTRA_APPS" ]; then
    dnf5 -y install $EXTRA_APPS
fi

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true

