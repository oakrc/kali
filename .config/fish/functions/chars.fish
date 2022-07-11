function chars
    set essay '-'
    while [ -n "$essay" ]
        read essay
        set result (echo "$essay" | wc -c)
        echo "$result characters"
    end
end

