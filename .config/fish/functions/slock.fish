# Defined in /tmp/fish.cnXW7V/slock.fish @ line 2
function slock
    sleep 0.3 && xset dpms force off
    i3lock -c 000000
end
