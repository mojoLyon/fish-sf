function sf --description "Symfony2 console"
	if test -e app/console
		app/console $argv
	else
		set_color yellow
		echo "Not in an Symfony project"
		set_color normal
	end
end
