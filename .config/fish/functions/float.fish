#!/usr/bin/env fish

function float
    i3-msg "exec termite -e '$argv' --class floating_term"
end
