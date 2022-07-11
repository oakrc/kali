function gits
    bcd $s
    git clone --depth 1 $argv[1]
    bcd (basename $argv[1])
end
