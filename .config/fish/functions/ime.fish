function ime
    i3-msg 'resize set height 50px'
    read -p '' input
    copyq copy "$input"
    i3-msg 'focus mode_toggle'
    copyq paste
end

