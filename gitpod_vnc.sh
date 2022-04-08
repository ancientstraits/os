#!/bin/sh

# This script easily gives gitpod graphical 
# capabilities by using tightvncserver and noVNC.
# To be lightweight, it also uses awesomeWM as the
# graphical environment, but you can change it
# by editing this script.

# Package management
sudo apt update

DEBIAN_FRONTEND=noninteractive sudo apt-get install -qq awesome tightvncserver xterm libgl1-mesa-dev xorg-dev xorg

# awesomeWM
AWESOMEPATH='~/.config/awesome'
AWESOMECONF=$AWESOMEPATH/rc.lua
[ ! -d $AWESOMEPATH ] && mkdir ~/.config/awesome
[ ! -f $AWESOMECONF ] && cp /etc/xdg/awesome/rc.lua ~/.config/awesome/rc.lua

# set VNC password
umask 0077
mkdir -p "$HOME/.vnc"
chmod go-rwx "$HOME/.vnc"
echo "passwd" | vncpasswd -f > "$HOME/.vnc/passwd"

# Change the startup script to start awesomeWM
cat << EOF > ~/.vnc/xstartup
#!/bin/sh
awesome &
EOF

# make the file executable
chmod +x ~/.vnc/xstartup

# You can configure vncserver with the -geometry option,
# which will change the screen size.
# This gives a display with a width of 600
# and a height of 400.
vncserver -geometry 1366x768

# novnc
git clone https://github.com/novnc/novnc ~/.novnc
~/.novnc/utils/novnc_proxy --vnc localhost:5901

# Gitpod will notify you that 3 ports are open.
# Make the 6080 port public, then open it in a new tab or
# the preview by clicking the "Remote Explorer" sidebar
# button on the side of Gitpod Code.