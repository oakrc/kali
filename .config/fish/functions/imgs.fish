function imgs
    for f in **.jpg
        img $f
    end

    for f in **.jpeg
        img $f
    end

    for f in **.JPG
        img $f
    end
end
