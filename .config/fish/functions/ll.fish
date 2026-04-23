function ll --description "eza wrapper (supports ls-style -rt / -tr)"
    set -l time_oldest 0
    set -l args

    for a in $argv
        switch $a
            case '-rt' '-tr'
                set time_oldest 1
            case '*'
                set -a args $a
        end
    end

    if test $time_oldest -eq 1
        eza -al --color=always --group-directories-first --icons --sort=modified $args
        # eza -al --color=always --group-directories-first --icons --sort=modified --reverse $args
    else
        eza -al --color=always --group-directories-first --icons $args
    end
end
