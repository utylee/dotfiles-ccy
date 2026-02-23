function ts {
  args=$@
  tmux send-keys -t 1 "$args" Enter
}
