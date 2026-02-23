function ncd
	set -l toplevel (npm root)/..
	#if ! test -z toplevel
	if test $status -eq 0
		cd $toplevel
	end
end
