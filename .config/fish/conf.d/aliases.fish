#!/usr/bin/env fish

# === Pentest ===
alias sush 'ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"'
alias myip "ip addr show dev tun0 scope global | grep -Po '\b\d+\.\d+\.\d+.\d+(?=/)' | tee /dev/stderr | tr -d '\\n' | xclip; echo Address copied to clipboard"

# === General ===
alias sus "systemctl suspend"
alias fp "fish --private"
alias po "poweroff"
alias bcd "builtin cd"
alias ka killall
alias clear "clear && printf '\e[3J'"
alias isodate "date --iso-8601"
alias m math
alias swp "sudo swapoff -a && sudo swapon -a"
alias wg "wget --hsts-file /dev/null"
alias ys "yadm s"
alias ya "yadm a"
alias yau "yadm au"
alias yp "yadm pl"
alias yd "yadm dc"
alias sp /usr/bin/python3
alias uncache "echo 3 | sudo tee /proc/sys/vm/drop_caches"
alias v nvim
alias p "progress -wm"
alias mpv "DRI_PRIME=1 /usr/bin/mpv"
alias powersave "sudo cpupower frequency-set -g powersave"
alias performance "sudo cpupower frequency-set -g performance"
alias py python3
alias venv "py -m venv"

# === Filesystem ===
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias cdr "cd (git root)"
alias ls 'exa --icons --group-directories-first'
alias l ls
alias ll 'exa --icons -l --group-directories-first'
alias lm 'exa --icons -lhHaim --group-directories-first'
alias la 'exa --icons -ahH --group-directories-first'
alias lz "unzip -l"
alias ma "sudo mount -a"

# Management
alias nrename 'perl-rename -n'
alias rename perl-rename
alias cp 'cp -i --reflink=auto' # btrfs
alias defrag "btrfs fi defrag"
alias mv 'mv -i'
alias rm safe-rm

# Stats
alias dk "df -h -x squashfs -x tmpfs -x devtmpfs"
alias sls "du -skh * | sort -h"
alias slsa "du -skh --apparent-size * | sort -h"
alias slsd "du -skh */ | sort -h"
alias sz "du -skh"
alias sza "du -skh --apparent-size"

# === Editing ===
alias emacs "LC_CTYPE=zh_CN.UTF-8 XMODIFIERS=@im=fcitx /usr/bin/emacs"
alias emf "em -n $fc"
alias em3 "em -n $i3cf"
alias em "XMODIFIERS=@im=none emacsclient"

# Keyboard
alias esc "xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'"
alias caps "xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'"
alias sk "setxkbmap -option caps:swapescape -option altwin:swap_lalt_lwin"

# Quick Edit
alias sc "source $fc"
alias vif "nvim $fc && source $fc"
alias vifa "nvim ~/.config/fish/conf.d/aliases.fish && source ~/.config/fish/conf.d/aliases.fish"
alias vifv "nvim ~/.config/fish/conf.d/vars.fish && source ~/.config/fish/conf.d/aliases.fish"
alias vip "nvim ~/.config/picom.conf"
alias vi3 "nvim $i3cf && i3-msg 'reload' &>/dev/null"

# === Generic Userspace Stuff ===
# i3 and X
alias fhtop "i3-msg 'exec termite -e htop --class floating_term'"
alias notify-send "notify-send.sh"
alias xclip "xclip -selection clipboard"
alias lock "sleep 0.3 && xset dpms force off;i3lockr --blur 25 -- --nofork --ignore-empty-password"
alias i3lock "i3lock -c 000000"
alias fm fc-match
alias fl fc-list
alias getarea "maim -s | xclip -t image/png"
alias pdf zathura
alias img sxiv

# GPG
alias gpgpc "echo RELOADAGENT | gpg-connect-agent" # "password clear"
alias gpgrl gpgpc # ReLoad agent
alias gpgut "echo UPDATESTARTUPTTY | gpg-connect-agent" # "update TTY"

