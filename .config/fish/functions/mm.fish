function mm
    while :
        set -l expr
        read expr
        m "$expr"
    end
end
