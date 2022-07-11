function ms
    while :
        read input
        if [ -z "$input" ] || [ "$input" = quit ] || [ "$input" = exit ]
            return
        end
        math "$input"
    end
end
