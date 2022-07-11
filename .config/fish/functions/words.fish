function words
    set essay '-'
    while [ -n "$essay" ]
        read essay
        set result (echo "$essay" | wc -w)
        echo "$result words"
    end
end

