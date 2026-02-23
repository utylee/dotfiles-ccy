# 가장최초에 실행돼야 daenney/pyenv 가 의미있다고 합니다
#if status is-interactive
if status is-login
	set PYENV_ROOT $HOME/.pyenv
	#set -gx PATH $PYENV_ROOT/shims $PATH
	set -gx PATH $PYENV_ROOT/bin $PATH
end
