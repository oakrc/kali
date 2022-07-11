function yup
    yadm pl
    if [ (count $argv) -ge 2 ]
        yadm add $argv[2..-1]
    end
    yadm au
    if [ "$argv[1]" = "" ]
        yadm upcnf
    else
        yadm cm $argv[1]
    end
    yadm ps
end
