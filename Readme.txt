##################################################################
                     ##################################################################
                     ###                   Autorotate for KDE Plasma                ###
                     ### Developed by sergio melas (sergiomelas@gmail.com) 2021-26  ###
                     ##################################################################
                     ##################################################################

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Important: This is intended mainly for the stubborn people that want to stay in KDE
Plasma on X11. This functionality exists in KDE Plasma on Wayland, however
this adds features like keyboard management for Wayland making it still appealing in Wayland.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

New Features in Version 3.1:
  - Native UDEV Rules: Automatically handles persistent keyboard LED backlight brightness permissions without legacy init scripts.
  - System-Wide Autostart: Automatically manages cleanup states on user login via `/etc/xdg/autostart/`.
  - Automated Desktop Provisioning: Automatically deploys and configures fully-permissive toggle shortcuts across all user desktops.
  - Integrated Theme Selector: Interactive GUI configuration utility that runs post-installation or via the desktop application menu.

Theme Configuration Instructions (Post-Installation):
  - You can change your system-wide status icon theme at any time after installation.
  - Open your KDE application launcher menu, search for "Autorotate Theme Selector", and launch it.
  - Alternatively, run the theme selector directly from your terminal:
    /usr/bin/Autorotate_theme.sh
  - Select your preferred theme from the graphical dialog list (Themes 1 through 7) to instantly apply and cache the active state icons.

Installation Instructions:
  - Install a kernel with tablet mode (ex: for Lenovos activate CONFIG_LENOVO_YMC)
  - Unzip the file
  - Open terminal
  - Run the package installation (.deb) or standalone install script
  - Reboot
  - Install tablet support for KDE
    sudo apt-get install kde-config-tablet
    Configure: /Settings/Input Devices/Graphic Tablet: Check "Auto-Rotate With Screen" and "Invert Auto-Rotation"

Removal Instructions:
  - To uninstall run remove.sh or purge the Debian package

Note: This software works only for KDE Plasma and supposes that only one dock is installed per window manager.
Supported docks:

X11:
- Plank
- Cairo Dock
- Latte Dock

Wayland:
- Crystal Dock (Not packaged in Debian yet, available at: https://github.com/dangvd/crystal-dock/releases)
- Plank (through Xwayland)

##################################################################################################################
Change log:

V3.1  2026-08-31  - Added robust UDEV rules for persistent keyboard LED brightness permissions, restored system-wide
                    autostart for the clean script, and automated universal user desktop shortcut provisioning with full
                    permissions, debugging tools, and autoconf utilities.
V3.0  2026-02-06  - Corrected bugs of icon misplacement in X11
V2.9  2025-12-29  - Corrected bugs of the support for wayland on plasma 6, improved support for plank
V2.8  2025-12-25  - Added support for wayland on plasma 6 & Cristal Dock for KDE Plasma Wayland, allow plank to work in wayland.
V2.7  2025-01-29  - Corrected bug in plasma 6
V2.6  2025-01-29  - Make it compatible with Plasma 6, added support for cairo dock
V2.5  2024-09-22  - Added mouse get stuck workaround and remove spurious bash processes creation
V2.4  2024-07-28  - Added Virtual Keyboard for loging and lockscreen
V2.3  2024-06-29  - Corrected bug cousing cpu waste, added Icons and state visualization, corrected bug on touch
                    screen while activated not horizontally
V2.2  2024-03-05  - Substitued keyboard and pad desativation by kernel tablet module, added option to deactivate
                    reverse stereo
V2.1  2023-08-30  - Addeed support for Pipewire and Easy effects, improved sincronization of rotation
                    with hand shake, removed backlight management because nice to have and creating to many bugs,
                    corrected Bug on processes and sleep, added Check for X11 and Kde Plasma at installation,
                    cleaned unused old commented code, corrected bug in keyboard backlight
V2.0  2023-07-30  - Added support for plank and pulseaudio
V1.9: 2023-04-25  - Added forced stop in toggle, added autochange directory in install
V1.8: 2023-01-20  - Removed icon acess from rclocal
V1.7: 2022-10-30  - Added full support for stilus digitizer, improved Sound Management
V1.6: 2022-08-20  - Added timer for rotation confirmation to avoid spurius trasnsitions, added stereo reverse
                    in upsidedown mode, better keyboard backlight management, added interactive dialogue
V1.5: 2022-06-20  - Fully centralized global Config, Improved backlight management, Added some themes
V1.4: 2022-05-30  - Improved State Memory, Added Global Config
V1.3: 2022-04-14  - State memory added
V1.2: 2022-03-30  - Theamed icons are chosen at install
V1.1: 2022-02-12  - Added themed icons
V1.0: 2021-12-28  - Initial version
