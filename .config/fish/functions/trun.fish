function trun
    set prob $argv[1]
    builtin cd $d/usaco/$prob
    while :
        builtin cd "$d/usaco/$prob" && g++ -O2 -o $prob $prob.cpp && echo -e \n===== BEGIN ===== && ./$prob
        echo
        echo -e \n====== END ======
        bass read -n1 -srp "'Press any key to continue'"
    end
end
