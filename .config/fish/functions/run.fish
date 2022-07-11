function run
    set prob $argv[1]
    builtin cd "$d/usaco/$prob" && g++ -o $prob $prob.cpp && rm -f $prob.out && ./$prob && cat $prob.out
end
