function sf --description "Symfony2 console"
	echo "Running $argv\n"
	app/console $argv
end
