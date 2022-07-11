function f2m
    set input $argv[1]
    set output $argv[2]
    if [ -z "$input" ]
        echo "Usage: $_ flac [ mp3 ]"
        return
    end
    if [ -z "$output" ]
        set output (echo $argv[1] | sed 's/\.[^.]*$//').mp3
    end
    mkdir -p (dirname "$output")
    ffmpeg -i $input -ab 320k $output
end
