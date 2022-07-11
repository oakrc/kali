# Defined in /tmp/fish.HjrWNr/nospindown.fish @ line 2
function nospindown
    while sleep 200
        if [ -f $rc/x/wake ]
            date | tee $rc/x/wake || true
        end
    end
end
