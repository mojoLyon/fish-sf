function __fish_sf_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'sf' ]
    return 0
  else
	for i in $cmd
		if contains -- $i ca:cl ca:wa assetic:dump assets:install config:dump-reference container:debug router:match router:debug router:dump-apache router:match server:run translation:update twig:lint
			return 1
		end
    end
  end
  return 1
end

function __fish_sf_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[-1] ]
      return 0
    end
  end
  return 1
end

function __fish_sf_using_command_with_switch
	set cmd (commandline -opc)
	echo $argv
	if [ (count $cmd) -gt 1 ]
		if [ $argv[1] = $cmd[-2] -a $argv[2] = $cmd[-1] ]
			return 0
		end
	end
	return 1
end

function __sf_get_config_bundle
	command ./app/console config:dump-reference | sed -e 's/^[^:]*:\s*//'
end

function __sf_get_services
	command ./app/console  --no-ansi container:debug | sed -e '1,2 d' -e 's/^\([^ ]*\).*/\1/'
end

function __sf_get_container_tag
	command ./app/console --no-ansi container:debug --tags | awk '/^\[tag\]/ {print $0}' | sed -e 's/^\[tag\]\s*\(.*\)/\1/'
end

function __sf_get_routes
	command ./app/console  --no-ansi router:debug | sed -e '1,2 d' -e 's/^\([^ ]*\).*/\1/'
end

#cache
complete -f -c sf -n '__fish_sf_needs_command' -a 'ca:cl' -d 'Clear cache'
complete -f -c sf -n '__fish_sf_needs_command' -a 'ca:wa' -d 'Warmup cache'

#assetic
complete -r -c sf -n '__fish_sf_needs_command' -a 'assetic:dump' -d 'Dumps all assets to the filesystem'
complete -f -c sf -n '__fish_sf_using_command assetic:dump' -a '--watch' -d 'Check for changes every second, debug mode only'

#assets
complete    -c sf -n '__fish_sf_needs_command' -a 'assets:install' -d 'Installs bundles web assets under a public web directory'
complete -f -c sf -n '__fish_sf_using_command assets:install' -a '--symlink' -d 'Check for changes every second, debug mode only'

#config
complete -f -c sf -n '__fish_sf_needs_command' -a 'config:dump-reference' -d 'Dumps default configuration for an extension'
complete -f -c sf -n '__fish_sf_using_command config:dump-reference' -a '(__sf_get_config_bundle)' -d 'Bundle'

# container
complete -f -c sf -n '__fish_sf_needs_command' -a 'container:debug' -d 'Displays current services for an application'
complete -f -c sf -n '__fish_sf_using_command container:debug' -a '(__sf_get_services)' -d 'Service name'
complete -f -c sf -n '__fish_sf_using_command container:debug' -a '--tags' -d 'Displays tagged services for an application'
complete -x -c sf -n '__fish_sf_using_command container:debug' -a '--tag' -d 'Show all services with a specific tag'
complete -f -c sf -n '__fish_sf_using_command_with_switch container:debug --tag' -a '(__sf_get_container_tag)' -d 'Tag name'
complete -f -c sf -n '__fish_sf_using_command container:debug' -a '--parameters' -d 'Displays parameters for an application'
complete -x -c sf -n '__fish_sf_using_command container:debug' -a '--parameter' -d 'Displays a specific parameter for an application'

#router
complete -f -c sf -n '__fish_sf_needs_command' -a 'router:debug' -d 'Displays current routes for an application'
complete -f -c sf -n '__fish_sf_using_command router:debug' -a '(__sf_get_routes)' -d 'Route name'

complete -f -c sf -n '__fish_sf_needs_command' -a 'router:dump-apache' -d 'Dumps all routes as Apache rewrite rules'
complete -x -c sf -n '__fish_sf_using_command router:dump-apache' -a '--base-uri' -d 'The base uri'

complete -x -c sf -n '__fish_sf_needs_command' -a 'router:match' -d 'Helps debug routes by simulating a path info match'

# server
complete -f -c sf -n '__fish_sf_needs_command' -a 'server:run' -d 'Runs PHP built-in web server'
complete -f -c sf -n '__fish_sf_using_command server:run' -a '--address' -d 'Address:port (localhost:8000)'
complete -x -c sf -n '__fish_sf_using_command server:run' -a '--docroot' -d 'Document root (web/)'
complete -x -c sf -n '__fish_sf_using_command server:run' -a '--router' -d 'Path to custom router script'

# translate
complete -f -c sf -n '__fish_sf_needs_command' -a 'translation:update' -d 'Updates the translation file'
complete -f -c sf -n '__fish_sf_using_command translation:update' -l 'address' -d 'Should the messages be dumped in the console'
complete -f -c sf -n '__fish_sf_using_command translation:update' -l 'force' -d 'Should the update be done'
complete -f -c sf -n '__fish_sf_using_command translation:update' -l 'clean' -d 'Should clean not found messages'
complete -x -c sf -n '__fish_sf_using_command translation:update' -a '--output-format' -d 'Should clean not found messages'

# twig
complete    -c sf -n '__fish_sf_needs_command' -a 'twig:lint' -d 'Lints a template and outputs encountered errors'
complete -x -c sf -n '__fish_sf_using_command twig:lint' -a '(__fish_complete_suffix .twig)' -d 'Twig file'



