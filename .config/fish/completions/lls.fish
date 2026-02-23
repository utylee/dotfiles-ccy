# ~/.config/fish/completions/lls.fish

function __lls_models_dir --description "Resolve models dir (env overrides default)"
    if set -q LLS_MODELS_DIR; and test -n "$LLS_MODELS_DIR"
        echo "$LLS_MODELS_DIR"
        return 0
    end

    # 기본값 (원하면 OS별로 여기서 분기)
    echo "/home/utylee/temp/llm_models"
end

function __lls_models_for_host --description "List gguf model basenames for completion"
    set -l dir (__lls_models_dir)

    # dir 없으면 조용히 빈 결과
    test -d "$dir"; or return 0

    # fish glob: 파일명에 공백 있어도 안전
    for f in "$dir"/*.gguf
        test -f "$f"; or continue
        echo (path basename -- "$f")
    end
end

# lls start <TAB> 에서 모델 목록
complete -c lls -n '__fish_seen_subcommand_from start' -a "(__lls_models_for_host)" -f -d 'GGUF model'



# complete -c lls -f

# complete -c lls -n '__fish_use_subcommand' -a "start stop status list info show-profile" -d "lls subcommand"
# # complete -c lls -n '__fish_use_subcommand' -a start stop status list info show-profile -d "lls subcommand"
# complete -c lls -n '__fish_seen_subcommand_from start show-profile' -a '(__ll_models_for_host wsl2)' -d "GGUF model"
# complete -c lls -n '__fish_seen_subcommand_from start stop status info' -l port -d "port"
# complete -c lls -n '__fish_seen_subcommand_from start' -l detach -s d -d "detach"




# function __lls_models
#     if test "$LLS_REMOTE" = "1"
#         set -l rdir $LLS_REMOTE_MODELS_DIR
#         if test -z "$rdir"
#             set rdir "/home/utylee/temp/llm_models"
#         end

#         # 원격(WSL2)에서 모델 파일명만 가져오기
#         # command ssh -p 8812 utylee@localhost "find '$rdir' -maxdepth 1 -type f -name '*.gguf' -printf '%f\n' 2>/dev/null"
#         command ssh wsl12 "find '$rdir' -maxdepth 1 -type f -name '*.gguf' -printf '%f\n' 2>/dev/null"
#         return
#     end

#     set -l dir $LLS_MODELS_DIR
#     if test -z "$dir"
#         set dir "$HOME/temp/llm_models"
#     end

#     for f in $dir/*.gguf
#         if test -f $f
#             echo (basename $f)
#         end
#     end
# end

# # 🔥 중요: 기본 파일 완성 끄기 (지금 '현재 폴더 파일만 뜨는' 문제 해결)
# complete -c lls -f

# # subcommands
# complete -c lls -n '__fish_use_subcommand' -a start -d "start llama-server"
# complete -c lls -n '__fish_use_subcommand' -a stop -d "stop llama-server"
# complete -c lls -n '__fish_use_subcommand' -a status -d "show status"
# complete -c lls -n '__fish_use_subcommand' -a list -d "list models"

# # lls start <model>
# # complete -c lls -n '__fish_seen_subcommand_from start' -a '(__lls_models)' -d "GGUF model"
# complete -c lls -a '(__lls_models)'

# # options
# complete -c lls -n '__fish_seen_subcommand_from start' -s d -l detach -d "run in background"
# complete -c lls -n '__fish_seen_subcommand_from stop status' -l port -d "port"



# # function __lls_models
# #     if test "$LLS_REMOTE" = "1"
# #         set -l rdir $LLS_REMOTE_MODELS_DIR
# #         if test -z "$rdir"
# #             set rdir "/home/utylee/temp/llm_models"
# #         end

# #         # 원격에서만 glob 확장 + 파일명만 출력(공백 안전)
# #         command ssh -p 8812 utylee@localhost "find '$rdir' -maxdepth 1 -type f -name '*.gguf' -printf '%f\n' 2>/dev/null"
# #         return
# #     end

# #     set -l dir $LLS_MODELS_DIR
# #     if test -z "$dir"
# #         set dir "$HOME/llm_models"
# #     end

# #     for f in $dir/*.gguf
# #         if test -f $f
# #             echo (basename $f)
# #         end
# #     end
# # end



# # function __lls_models
# #     # 원격 모드면 WSL2에서 목록을 가져온다
# #     if test "$LLS_REMOTE" = "1"
# #         # 원격 경로(WSL2 기준)를 따로 쓰는 게 가장 안전
# #         set -l rdir $LLS_REMOTE_MODELS_DIR
# #         if test -z "$rdir"
# #             set rdir "/home/utylee/temp/llm_models"
# #         end

# #         # 여기 포인트:
# #         #  - '*.gguf'는 반드시 원격 쉘에서 확장되게 작은따옴표로 감싸기
# #         # command ssh wsl2-llama "ls -1 '$rdir'/*.gguf 2>/dev/null | xargs -n1 basename"
# # 		command ssh -p 8812 utylee@localhost "ls -1 '$rdir'/*.gguf 2>/dev/null | xargs -n1 basename"
# #         return
# #     end

# #     # 로컬 모드
# #     set -l dir $LLS_MODELS_DIR
# #     if test -z "$dir"
# #         set dir "$HOME/llm_models"
# #     end

# #     for f in $dir/*.gguf
# #         if test -f $f
# #             echo (basename $f)
# #         end
# #     end
# # end



# # function __lls_models

# #     if test "$LLS_REMOTE" = "1"
# #         ssh wsl2-llama "ls -1 $LLS_MODELS_DIR/*.gguf 2>/dev/null | xargs -n1 basename"
# #         return
# #     end

# #     for f in $LLS_MODELS_DIR/*.gguf
# #         if test -f $f
# #             echo (basename $f)
# #         end
# #     end
# # end

# # function __lls_models
# #     if test "$LLS_REMOTE" = "1"
# #         command ssh $LLS_REMOTE_SSH "ls -1 $LLS_MODELS_DIR/*.gguf 2>/dev/null | xargs -n1 basename"
# #     else
# #         set -l dir $LLS_MODELS_DIR
# #         if test -z "$dir"
# #             set dir "$HOME/temp/llm_models"
# #         end
# #         for f in $dir/*.gguf
# #             if test -f $f
# #                 echo (basename $f)
# #             end
# #         end
# #     end
# # end

