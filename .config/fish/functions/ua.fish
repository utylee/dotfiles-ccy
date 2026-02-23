function ua
	set b $argv
	set b (string replace '?' '_u_qa_' "$b")
	set b (string replace '&' '_u_im_' "$b")
	set b (string replace ' ' '_u_sp_' "$b")
	#echo $b
	curl http://192.168.0.202:9202/c/"$b"
end
