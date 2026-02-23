function gcd
	set -l toplevel (git rev-parse --show-toplevel)
	#if ! test -z toplevel
	if test $status -eq 0
		cd $toplevel
	end
end
