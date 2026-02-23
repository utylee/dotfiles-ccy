set -l rustup_path $HOME/.cargo/bin

set -q CARGO_HOME
and set -l rustup_path $CARGO_HOME/bin

test -d $rustup_path
and contains -- $rustup_path $fish_user_paths
or set fish_user_paths $fish_user_paths $rustup_path
