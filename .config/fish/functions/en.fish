# Defined in /tmp/fish.5MrpFo/en.fish @ line 2
function en
    set query ""
    set len (count $argv)
    for i in (seq 1 $len)
        if test $i -eq 1
            set query "$argv[$i]"
        else
            set query "$query%20$argv[$i]"
        end
    end
    echo "+ querying $query"
    curl https://d.supjohn.com/$query 2>/dev/null
end
