if status is-interactive
	# CURSOR
	#echo -ne '\eP\e]13;#5F5FAF\a'   # HC1
	echo -ne '\eP\e]12;#79bda4\a'   # HC1
	# echo -ne '\eP\e]12;#679e8a\a'   # HC1
	# echo -ne '\eP\e]12;#53cfcc\a'   # HC1
	#echo -ne '\eP\e]12;#6d207a\a'	# HC2
	set fish_greeting ''
	fish_vi_key_bindings
	starship init fish | source
end
if status is-login
    # Commands to run in interactive sessions can go here
	eval (dircolors -c ~/.dircolors)
end

#echo -ne '\eP\e]12;#6d207a\a'	# HC2
#set -g fish_key_bindings fish_vi_key_binding

set -U fish_history_max 200000

set -Ux fish_term24bit 1

set -gx EDITOR /usr/bin/vi
set -gx GHQ_ROOT /home/utylee/.ghq

# for llama-server of wsl2 ssh
set -gx LLS_MODELS_DIR /home/utylee/temp/llm_models
set -gx LLS_LLAMA_BIN  /home/utylee/temp/llama.cpp/build-vk/bin/llama-server

set -x LANG ko_KR.UTF-8
set -x LANGUAGE ko_KR:ko
set -x LC_ALL ko_KR.UTF-8

# PATH
#set CLANGHOME /usr/local/clang-14-dev
#set CLANGHOME /usr/local/clang+llvm-12.0.1-armv7a-linux-gnueabihf
#set CLANGHOME /usr/local/clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04
# set -l NODEHOME /usr/local/node-v22.18.0-linux-armv7l
# set -l NODEHOME /usr/local/node-v22.18.0-linux-x64
set -l NODEHOME /usr/local/node-v22.22.0-linux-x64
# set -x PATH $CLANGHOME/bin $PATH
set -x PATH $HOME/.go/bin /usr/local/go1.17.3/bin $NODEHOME/bin $PATH

fish_add_path /home/utylee/temp/bin  /home/utylee/temp/llama.cpp/build-vk/bin
#set -gx CC $CLANGHOME/bin/clang
#set -gx CXX $CLANGHOME/bin/clang++
#set -gx LD_LIBRARY_PATH $CLANGHOME/lib $LD_LIBRARY_PATH 

# FZF
# fzf을 직접입력해 파일명 탐색 명내용 
set -gx FZF_DEFAULT_COMMAND 'fd --type file --color=always --follow --hidden --exclude .git'
set -gx FZF_DEFAULT_OPTS "--ansi"
#
#set -gx FZF_CTRL_T_COMMAND "fd --type d --hidden --color=always"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_CTRL_F_COMMAND "fd --type d --hidden --color=always . $HOME"
set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --color=always"
set -gx FZF_CTRL_R_OPTS "--reverse --height 100%"
#set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

#set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --no-ignore"
#set -gx FZF_CTRL_T_COMMAND "rg --files --hidden --follow --no-ignore"
#set -gx FZF_CTRL_T_COMMAND "rg --files --hidden --follow --no-ignore"
#set -gx FZF_ALT_C_COMMAND "find . -depth"
##set -gx FZF_ALT_C_COMMAND "rg --hidden --files --null | xargs -0 dirname | uniq"
##set -gx FZF_ALT_C_COMMAND "rg --hidden --sort-files --files --null 2> /dev/null | xargs -0 dirname | uniq"
#
# VENV
set -gx WORKON_HOME $HOME/.virtualenvs

#source ~/.mintty-colors-solarized/mintty-solarized-dark.sh