# Applications
alias ch "GDK_DPI_SCALE=0.5 GDK_SCALE=2.25 XDG_CURRENT_DESKTOP=GNOME chromium"
alias br "GDK_DPI_SCALE=0.5 GDK_SCALE=2.25 brave"
alias gns "gnome-screenshot"
alias gnsi "gns -i"
alias intellij "GDK_DPI_SCALE=0.5 GDK_SCALE=3 intellij-idea-ultimate-edition"
alias vmware 'DRI_PRIME=1 vblank_mode=0 GDK_DPI_SCALE=-1 GDK_SCALE=2 /usr/bin/vmware'
alias roamgr "brave --app=http://127.0.0.1:9000 &>/dev/null &disown"
alias kdenlive "DRI_PRIME=1 /usr/bin/kdenlive"
alias thunar "GDK_DPI_SCALE=0.5 GDK_SCALE=2 /usr/bin/thunar"
alias nautilus "GDK_DPI_SCALE=0.5 GDK_SCALE=2.25 /usr/bin/nautilus"
alias vlc "DRI_PRIME=1 /usr/bin/vlc"
alias wp 'wp --path=/srv/http/wolfcorp/'
alias wi "windscribe connect best"
alias wid "windscribe disconnect"
alias wis "windscribe status"

# Music
alias ncmpcpp "float ncmpcpp"
alias spt "LD_PRELOAD=/usr/lib/spotify-adblock.so spotify --force-device-scale-factor=2"
alias ffmpeg "ffmpeg -hide_banner"
alias mscore "PULSE_LATENCY_MSEC=25 /usr/bin/mscore"

# === Programming ===
alias g "git"
alias cmb "cdr && bcd build && cmake .. && make -j8"
alias vtime "/usr/bin/time"
alias adbcon "adb connect rc"
alias adbdis "adb disconnect"
alias adbdev "adb devices"

# === Systemd ===
alias sa "sudo systemctl start"
alias so "sudo systemctl stop"
alias sr "sudo systemctl restart"
alias sst "systemctl status"

# User
alias sua "systemctl --user start"
alias suo "systemctl --user stop"
alias sur "systemctl --user restart"
alias sust "systemctl --user status"

# Quick management
alias saj "sudo systemctl start jellyfin"
alias srj "sudo systemctl restart jellyfin"
alias soj "sudo systemctl stop jellyfin"
alias sam "sudo systemctl start mopidy"
alias srm "sudo systemctl restart mopidy"
alias som "sudo systemctl stop mopidy"

# === Thermal control ===
alias setfan "sudo smbios-thermal-ctl --set"
# No throttling, but overheat easily on my laptop
alias perf "setfan performance"
alias bal "setfan balanced"
# Cooler, but less performant
alias cool "setfan cool-bottom"
alias quiet "setfan quiet"

# === Package management ===
alias pmir "sudo reflector -c 'United States' -a 1 -f 3 --sort rate --save /etc/pacman.d/mirrorlist"
alias pm "sudo pacman"
alias pmi "sudo pacman -S"
alias pmis "sudo pacman -Syu"
alias pmr "sudo pacman -R"
alias yi "yay -S"
alias yis "yay -Syu"

# === Miscellaneous ===
alias cam "mplayer tv://"
alias ledger "/usr/bin/ledger -f $HOME/o/finance.ledger"
alias tlmgr "/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"
alias sck "screenkey --font DejaVu -s small -m -p top"
alias t trans
alias ten "t -t zh-cn"
alias d "t -d"
alias tb "trans -brief"
alias ra "sed 's/\(la\|el\) //'" # Remove Article
alias ratb "ra|tb" # Remove Article Trans Brief
alias gdb "gdb -q"
alias multimc "DRI_PRIME=1 /usr/bin/multimc"
alias bootwin "sudo efibootmgr --bootnext 0003; reboot"
