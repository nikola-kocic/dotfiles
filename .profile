#eval $(ssh-agent)
#if [ -n "$DESKTOP_SESSION" ];then
#    eval $(gnome-keyring-daemon --start)
#    export SSH_AUTH_SOCK
#fi

#export GTK_OVERLAY_SCROLLING=0
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dcom.eteks.sweethome3d.j3d.useOffScreen3DView=true'
export WINEPREFIX="${HOME}/win64"

#export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
#export ANDROID_HOME="/mnt/linux-home/fs/opt/android-sdk"

# export PATH="${PATH}:${ANDROID_HOME}/tools"
# export PATH="${PATH}:${ANDROID_HOME}/platform-tools"
# export PATH="${HOME}/fs/bin:${PATH}"
# export PATH="/usr/lib/ccache/bin:${PATH}"
# export PATH="${HOME}/.cargo/bin:${PATH}"
# export DOTNET_CLI_TELEMETRY_OPTOUT=1

export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export QT_SCREEN_SCALE_FACTORS="HDMI-A-0=2;HDMI-A-1=2;DisplayPort-0=2;DisplayPort-1=2"
export QT_SCREEN_SCALE_FACTORS="2;2"
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export XCURSOR_SIZE=48
export XCURSOR_THEME=capitaine-cursors
