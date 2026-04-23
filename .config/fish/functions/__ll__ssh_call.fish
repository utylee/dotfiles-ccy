function __ll__pick_remote_model
    set -l host $argv[1]
    command ssh $host lls list --ids | fzf --height 40% --layout=reverse --border --prompt="model> "
end

function __ll__pick_remote_running_model
    set -l host $argv[1]
    command ssh $host lls status --ids | fzf --height 40% --layout=reverse --border --prompt="stop> "
end

function __ll__ssh_call
    set -l host $argv[1]
    set -e argv[1]

	if test (count $argv) -ge 1
        switch $argv[1]
            case start
                if test (count $argv) -eq 1
                    set -l chosen (__ll__pick_remote_model $host)
                    test -n "$chosen"; or return 1
                    command ssh $host lls start "$chosen"
                    return $status
                else if test (count $argv) -eq 2; and test "$argv[2]" = "-d"
                    set -l chosen (__ll__pick_remote_model $host)
                    test -n "$chosen"; or return 1
                    command ssh $host lls start -d "$chosen"
                    return $status
				else if test (count $argv) -eq 3; and test "$argv[2]" = "-d"; and string match -qr '^[0-9]+$' -- "$argv[3]"
					set -l slot $argv[3]
					set -l chosen (__ll__pick_remote_model $host)
					test -n "$chosen"; or return 1
					command ssh $host lls start -d $slot "$chosen"
					return $status
				end

			case stop
                if test (count $argv) -eq 1
                    command ssh -q -t $host lls stop
                    return $status
                end
			# case stop
                # if test (count $argv) -eq 1
                    # set -l chosen (__ll__pick_remote_running_model $host)
                    # test -n "$chosen"; or return 1
                    # command ssh $host lls stop "$chosen"
                    # return $status
                # end

			case log
                if test (count $argv) -eq 1
                    command ssh -q -t $host lls log
                    return $status
                else if test (count $argv) -eq 2; and test "$argv[2]" = "-f"
                    command ssh -q -t $host lls log -f
                    return $status
                else if test (count $argv) -eq 2; and string match -qr '^[0-9]+$' -- "$argv[2]"
                    command ssh -q -t $host lls log $argv[2]
                    return $status
                else if test (count $argv) -eq 3; and string match -qr '^[0-9]+$' -- "$argv[2]"; and test "$argv[3]" = "-f"
                    command ssh -q -t $host lls log $argv[2] -f
                    return $status
                end

			case show-profile
                if test (count $argv) -eq 1
                    set -l chosen (__ll__pick_remote_model $host)
                    test -n "$chosen"; or return 1
                    command ssh $host lls show-profile "$chosen"
                    return $status
                end
        end
    end

    command ssh $host lls $argv

end
