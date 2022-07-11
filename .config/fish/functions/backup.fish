function backup
    if [ (count $argv) = 1 ]
        echo "Backing up $argv[1]"
        mv "$argv[1]"{,.bak}
    else
        echo "No file specified"
    end
end
