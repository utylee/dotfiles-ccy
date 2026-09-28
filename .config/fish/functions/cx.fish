function cx
    if test (count $argv) -gt 0
        codex --no-daemon -p $argv
    else
        codex --no-daemon
    end
end
