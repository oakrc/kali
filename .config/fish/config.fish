function fish_greeting
end

gpgconf --launch gpg-agent

if [ -n "$DISPLAY" -a "$TERM" != xterm-termite -a "$TERM" != xterm-kitty -a "$TERM" != tmux-256color -a -z "$TMUX" ] && status --is-interactive
    tmux ls | grep -vq '(attached)' && exec tmux a || exec tmux
end
