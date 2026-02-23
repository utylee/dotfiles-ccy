complete -c llh -f
complete -c llh -n '__fish_use_subcommand' -a start stop status list info show-profile -d "llh subcommand"
complete -c llh -n '__fish_seen_subcommand_from start show-profile' -a '(__ll_models_for_host halo)' -d "GGUF model"
complete -c llh -n '__fish_seen_subcommand_from start stop status info' -l slot -d "slot (base+slot => port)"
complete -c llh -n '__fish_seen_subcommand_from start stop status info' -l port -d "port"
complete -c llh -n '__fish_seen_subcommand_from start' -l detach -s d -d "detach"

