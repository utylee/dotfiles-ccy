function rs
	rsync -ah --no-p --no-g --no-o --info=progress2 --append --inplace $argv 
end
