function fish_user_key_bindings
	fzf_key_bindings
	bind \cfa fzf-file-utylee-widget		# 원래대로 파일명을 검색하는 명령어입니다 (현재디렉토리부터)
	bind \cff fzf-dir-utylee-widget		# 아래 f 와 연동하여 g로 지정했지만 alt-c 의 단축키를 변경한 거
	bind \cw fzf_project_widget		# 'w'orkspace 에서 w를 쓰기로 합니다
	bind \cs fzf-history-widget		# command history 단축키를 덮어씌웁니다
	bind \cgg _fzf_search_git_log    #
	bind \cga _fzf_search_git_status #
	bind \cfk fkill

	#bind \ct fzf-file-full_widget	#    (풀 디렉토리에서 검색하는 명령어를 따로 만듭니다)
	#bind \cf fzf_cur_dir_widget		# 아래 f 와 연동하여 g로 지정했지만 alt-c 의 단축키를 변경한 거
	#bind \cg fzf_full_dir_widget	# 'f'ull 의 의미로 씁니다. $HOME부터의 절대경로를 표시합니다

	# ctrl+s 를 command history에 양보합니다. 
	#bind \cs 'rg . --pretty | fzf'  # 파일내부를 검색하는 명령입니다 

    # vi 입력모드에서의 동작을 위해 넣어줍니다
    if bind -M insert > /dev/null 2>&1
		bind -M insert \cfa	fzf-file-utylee-widget
		bind -M insert \cff fzf-dir-utylee-widget       #
		bind -M insert \cw	fzf_project_widget
		bind -M insert \cs	fzf-history-widget		
		bind -M insert \cgg _fzf_search_git_log
		bind -M insert \cga _fzf_search_git_status
		bind -M insert \cfk fkill

		#bind -M insert \cs 'rg . --pretty | fzf'
		#bind -M insert \cf fzf_cur_dir_widget			# 
		#bind -M insert \cg fzf_full_dir_widget
		#bind -M insert \ct fzf-file-full_widget
    end
end
