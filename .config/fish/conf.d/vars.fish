# === Environment ===
#set -gx GDK_DPI_SCALE -1
#set -gx GDK_SCALE 2
fish_add_path ~/bin
fish_add_path /opt/mssql/bin
fish_add_path ~/.local/bin
fish_add_path ~/.emacs.d/bin/
fish_add_path ~/.gem/ruby/2.7.0/bin
fish_add_path ~/.config/rofi/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/share/android-studio/Sdk/platform-tools/
set -gx GDK_DPI_SCALE 0.5
set -gx GDK_SCALE 2
set -gx QT_AUTO_SCREEN_SCALE_FACTOR 1
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx JAVA_HOME /usr/lib64/jvm/java-11-openjdk
set -gx EDITOR nvim
set -gx LC_ALL en_US.UTF-8
set -gx GOPATH $HOME/.local/share/go
set -gx LESSHISTFILE -
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx TEXMFHOME ~/.texmf
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx LESS -r
# XDG user dirs
# manually set here so that Zoom see it (will it?)
set -gx XDG_DOWNLOAD_DIR $HOME/dl
set -gx XDG_DESKTOP_DIR $HOME/.xdg
set -gx XDG_TEMPLATES_DIR $HOME/.xdg
set -gx XDG_PUBLICSHARE_DIR $HOME/.xdg
set -gx XDG_DOCUMENTS_DIR $HOME/docs
set -gx XDG_MUSIC_DIR $HOME/m
set -gx XDG_PICTURES_DIR $HOME/p
set -gx XDG_VIDEOS_DIR $HOME/v
# prevent double prompts (from script and from theme)
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

set -gx GTK_IM_MODULE fcitx
set -gx QT_IM_MODULE fcitx
set -gx XMODIFIERS @im=fcitx

# GPG
set -gx GPG_TTY (tty)
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

# === Fish Theming ===
set -g  fish_prompt_pwd_dir_length 3

# config_fish Nord Theme
# optionally: https://github.com/arcticicestudio/nord/issues/102
set -U  fish_color_normal normal
set -U  fish_color_command 81a1c1
set -U  fish_color_quote a3be8c
set -U  fish_color_redirection b48ead
set -U  fish_color_end 88c0d0
set -U  fish_color_error ebcb8b
set -U  fish_color_param eceff4
set -U  fish_color_comment 7484a3 #7f91b3 #535d70 #434c5e
set -U  fish_color_match --background=brblue
set -U  fish_color_selection white --bold --background=brblack
set -U  fish_color_search_match bryellow --background=brblack
set -U  fish_color_history_current --bold
set -U  fish_color_operator 00a6b2
set -U  fish_color_escape 00a6b2
set -U  fish_color_cwd green
set -U  fish_color_cwd_root red
set -U  fish_color_valid_path --underline
set -U  fish_color_autosuggestion 5f6c85
set -U  fish_color_user brgreen
set -U  fish_color_host normal
set -U  fish_color_cancel -r
set -U  fish_pager_color_completion normal
set -U  fish_pager_color_description B3A06D yellow
set -U  fish_pager_color_prefix white --bold --underline
set -U  fish_pager_color_progress brwhite --background=cyan
set -U  theme_color_scheme nord
set -U  theme_show_exit_status yes
set -U  theme_date_timezone America/Los_Angeles
set -U  theme_date_format "+%m-%d %H:%M"
#set -g  theme_nerd_fonts yes # i don't like the git icons

# === Paths ===
set -gx sh /media/shared
set -gx v /media/veracrypt1
set -gx rc ~/rc
set -gx rm $rc/m
set -gx rma $rc/x/m/art
set -gx r ~/re
set -gx d $r/dev
set -gx do ~/docs
set -gx t ~/tmp
set -gx hs $do/hs
set -gx s $r/src
set -gx ftc_samples ~/re/dev/UltimateGoal/FtcRobotController/src/main/java/org/firstinspires/ftc/robotcontroller/external/samples
set -g  c_ .COMPLETE_
set -gx cf ~/.config
set -gx o ~/org
set -g  ff ~/.config/fish/functions
set -gx nc ~/.config/nvim

set -gx x /home/oak/x/pico2021

# Config files
set -gx fc $HOME/.config/fish/config.fish
set -gx i3cf $HOME/.config/i3/config
set -gx pbcf $HOME/.config/polybar/config

