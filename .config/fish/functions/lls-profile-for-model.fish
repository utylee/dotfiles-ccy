function lls-profile-for-model -d "Return a preset label for a model filename"
    set -l m $argv[1]

    # 기본값
    set -l profile "default"
    set -l ctx 4096
    set -l threads 8
    set -l batch 1024
    set -l ubatch 256
    set -l ngl -1

    # 예시 규칙(너 취향대로 늘리면 됨)
    if string match -rq 'Qwen3-VL' -- $m
        set profile "vl"
        set ctx 4096
        set batch 768
        set ubatch 192
    else if string match -rq 'Coder' -- $m
        set profile "coder"
        set ctx 8192
        set batch 1024
        set ubatch 256
    else if string match -rq 'Phi-4' -- $m
        set profile "small-fast"
        set ctx 4096
        set batch 1536
        set ubatch 384
    else if string match -rq '30B|24B|21B' -- $m
        set profile "big-safe"
        set ctx 4096
        set batch 512
        set ubatch 128
    end

    # preview 출력(고정 포맷)
    echo "Profile: $profile"
    echo "ctx: $ctx"
    echo "threads: $threads"
    echo "batch/ubatch: $batch / $ubatch"
    echo "ngl: $ngl"
end

