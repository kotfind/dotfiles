import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Actions.GridSelect
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Run
import XMonad.StackSet
import XMonad.Layout.Dwindle
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CopyWindow
import XMonad.Layout.Spacing

main = do
    xmonad $ ewmh def
        { terminal              = my_terminal
        , modMask               = mod4Mask
        , handleEventHook       = fullscreenEventHook
        , layoutHook            = smartBorders myLayout
        , startupHook           = startup
        , borderWidth           = 2
        , normalBorderColor     = "black"
        , focusedBorderColor    = "orange"   
        , manageHook            = myManageHook
        } `removeKeysP` myRemoveKeysP `additionalKeysP` myAdditionalKeysP

startup = do
    setWMName "LG3D"
    spawn "xkbcomp ~/.config/xkb/my $DISPLAY > /dev/null 2>&1"
    spawn "xscreensaver --no-splash"
    spawn "pgrep stalonetray > /dev/null || stalonetray"
    spawn "feh --bg-fill ~/.wallpapers/main"

myLayout = spacing 10 $ 
        Tall 2 (3/100) (1/2)
    ||| noBorders Full

myManageHook = composeAll
    [ className =? "stalonetray"    --> doIgnore <+> doF copyToAll <+> doF swapUp
    , className =? "zoom"           --> doFloat
    , isDialog                      --> doFloat
    , title =? "doFloat"            --> doFloat
    ]

my_terminal :: String
my_terminal = "alacritty"

scrot_dir :: String
scrot_dir = "~/Pictures/"

scrotCmd :: String -> String
scrotCmd flags = "scrot '%s.png' " ++ flags ++ " -e 'xclip -selection clipboard -t image/png \"$f\"; mv $f " ++ scrot_dir ++ "'"

myRemoveKeysP = []

myAdditionalKeysP =
    [ ("M-<Return>", spawn my_terminal)
    , ("M-S-<Return>", windows swapMaster)
    , ("M-p", spawn "rofi -show drun")
    , ("M-w", spawn "rofi -show windows")
    , ("M-d", spawnSelected def ["telegram-desktop", "vk"])
    , ("M-S-z", spawn "xscreensaver-command -lock && systemctl suspend")
    , ("M-z", spawn "xscreensaver-command -lock")
    , ("<Print>",   unGrab *> spawn (scrotCmd ""))
    , ("C-<Print>", unGrab *> spawn (scrotCmd "-u -f"))
    , ("S-<Print>", unGrab *> spawn (scrotCmd "-s -f"))
    ]
