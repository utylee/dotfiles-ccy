function fzf-lls-model-widget -d "Pick GGUF model (local/ssh aware, NO eval)"
    set -l commandline (__fzf_parse_commandline)
    set -l fzf_query $commandline[2]
    set -l prefix $commandline[3]

    set -l full (string trim -- (commandline))
    set -l first (string split -m1 ' ' -- $full)[1]

    # 기본값
    set -l host local
    set -l rdir "/home/utylee/temp/llm_models"

    if test (uname) = Darwin
        set rdir "/Users/utylee/temp/llm_models"
    end

    if set -q LLS_MODELS_DIR
        set rdir "$LLS_MODELS_DIR"
    end

    switch $first
        case llm
            set host mac
            set rdir "/Users/utylee/temp/llm_models"
            if set -q LLS_MODELS_DIR
                set rdir "$LLS_MODELS_DIR"
            end

        case llh
            set host halo
            if set -q LLS_MODELS_DIR
                set rdir "$LLS_MODELS_DIR"
            end

        case llw
            set host wsl12
            if set -q LLS_MODELS_DIR
                set rdir "$LLS_MODELS_DIR"
            end

		case '*'
			# ✅ 알 수 없는 커맨드/빈 라인에서도 lls 기준으로 동작하게 강제
			set host local
			set first lls
			# set prefix "lls start "

			# 선택한 모델(예: phi-4-IQ4_NL.gguf)
			set -l m "$selected"

			# 현재 커맨드라인 전체
			set -l cl (commandline)

			# 이미 lls start로 시작하면 모델만 교체/삽입
			if string match -qr '^\s*lls\s+start(\s|$)' -- $cl
				# "lls start <기존모델.gguf>" 형태면 모델만 교체
				set -l newcl (string replace -r '(^\s*lls\s+start\s+)(\S+\.gguf)?' "\$1$m" -- $cl)

				if test "$newcl" = "$cl"
					# 모델 토큰이 없던 경우: 뒤에 추가
					commandline --append " $m"
				else
					commandline --replace "$newcl"
				end
			else
				# 새로 시작하는 경우
				commandline --replace "lls start $m"
			end

			# 커서 맨 끝
			commandline --cursor (string length (commandline))
    end

    # ✅ candidates 생성 (핵심 안정 영역 🔥)
    set -l candidates

    if test "$host" = local
        set candidates (find "$rdir" -maxdepth 1 -type f -name "*.gguf" -print 2>/dev/null | \
            while read -l p
                basename "$p"
            end)
    else
        set candidates (command ssh $host find "$rdir" -maxdepth 1 -type f -name "*.gguf" -print 2>/dev/null | \
            while read -l p
                basename "$p"
            end)
    end

    if test (count $candidates) -eq 0
        echo "NO MODELS FOUND: $rdir"
        commandline -f repaint
        return
    end

    set -l preview_cmd "$first show-profile {}"

    begin
        test -n "$FZF_TMUX_HEIGHT"; or set -g FZF_TMUX_HEIGHT 50%
        set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse"

        set -l choice (printf '%s\n' $candidates | command fzf \
            --query "$fzf_query" \
            --preview "$preview_cmd" \
            --preview-window 'right,40%,wrap')

        if test -n "$choice"
            set result $choice
        end
    end

    if test -z "$result"
        commandline -f repaint
        return
    end

    commandline -t ""
    commandline -it -- $prefix
    commandline -it -- (string escape $result)
    commandline -it -- ' '
    commandline -f repaint
end
