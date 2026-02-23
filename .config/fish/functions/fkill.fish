function fkill
	# src origin from https://github.com/halostatue/fish-fzf/blob/master/functions/fkill.fish
    set -l signal -9 
    test -z $argv[1]
    or set signal $argv[1]

    set -l uid (id -u)
    set -l pid
    if test $uid -ne 0
        set pid (ps -f -u $uid | sed 1d | fzf -m --reverse --height 40% | awk '{ print $2; }')
    else
        set pid (ps -ef | sed 1d | fzf -m --reverse --height 40% | awk '{ print $2; }')
    end

	#echo $pid | xargs kill $signal
	test -z "$pid"
	or echo $pid | xargs kill $signal
	commandline -f repaint
end
