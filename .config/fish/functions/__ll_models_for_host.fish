function __ll_models_for_host -d "List GGUF models on remote host via ssh (mac/linux compatible)"
    set -l host $argv[1]

    set -l fallback "/home/utylee/temp/llm_models"
    # if test "$host" = mac 
    # if [ "$host" = mac ] or [ "$host" = mac2 ]
	if test "$host" = "mac" -o "$host" = "mac2"
        set fallback "/Users/utylee/temp/llm_models"
    end

    set -l bash_script "
dir=\"\${LLS_MODELS_DIR:-$fallback}\"
find \"\$dir\" -maxdepth 1 -type f -name \"*.gguf\" -print 2>/dev/null |
  while IFS= read -r p; do basename \"\$p\"; done
"

    # printf '%s\n' "$bash_script" | command ssh $host bash -s --
	printf '%s\n' "$bash_script" | command ssh $host bash -s -- 2>/dev/null
end



# function __ll_models_for_host -d "List GGUF models on remote host via ssh (mac/linux compatible)"
#     set -l host $argv[1]

#     # fallback dir (host별)
#     set -l fallback "/home/utylee/temp/llm_models"
#     if test "$host" = mac
#         set fallback "/Users/utylee/temp/llm_models"
#     end

#     # ⚠️ bash 스크립트는 stdin으로 전달 (따옴표/if/fi 절대 안 깨짐)
#     set -l bash_script '
# dir="${LLS_MODELS_DIR:-'"$fallback"'}"
# find "$dir" -maxdepth 1 -type f -name "*.gguf" -print 2>/dev/null \
#   | while IFS= read -r p; do basename "$p"; done
# '

#     command ssh -o BatchMode=yes -o ConnectTimeout=2 $host bash -s -- <<<"$bash_script"
# end


# function __ll_models_for_host -d "List GGUF models on remote host via ssh (mac/linux compatible)"
#     set -l host $argv[1]

#     # fallback dir (host별)
#     set -l fallback "/home/utylee/temp/llm_models"
#     if test "$host" = mac
#         set fallback "/Users/utylee/temp/llm_models"
#     end

#     # bash 스크립트(표준입력으로 전달)
#     set -l bash_script "
# dir=\"\${LLS_MODELS_DIR:-$fallback}\"
# find \"\$dir\" -maxdepth 1 -type f -name \"*.gguf\" -print 2>/dev/null |
#   while IFS= read -r p; do basename \"\$p\"; done
# "

#     # fish에는 <<< 가 없으므로 pipe로 전달
#     printf '%s\n' "$bash_script" | command ssh -o BatchMode=yes -o ConnectTimeout=2 $host bash -s --
# end

# function __ll_models_for_host -d "List GGUF models on remote host via ssh (mac/linux compatible)"
#     set -l host $argv[1]

#     # 원격에서 LLS_MODELS_DIR 있으면 그걸 쓰고, 없으면 fallback
#     set -l fallback "/home/utylee/temp/llm_models"
#     if test $host = mac
#         set fallback "/Users/utylee/temp/llm_models"
#     end

#     set -l script "dir=\"$fallback\"; if [ -n \"\$LLS_MODELS_DIR\" ]; then dir=\"\$LLS_MODELS_DIR\"; fi; find \"\$dir\" -maxdepth 1 -type f -name \"*.gguf\" -print 2>/dev/null | xargs -n1 basename 2>/dev/null"
#     command ssh $host bash -lc "$script"
# end



# function __ll_models_for_host --description "List GGUF models on a remote host via ssh"
#     set -l host $argv[1]

#     # host별 default dir
#     set -l default_dir "/home/utylee/temp/llm_models"
#     if test "$host" = "mac"
#         set default_dir "$HOME/temp/llm_models"
#     end

#     # 기본 커맨드 템플릿 (DEFAULT_DIR만 치환)
#     set -l remote_cmd 'if [ -n "$LLS_MODELS_DIR" ]; then dir="$LLS_MODELS_DIR"; else dir="DEFAULT_DIR"; fi; find "$dir" -maxdepth 1 -type f -name "*.gguf" -printf "%f\n" 2>/dev/null'

#     # DEFAULT_DIR 치환 (경로에 공백 없다는 전제라 안전)
#     set remote_cmd (string replace -a "DEFAULT_DIR" $default_dir -- $remote_cmd)

#     # ssh에는 "한 덩어리"로 전달해야 함
#     command ssh $host "$remote_cmd"
# end



# function __ll_models_for_host --description "List GGUF models on a remote host via ssh"
#     set -l host $argv[1]

#     # host별 default dir
#     set -l default_dir "/home/utylee/temp/llm_models"
#     if test "$host" = "mac"
#         set default_dir "$HOME/temp/llm_models"
#     end

#     set -l remote_cmd "if [ -n \"\$LLS_MODELS_DIR\" ]; then dir=\"\$LLS_MODELS_DIR\"; else dir=\"$default_dir\"; fi; find \"\$dir\" -maxdepth 1 -type f -name '*.gguf' -printf '%f\n' 2>/dev/null"
#     command ssh $host $remote_cmd
# end

