#!/bin/sh

run() {
    pgrep -f $1 &> /dev/null || $* &> /dev/null &
}

xkbcomp ~/.config/xkb/my $DISPLAY > /dev/null 2>&1
xrdb ~/.Xresources
run slstatus
run xss-lock slock
run batsignal
run /usr/lib/notification-daemon-1.0/notification-daemon
# run lxqt-policykit-agent
