function sync-dir
    set -l cwd (pwd)
    builtin cd
    set -l path (realpath $argv[1] --relative-to $HOME)
    echo "Synchronizing $path..."
    grive -P -s $path
    builtin cd $cwd
end
