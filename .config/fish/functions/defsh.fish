function defsh
    while true
        read -p 'set_color green; echo -n "Query word >> "' word
        def "$word"
    end
end
