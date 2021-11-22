import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Actions.GridSelect
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

defaults = def
    { terminal              = my_terminal
    , modMask               = mod4Mask
    , handleEventHook       = fullscreenEventHook
    , startupHook           = startup
    , borderWidth           = 2
    , normalBorderColor     = "black"
    , focusedBorderColor    = "orange"   
    } `removeKeysP` myRemoveKeysP `additionalKeysP` myAdditionalKeysP

startup = do
    setWMName "LG3D"
    spawn "xkbcomp ~/.config/xkb/my $DISPLAY > /dev/null 2>&1"
    spawn "xscreensaver --no-splash"

my_terminal :: String
my_terminal = "alacritty"

scrot_dir :: String
scrot_dir = "~/Pictures/"

scrotCmd :: String -> String
scrotCmd flags = "scrot '%s.png' " ++ flags ++ " -e 'mv $f " ++ scrot_dir ++ "' | tr -d '\n' | xclip -selection clipboard"
myRemoveKeysP = [ "M-S-<Return>" ]

myAdditionalKeysP =
    [ ("M-<Return>", spawn my_terminal)
    , ("M-s", spawnSelected def ["telegram-desktop", "vk"])
    , ("M-S-z", spawn "xscreensaver-command -lock")
    , ("<Print>",   unGrab *> spawn (scrotCmd ""))
    , ("C-<Print>", unGrab *> spawn (scrotCmd "-u -f"))
    , ("S-<Print>", unGrab *> spawn (scrotCmd "-s -f"))
    ]

main = xmonad defaults
