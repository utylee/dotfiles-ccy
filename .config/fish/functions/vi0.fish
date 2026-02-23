function vi0
	set filename $PWD/$argv[1]
	tmux send-keys -t 0 ":e $filename" C-m
	tmux select-pane -t 0

	# 원래 방법입니다
	#tmux send-keys -t vBLOG.0 ":e $filename" C-m
	#tmux select-window -t vBLOG
	#tmux select-pane -t vBLOG.0

	# 윈도우 이름을 구하고 해봤는데 의미는 없습니다
	#set -l curWin (tmux display-message -p "#W")
	#tmux send-keys -t $curWin.0 ":e $filename" C-m
	#tmux select-window -t $curWin
	#tmux select-pane -t $curWin.0
end
