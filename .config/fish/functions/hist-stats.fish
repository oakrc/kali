function hist-stats
    set -l cmds 10
    if [ (count $argv) -gt 0 ]
        set cmds $argv[1]
    end
    history | awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a; }' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n$cmds
end
