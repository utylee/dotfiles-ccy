function _fzf_search_git_log --description "Search the output of git log and preview commits. Replace the current token with the selected commit hash."
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_fzf_search_git_log: Not in a git repository.' >&2
    else
        # see documentation for git format placeholders at https://git-scm.com/docs/git-log#Documentation/git-log.txt-emnem
        # %h gives you the abbreviated commit hash, which is useful for saving screen space, but we will have to expand it later below
        set log_fmt_str '%C(bold blue)%h%C(reset) - %C(cyan)%ad%C(reset) %C(yellow)%d%C(reset) %C(normal)%s%C(reset)  %C(dim normal)[%an]%C(reset)'
        set selected_log_line (
            git log --color=always --format=format:$log_fmt_str --date=short | \
            _fzf_wrapper --ansi \
                --tiebreak=index \
                --preview='git show --color=always {1}' \
				--multi \
				--reverse \
                --query=(commandline --current-token) \
                $fzf_git_log_opts
        )

		set paths
		for path in $selected_log_line
			if test $status -eq 0
				#set abbreviated_commit_hash (string split --max 1 " " $selected_log_line)[1]
				set abbreviated_commit_hash (string split --max 1 " " $path)[1]
				set commit_hash (git rev-parse $abbreviated_commit_hash)
				commandline --current-token --replace $commit_hash

				set --append paths $commit_hash
				#set --append paths $path
				#set --append cleaned_paths (string sub --start=4 $path)
			end
		end

        commandline --current-token --replace -- (string escape -- $paths | string join ' ')
    end

    commandline --function repaint
end
