#!/usr/bin/env fish

function wh
    which $argv[1]
    ls -l $argv[1]
end
