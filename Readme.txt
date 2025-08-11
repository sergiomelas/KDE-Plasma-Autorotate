                     ##################################################################
                     ##################################################################
                     ###                   Autorotate for KDE Plasma                ###
                     ### Developed by sergio melas (sergiomelas@gmail.com) 2021-25  ###
                     ##################################################################
                     ##################################################################

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Inportant: This is intended mainly for the stubborn people that want to stay in KDE
Plasam on X11, This functionality exists in KDE Plasma on Wayland, however
this add some features like keybord management for wayland making is still appealing in Wayland
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Installation Instructions:
  -Install a kernel with the tablet mode (ex: for Lenovos activate CONFIG_LENOVO_YMC)
  -Unzip the file
  -Edit "Autorotate_conf.sh" configuration file in the Payload sub directory, to match the config of your system
  -Open terminal
  -Run the Run-me.sh script (Just double click, rest is automatic)
  -Reboot
  -Install tablet support for KDE
    sudo apt-get install kde-config-tablet
    Configure:/Settings/Input Devices/Graphic Tablet: Check "Auto-Rotate With Screen" and "Invert Auto-Rotation"
  -Add /usr/bin/Autorotate_clean.sh in the startup execution files
    Configure:/Settings/Startup and Shudwn/Autostart: add Login Scripts and set that file

Update configuration Instructions:

  -Update "Autorotate_conf.sh" configuration file in the Payload sub directory
  -Rerun the install.sh script

Removal Instructions:

  -To unistall run remove.sh

Note: this software works only for Kde Plasma, it suposses that only one dock is installed per windows manager
supported dock:

X11:
-Plank
-Cairo Dock
-Latte doc

Wayland:
-Crystal Dock , This is not packaged yet in debian, but you can finf it here: https://github.com/dangvd/crystal-dock/releases


##################################################################################################################
Change log:

V1.0: 2021-12-28
  -Initial version
V1.1: 2022-02-12
  -Added themed icons
V1.2: 2022-03-30
  -Theamed icons are chosen at install
V1.3: 2022-04-14-
  -State memory added
V1.4: 2022-05-30
  -Improved State Memory,
  -Added Global Config
V1.5: 2022-06-20
  -Fully centralized global Config,
  -Improved backlight management,
  -Added some themes
V1.6: 2022-08-20
  -Added timer for rotation confirmation to avoid spurius trasnsitions,
  -Added stereo reverse in upsidedown mode,
  -Better keyboard backlight management,
  -Added interactive dialogue
V1.7: 2022-10-30
  -Added full support for stilus digitizer,
  -Improved Sound Management
V1.8: 2023-01-20
  -Removed icon acess from rclocal
V1.9: 2023-04-25
  -Added forced stop in toggle, added autochange directory in install
V2.0  2023-07-30
  -Added support for plank and pulseaudio
V2.1  2023-08-30
  -Addesd support for Pipewire and Easy effects,
  -improved sincronization of rotation with hand shake,
  -Removed backlight management because nice to have and creating to many bugs
  -Corrected Bug on processes and sleep
  -Added Check for X11 and Kde Plasma at installation
  -Cleaned unused old commented code
  -Corrected bug in keyboard backlight
V2.2  2024-03-05
  -Substitued keyboard and pad desativation by kernel tablet module
  -added option to deactivate reverse stereo
V2.3  2024-06-29
  -Corrected bug cousing cpu waste
  -Added Icons and state visualization
  -Corrected bug on touch screen while activated not horizontally
V2.4  2024-07-28
  -Added Virtual Keyboard for loging and lockscreen
V2.5  2024-09-22
  -Added mouse get stuck workaround and remove spurious bash processes creation
V2.6  2025-01-29
  -Make it compatible with Plasma 6
  -Added support for cairo dock (only doc working properly with plasma 6)
V2.7  2025-01-29
  -Corrected bug in plasma 6
V2.8  2025-08-11
  -Added support for wayland on plasma 6
