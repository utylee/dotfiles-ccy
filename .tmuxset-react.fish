# vMISC라는 이름을 가진 윈도우를 생성하고 vim을 실행시킵니다
tmux new-window -d -n vRaCT

# 수평분할을 25%로 합니다 
tmux split-window -d -t vRaCT -v -p 25  #"workon misc"


tmux select-window -t vRaCT

tmux send-keys -t vRaCT.0 "source ~/.virtualenvs/react/bin/activate.fish" Enter
tmux send-keys -t vRaCT.1 "source ~/.virtualenvs/react/bin/activate.fish" Enter
sleep 0.5
tmux send-keys -t vRaCT.0 "cd ~/.virtualenvs/react/src" Enter
tmux send-keys -t vRaCT.0 "vi" Enter
tmux send-keys -t vRaCT.1 "cd ~/.virtualenvs/react/src" Enter "clear" Enter
#sleep 2 
#tmux send-keys -t vRaCT.0 ":Virtu" Tab Space "misc" Enter
#sleep 0.5
#tmux send-keys -t vRaCT.0 ":cd ~/.virtualenvs/misc/src" Enter

##misc-3.6을 가리키게 합니다. pyenv와 virtualenvwrapper를 통해 python3.6을 설치해보았습니다
##tmux send-keys -t vMISC.1 "workon 3.4test" Enter
##tmux send-keys -t vMISC.0 "vf activate misc" Enter
##tmux send-keys -t vMISC.0 "vf cd" Enter
##tmux send-keys -t vMISC.0 "cd src" Enter
#tmux send-keys -t vMISC.0 "source ~/.virtualenvs/misc/bin/activate.fish" Enter
#tmux send-keys -t vMISC.0 "cd ~/.virtualenvs/misc/src" Enter
#tmux send-keys -t vMISC.0 "vi" Enter
#tmux send-keys -t vMISC.1 "source ~/.virtualenvs/misc/bin/activate.fish" Enter
##tmux send-keys -t vMISC.1 "vf activate  misc" Enter
#tmux send-keys -t vMISC.0 ":Virtu" Tab Space "misc" Enter
#tmux send-keys -t vMISC.0 ":cd ~/.virtualenvs/misc/src" Enter
#tmux send-keys -t vMISC.1 "cd ~/.virtualenvs/misc/src" Enter "clear" Enter
##tmux send-keys -t vMISC.1 "vf cd" Enter "cd src" Enter "clear" Enter
#
#tmux select-window -t vMISC
#
#
##;cdvirtualenv;cd src"
## 기존 pane을 선택하고 VirtualEnv를 활성화시킵니다.
##tmux send-keys C-k
##tmux send-keys "vim"
##tmux send-keys ":VirtualEnvActivate misc"
#
## 새로 분할된 pane을 선택하고 해당(misc) virtualenv로 이동합니다
##tmux select-pane -t1
#
##tmux select-layout -t vMISC tiled
