function fkillsudo
	# src origin from https://github.com/halostatue/fish-fzf/blob/master/functions/fkill.fish
    set -l signal -9 

    set -l pid
    set pid (ps -eF | sed 1d | fzf -m --reverse --height 40% | awk '{ print $2; }')

	#echo $pid | xargs sudo kill $signal
	# sudo에서 여러개를 한꺼번에 죽일 일은 없을 것 같지만 어쨌거나 아래 코드는 쓸데 없는 것
	#	같이 일단 주석처리로 보존은 해놓습니다
	test -z "$pid"
	or echo $pid | xargs sudo kill $signal

	commandline -f repaint
end
