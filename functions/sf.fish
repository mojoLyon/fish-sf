function sf --description "Symfony2 console"
	if test -e app/console
		app/console $argv
	else
		set_color yellow
		echo "Not in an Symfony project"
		set_color normal
	end
end


function __sfinit_help
	echo "Usage : [options] [path]"
	echo "Initialize a synfony2 project by installing symfony long time support with composer and setting up cache and log permissions"
	echo "You must have composer installed in your path environment to use this function"
	echo "Options :"
	echo "    -h, --help         : print this message"
	echo "    -l, --last-release : Install the last release"
	echo "If path is not specified, the project is created in the current directory"
end

function __sfinit_confirm
	read -l -p 'set_color green;echo "Continue? [Yn]";set_color normal;echo "> "' confirm
	switch $confirm
        	case Y y
        		return 0
      		case '' N n
        		return 1
    	end
end

function sf-init -d 'Create symfony project'
	set -l release "2.3.*"
	set -l path
	set -l release_msg "version $release"
	set -l path_msg 'current path'

	set -l options
        set -l longopt
        set -l shortopt lh
        if not getopt -T > /dev/null
                # GNU getopt
                set longopt release,help
                set options -o $shortopt -l $longopt --
                # Verify options
                if not getopt -n type $options $argv >/dev/null
                        return 1
                end
        else
                # Old getopt, used on OS X
                set options $shortopt
                # Verify options
                if not getopt $options $argv >/dev/null
                        return 1
                end
        end

        # Do the real getopt invocation
        set -l tmp (getopt $options $argv)

        # Break tmp up into an array
        set -l opt
        eval set opt $tmp

        while count $opt >/dev/null
                switch $opt[1]
                        case -h --help
                                __sfinit_help
                                return 0

                        case -l --last-release
                                set release ""
				set release_msg "last release"

                        case --
                                 set -e opt[1]
                                 break

                end
                set -e opt[1]
        end
	
	# check if a path is supplied
	if count $opt > /dev/null
		set path $opt[1]
		set path_msg $path
	else
		set path '.'
	end

	echo "You will install symfony $release_msg in $path_msg"
	
	if not __sfinit_confirm
		set_color red
		echo "Canceled"
		set_color normal

		return 1
	end
	
	echo "Checking composer availability"
	if not type composer > /dev/null
		set_color red
		echo "Composer not found in your PATH environement"
		set_color normal
		
		echo "Please install composer in your PATH before run this command"
		echo "Your actual PATH : $PATH" 
		
		return 1
	end
	
	set_color green
	echo "Composer found."
	set_color normal
	
	echo "Create project"

	composer create-project symfony/framework-standard-edition $path $release

	set_color green
	echo "Project initialized"
	set_color normal

	echo "Setting up app/cache and app/log permissions"
	echo "System may ask you sudo password"

	set -l http_user (ps aux | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
	set -l current_user (whoami)
	set path ( echo $path | sed 's/^\(.*\)\/$/\1/')

	# trying chmod +a
	if  chmod --help 2>&1 | fgrep +a > /dev/null
		set_color green
		echo "Setting permession whith chmod +a"
		set_color normal

		sudo chmod +a "$http_user allow delete,write,append,file_inherit,directory_inherit" $path/app/cache $path/app/logs
		sudo chmod +a "$current_user allow delete,write,append,file_inherit,directory_inherit" $path/app/cache $path/app/logs

	else if type setfacl > /dev/null
		set_color green
		echo "Setting permission with setfacl"
		set_color normal

		sudo setfacl -R -m u:"$http_user":rwX -m u:"$current_user":rwX $path/app/cache $path/app/logs
		sudo setfacl -dR -m u:"$http_user":rwX -m u:"$current_user":rwX $path/app/cache $path/app/logs

	else
		set_color ffa500
		echo "Unable to change permission with chmod +a or setfacl"
		echo "You must set permission with umask. Read symfony documentation"
		set_color normal
	end
	
	set_color green
	echo "Installation done."
	set_color normal
end
