function gitd
    bcd $d
    git clone --recursive $argv[1]
    bcd (basename $argv[1])
end
