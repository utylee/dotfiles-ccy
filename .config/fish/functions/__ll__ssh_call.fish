function __ll__ssh_call
    set -l host $argv[1]
    set -e argv[1]
    command ssh $host lls $argv
end
