function fzf-dir-utylee-widget -d "List files and folders from (cur | full)directory"
	set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]
    set -l prefix $commandline[3]

    # "-path \$dir'*/\\.*'" matches hidden files/folders inside $dir but not
    # $dir itself, even if hidden.
    test -n "$FZF_ALT_C_COMMAND"; or set -l FZF_ALT_C_COMMAND "
    command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 's@^\./@@'"

	set -l mycommand

	# 현재디렉토리 풀디렉토리를 분리합니다. 저자가 fish를 잘 몰라 fish에선 이게 안되는 것 같습니다
	if [ $dir = '.' ]
		set mycommand $FZF_ALT_C_COMMAND				# 빈 커맨드로 인해 현재 디렉일경우		
	else
		set mycommand $FZF_ALT_C_COMMAND' . $dir'		# 디렉토리를 입력중인 경우	
	end
	#echo $mycommand

    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 50%
    begin
      set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS"
	  eval "$mycommand | "(__fzfcmd)' -m --query "'$fzf_query'"' | while read -l r; set result $result $r; end
    end
    if [ -z "$result" ]
      commandline -f repaint
      return
    else
      # Remove last token from commandline.
      commandline -t ""
    end
    for i in $result
      commandline -it -- $prefix
      commandline -it -- (string escape $i)
      commandline -it -- ' '
    end
    commandline -f repaint
end
