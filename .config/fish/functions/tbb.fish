#!/usr/bin/env fish

function tbb
    #set -l a
    while read line
        echo $line: (trans -brief "$line")
    end
end
