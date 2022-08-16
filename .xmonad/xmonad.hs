import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Actions.GridSelect
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Run
import XMonad.StackSet
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CopyWindow
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

main = do
    xmonad $ ewmhFullscreen $ ewmh def
        { terminal              = my_terminal
        , modMask               = mod4Mask
        , layoutHook            = myLayout
        , startupHook           = startup
        , borderWidth           = 2
        , normalBorderColor     = "gray"
        , focusedBorderColor    = "orange"   
        , manageHook            = myManageHook
        } `removeKeysP` myRemoveKeysP `additionalKeysP` myAdditionalKeysP

startup = do
    setWMName "LG3D"
    spawn "xkbcomp ~/.config/xkb/my $DISPLAY > /dev/null 2>&1"
    spawn " \
        \XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
        \XSECURELOCK_IMAGE_DURATION_SECONDS=1000 \
        \XSECURELOCK_LIST_VIDEOS_COMMAND=\"echo /home/kotfind/.lock_wallpaper\" \
        \XSECURELOCK_SAVER=saver_mpv \
        \xss-lock xsecurelock"
    spawn "pgrep stalonetray > /dev/null || stalonetray --geometry 5x1-0-0 --icon-size 20 --background \"#000000\""
    spawn "feh --bg-fill ~/.wallpaper"

myLayout =
    spacing (gapSize `div` 2)  $
    gaps ((\d -> (d, gapSize `div` 2)) <$> [U, D, R, L]) $

        Tall 1 (3/100) (1/2)
    ||| noBorders Full
      where
       gapSize = 5 :: Int

myManageHook = composeAll
    [ className =? "stalonetray"    --> doIgnore <+> doF copyToAll
    , className =? "zoom"           --> doFloat
    , className =? "learning_graph" --> doFloat
    , isDialog                      --> doFloat
    , title =? "doFloat"            --> doFloat
    ]

my_terminal :: String
my_terminal = "kitty"

scrot_dir :: String
scrot_dir = "~/Pictures/"

scrotCmd :: String -> String
scrotCmd flags = "scrot '%s.png' " ++ flags ++ " -e 'xclip -selection clipboard -t image/png \"$f\"; mv $f " ++ scrot_dir ++ "'"

myRemoveKeysP = []

myAdditionalKeysP =
    [ ("M-<Return>", spawn my_terminal)
    , ("M-S-<Return>", windows swapMaster)
    , ("M-p", spawn "rofi -show drun -modi drun")
    , ("M-w", spawn "rofi -show window")
    , ("M-d", spawnSelected def ["telegram-desktop", "vk"])
    , ("M-z", spawn "loginctl lock-session")
    , ("M-S-z", spawn "systemctl suspend -i")
    , ("M-C-S-z", spawn "systemctl hibernate -i")
    , ("<Print>",   unGrab *> spawn (scrotCmd ""))
    , ("C-<Print>", unGrab *> spawn (scrotCmd "-u -f"))
    , ("S-<Print>", unGrab *> spawn (scrotCmd "-s -f"))
    ]
