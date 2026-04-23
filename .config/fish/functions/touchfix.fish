function touchfix
	set -lx DISPLAY :0
    # set -lx XAUTHORITY (ls /run/user/1000/xauth_* 2>/dev/null | head -n1)

	kscreen-doctor output.66.rotation.left
	# set -l envline (ps eww -C plasmashell | head -n1)

    # set -l disp (string match -r -g 'DISPLAY=[^ ]+' -- $envline | string replace 'DISPLAY=' '')
    # set -l xauth (string match -r -g 'XAUTHORITY=[^ ]+' -- $envline | string replace 'XAUTHORITY=' '')

    # if test -z "$disp"
        # echo "DISPLAY not found from plasmashell"
        # return 1
    # end

    # if test -z "$xauth"
        # echo "XAUTHORITY not found from plasmashell"
        # return 1
    # end

    # set -lx DISPLAY $disp
    # set -lx XAUTHORITY $xauth


end
