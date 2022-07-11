function utrun
    set prob $argv[1]
    builtin cd $d/usaco/$prob
    while :
        nvim $prob.in
        run $prob
        echo -e \n====== END ======
        bass read -n1 -srp "'Press any key to continue'"
        echo -e \n===== BEGIN =====
    end
end
