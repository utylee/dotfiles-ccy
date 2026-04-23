if status is-interactive
	# CURSOR
	#echo -ne '\eP\e]13;#5F5FAF\a'   # HC1
	# echo -ne '\eP\e]12;#79bda4\a'   # HC1
	echo -ne '\eP\e]12;#e87272\a'   # ccy
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
set -gx LLS_MODELS_DIR /home/utylee/temp/llm_models/
set -gx LLS_LLAMA_BIN  /home/utylee/temp/llama.cpp/build-vk/bin/llama-server

# 1. 아키텍처 속이기 (11.0.0 또는 11.0.3 시도)
set -x HSA_OVERRIDE_GFX_VERSION 11.0.0

# 2. SDMA 비활성화 (세그폴트 방지의 핵심!)
set -x HSA_ENABLE_SDMA 0
# set -x HSA_ENABLE_SDMA 1

# 이것도 세그폴트 원인??
# set -x PYTORCH_CUDA_ALLOC_CONF "expandable_segments:True"
# set -x PYTORCH_CUDA_ALLOC_CONF "expandable_segments:True,max_split_size_mb:256,garbage_collection_threshold:0.8"
set -x PYTORCH_CUDA_ALLOC_CONF "expandable_segments:True,max_split_size_mb:64,garbage_collection_threshold:0.8"
set -x PYTORCH_HIP_ALLOC_CONF "expandable_segments:True,max_split_size_mb:64,garbage_collection_threshold:0.8"
# set -x PYTORCH_CUDA_ALLOC_CONF expandable_segments:False

## 3. 메모리 파편화 방지 (16GB 램용 최적값)
#set -x PYTORCH_HIP_ALLOC_CONF "garbage_collection_threshold:0.6,max_split_size_mb:128"

##GPU(=RAM) 최대한 사용 허용
## set -x GPU_MAX_HEAP_SIZE 100
#set -x GPU_MAX_HEAP_SIZE 50

## z1 extreme 
##gfx1103
#set -x HSA_OVERRIDE_GFX_VERSION 11.0.0

# # PyTorch가 한 번에 가져갈 수 있는 램의 단위를 극단적으로 줄입니다.  64MB 단위로 쪼개서 쓰고, 안 쓰면 즉시 반납하게 합니다.
# set -x PYTORCH_HIP_ALLOC_CONF "max_split_size_mb:64,garbage_collection_threshold:0.5,expan  dable_segments:True"
# set -x PYTORCH_CUDA_ALLOC_CONF "max_split_size_mb:64,garbage_collection_threshold:0.5,expa  ndable_segments:True"

# # 리눅스 커널에게 메모리 반환을 강제합니다 (CachyOS 필수)
# set -x MALLOC_CONF "dirty_decay_ms:0,muzzy_decay_ms:0"


set -x LANG ko_KR.UTF-8
set -x LANGUAGE ko_KR:ko
set -x LC_ALL ko_KR.UTF-8

# /tmp 용량부족으로 대용량 파일 설치시 문제가 생겨 /mnt/win 을 지정해줍니다
# set -x TMPDIR $HOME/temp/.pip-tmp
# set -x PIP_CACHE_DIR $HOME/temp/.pip-cache
set -x TMPDIR $HOME/.pip-tmp
set -x PIP_CACHE_DIR $HOME/.pip-cache

# PATH
#set CLANGHOME /usr/local/clang-14-dev
#set CLANGHOME /usr/local/clang+llvm-12.0.1-armv7a-linux-gnueabihf
#set CLANGHOME /usr/local/clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04
# set -l NODEHOME /usr/local/node-v22.18.0-linux-armv7l
# set -l NODEHOME /usr/local/node-v22.18.0-linux-x64
set -l NODEHOME /usr/local/node-v22.22.0-linux-x64
# set -x PATH $CLANGHOME/bin $PATH
set -x PATH $HOME/.go/bin /usr/local/go1.17.3/bin $NODEHOME/bin $PATH

fish_add_path /home/utylee/temp/opencode/packages/opencode/dist/opencode-linux-x64/bin /home/utylee/temp/llama.cpp/build-vk/bin /home/utylee/temp/bin 
#set -gx CC $CLANGHOME/bin/clang
#set -gx CXX $CLANGHOME/bin/clang++
# set -gx LD_LIBRARY_PATH /home/utylee/temp/llama.cpp/build-vk/bin $LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH /opt/rocm/lib /opt/rocm/lib/migraphx/lib $LD_LIBRARY_PATH

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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
