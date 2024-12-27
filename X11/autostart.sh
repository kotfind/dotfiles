#!/bin/bash

run() {
    for pid in $(pgrep -f $1); do
        kill -9 "$pid"
    done
    $*
}

SXHKD_SHELL=sh

xkbcomp ~/.config/xkb/my $DISPLAY > /dev/null 2>&1

xrdb ~/.Xresources

run xss-lock slock
run batsignal
run /usr/lib/notification-daemon-1.0/notification-daemon
run lxqt-policykit-agent
run sxhkd

run ~/.config/lemonbar/lemonbar.sh

mkdir -p /tmp/downloads /tmp/screenshots
