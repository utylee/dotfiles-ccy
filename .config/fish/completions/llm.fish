complete -c llm -f

complete -c llm -n '__fish_use_subcommand' -a 'start stop status list info show-profile' -d 'llm subcommand'
complete -c llm -n '__fish_seen_subcommand_from start show-profile' -a '(__ll_models_for_host mac)' -d 'GGUF model'

complete -c llm -n '__fish_seen_subcommand_from start stop status info' -l port -d 'port'
complete -c llm -n '__fish_seen_subcommand_from start' -l detach -s d -d 'detach'


# complete -c llm -f
# complete -c llm -n '__fish_use_subcommand' -a start stop status list info show-profile -d "llm subcommand"
# complete -c llm -n '__fish_seen_subcommand_from start show-profile' -a '(__ll_models_for_host mac)' -d "GGUF model"
# complete -c llm -n '__fish_seen_subcommand_from start stop status info' -l port -d "port"
# complete -c llm -n '__fish_seen_subcommand_from start' -l detach -s d -d "detach"

