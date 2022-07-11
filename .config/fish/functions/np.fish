function np
    builtin cd $d/usaco/
    set prob $argv[1]
    mkdir $prob
    cp "$argv[2]"template.cpp $prob/$prob.cpp
    builtin cd $prob
end
