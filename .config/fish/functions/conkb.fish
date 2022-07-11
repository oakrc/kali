function conkb
    bluetoothctl -- remove 34:88:5D:CE:F4:50 &>/dev/null
    bluetoothctl -- scan on &>/dev/null &
    echo Waiting for scanning...
    sleep 3
    killall bluetoothctl
    echo Waiting for scanning... Done.
    bluetoothctl -- pair 34:88:5D:CE:F4:50
    bluetoothctl -- connect 34:88:5D:CE:F4:50
    echo Connected to keyboard
    sk
end
