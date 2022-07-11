function mkch
    if test -d "~/x/$argv[1]"
        echo $HOME/x/$argv[1] already exists >&2
        return 1
    end
    cp -r ~/x/template "~/x/$argv[1]"
end
