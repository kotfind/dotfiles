# ibus
export GTK_IM_MODULE='ibus'
export QT_IM_MODULE='ibus'
export XMODIFIERS='@im=ibus'

## uncomment to enable dark theme
# # theme
# export GTK_THEME=Adwaita:dark
# export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
# export QT_STYLE_OVERRIDE=Adwaita-Dark

# for some java gui apps to work:
export _JAVA_AWT_WM_NONREPARENTING=1

# dwm
exec bspwm 2> ~/.bspwm.log
