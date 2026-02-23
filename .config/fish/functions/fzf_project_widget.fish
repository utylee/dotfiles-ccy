function fzf_project_widget
	cd (fd --type d --hidden --color=always . $HOME/.virtualenvs $HOME/temp $HOME/.ghq | fzf --height 50% --reverse)
	commandline -t ""
	commandline -it -- $prefix
    commandline -f repaint
end
