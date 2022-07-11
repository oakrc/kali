function kill-gpu
    ps aux | grep gpu-process | grep $argv[1] | egrep -oe "[0-9]+" | head -n 1 | xargs -p kill
end

