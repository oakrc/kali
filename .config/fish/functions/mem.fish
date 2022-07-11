function mem
    ps -A --sort -rss -o comm,rss | grep -i $argv[1] | awk '{ sum+=$2 } END { printf "%.2f GiB", sum/1024/1000 }'
end
