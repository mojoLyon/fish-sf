function __get_console_path
	if test -e bin/console
		echo 'bin/console'
	else if test -e app/console
		echo 'app/console'
	else
		set_color yellow
		echo "No console found"
		set_color normal
	end
end

function __sf_use_table
	if app/console --no-ansi --version | grep "2.3"
		return 1
	else
		return 0
	end
end

function __sf_get_config_bundle
	if not type (__get_console_path) > /dev/null
		return
	end
	if __sf_use_table
		eval (__get_console_path) --no-ansi config:dump-reference | sed -e '1,4 d; $d' -e 's/\| *\([^ ]*\).*$/\1/'
	else
		eval (__get_console_path) config:dump-reference | sed -e 's/^[^:]*: *//'
	end
end

function __sf_get_services
	type (__get_console_path) > /dev/null
	and eval ./(__get_console_path)  --no-ansi container:debug | sed -e '1,2 d' -e '/^To search for a service,/d' -e 's/^ *\([^ ]*\).*/\1/'
end

function __sf_get_container_tag
	type (__get_console_path) > /dev/null
	and eval ./(__get_console_path) --no-ansi container:debug --tags | awk '/^\[tag\]/ {print $0}' | sed -e 's/^\[tag\] *\(.*\)/\1/'
end

function __sf_get_routes
	type (__get_console_path) > /dev/null
	and eval ./(__get_console_path)  --no-ansi router:debug | sed -e '1,2 d' -e 's/^ *\([^ ]*\).*/\1/'
end

function __sf_get_events
	type (__get_console_path) > /dev/null
	and eval ./(__get_console_path) --no-ansi debug:event-dispatcher | awk '/^\[Event\]/ {print $2}'
end

function __sf_get_custom_functions
	if not type (__get_console_path) > /dev/null
		return
	end

	set -l builtin server:stop server:status server:start security:encode-password security:check lint:yaml yaml:lint acl:set debug:twig twig:debug debug:translation translation:debug debug:event-dispatcher generate:doctrine:entities doctrine:generate:entities generate:doctrine:form doctrine:generate:form generate:doctrine:entity doctrine:generate:entity generate:doctrine:crud doctrine:generate:crud generate:controller generate:bundle lint:twig twig:lint translation:update server:run router:match router:dump-apache debug:router router:debug debug:container container:debug debug:config config:debug config:dump-reference assets:install assetic:dump cache:warmup cache:clear list help init:acl
	set -l cmdlist (eval ./(__get_console_path) --no-ansi | sed -e "1,/Available commands/d" -e 's/^ *\([^ ]*\)/\1/' -e '/^[^ ]*$/d' | awk '{print $1}')
	
	for i in $cmdlist
		if not contains $i $builtin
			echo $i
		end
	end
end

complete -c sf -n '__fish_use_subcommand' -xa 'help'                                                  -d 'Displays help for a command'
complete -c sf -n '__fish_use_subcommand' -xa 'list'                                                  -d 'Lists commands'
complete -c sf -n '__fish_use_subcommand' -xa 'cache:clear'                                           -d 'Clear the  cache'
complete -c sf -n '__fish_use_subcommand' -xa 'cache:warmup'                                          -d 'Warms up an empty cache'
complete -c sf -n '__fish_use_subcommand' -xa 'assetic:dump'                                          -d 'Dump all assets to the filesystem'
complete -c sf -n '__fish_use_subcommand' -xa 'assets:install'                                        -d 'Installs bundles web assets under a public web directory'
complete -c sf -n '__fish_use_subcommand' -xa 'debug:config config:debug config:dump-reference'       -d 'Dump default configuration for an extension'
complete -c sf -n '__fish_use_subcommand' -xa 'debug:container container:debug'                       -d 'Displays current services for an application'
complete -c sf -n '__fish_use_subcommand' -xa 'debug:router router:debug'                             -d 'Display current routes for an application'
complete -c sf -n '__fish_use_subcommand' -xa 'router:dump-apache'                                    -d 'Dumps all routes as Apache rewrite rules'
complete -c sf -n '__fish_use_subcommand' -xa 'router:match'                                          -d 'Helps debug routes by simulating a path info match'
complete -c sf -n '__fish_use_subcommand' -xa 'server:run'                                            -d 'Runs PHP built-in web server'
complete -c sf -n '__fish_use_subcommand' -xa 'translation:update'                                    -d 'Updates the translation file'
complete -c sf -n '__fish_use_subcommand' -xa 'lint:twig twig:lint'                                   -d 'Lints a template and outputs encountered errors'
complete -c sf -n '__fish_use_subcommand' -xa 'generate:bundle'                                       -d 'Generate a bundle'
complete -c sf -n '__fish_use_subcommand' -xa 'generate:controller'                                   -d 'Generates a controller'
complete -c sf -n '__fish_use_subcommand' -xa 'generate:doctrine:crud doctrine:generate:crud'         -d 'Generates a CRUD based on a Doctrine entity'
complete -c sf -n '__fish_use_subcommand' -xa 'generate:doctrine:entity doctrine:generate:entity'     -d 'Generates a new Doctrine entity inside a bundle'
complete -c sf -n '__fish_use_subcommand' -xa 'generate:doctrine:form doctrine:generate:form'         -d 'Generates a form type class based on a Doctrine entity'
complete -c sf -n '__fish_use_subcommand' -xa 'generate:doctrine:entities doctrine:generate:entities' -d 'Generates entity classes and method stubs from your mapping information'
complete -c sf -n '__fish_use_subcommand' -xa 'debug:event-dispatcher'                                -d 'Displays configured listeners for an application'
complete -c sf -n '__fish_use_subcommand' -xa 'debug:translation translation:debug'                   -d 'Displays translation messages information'
complete -c sf -n '__fish_use_subcommand' -xa 'debug:twig twig:debug'                                 -d 'Shows a list of twig functions, filters, globals and tests'
complete -c sf -n '__fish_use_subcommand' -xa 'init:acl'                                              -d 'Mounts ACL tables in the database'
complete -c sf -n '__fish_use_subcommand' -xa 'acl:set'                                               -d 'Sets ACL for objects'
complete -c sf -n '__fish_use_subcommand' -xa 'lint:yaml yaml:lint'                                   -d 'Lints a file and outputs encountered errors'
complete -c sf -n '__fish_use_subcommand' -xa 'security:check'                                        -d 'Checks security issues in your project dependencies'
complete -c sf -n '__fish_use_subcommand' -xa 'security:encode-password'                              -d 'Encodes a password'
complete -c sf -n '__fish_use_subcommand' -xa 'server:start'                                          -d 'Starts PHP built-in web server in the background'
complete -c sf -n '__fish_use_subcommand' -xa 'server:status'                                         -d 'Outputs the status of the built-in web server for the given address'
complete -c sf -n '__fish_use_subcommand' -xa 'server:stop'                                           -d 'Stops PHP\'s built-in web server that was started with the server:start'
complete -c sf -n '__fish_use_subcommand' -xa '(__sf_get_custom_functions)'                           -d 'Custom function'

# assetic
set -l assetic_dump -c sf -n 'contains assetic:dump (commandline -poc)'
complete $assetic_dump -l 'watch' --description "Check for changes every second, debug mode only" -x

# assets
set -l assets_install -c sf -n 'contains assets:install (commandline -poc)'
complete $assets_install -l 'symlink' -d 'Symlinks the assets instead of copying it' -x

# config
set -l config_dump_ref -c sf -n 'contains config:dump-reference (commandline -poc); or contains config:debug (commandline -poc); or contains debug:config (commandline -poc)'
complete $config_dump_ref -xa '(__sf_get_config_bundle)' -d 'Bundle'

# container
set -l container_debug -c sf -n 'contains container:debug (commandline -poc); or contains debug:container (commandline -poc)'
complete $container_debug                 -xa '(__sf_get_services)'                          -d 'Service name'
complete $container_debug -l 'tags'                                                          -d 'Display tagged services for an application'
complete $container_debug -l 'tag'        -xa '(__sf_get_container_tag)\t"'(_ "Tag name")'"' -d 'Show all services with a specific tag'
complete $container_debug -l 'parameters'                                                    -d 'Displays parameters for an application'
complete $container_debug -l 'parameter'                                                     -d 'Displays a specific parameter for an application'

# router
set -l router_debug -c sf -n 'contains router:debug (commandline -poc); or contains debug:router (commandline -poc)'
complete $router_debug -xa '(__sf_get_routes)' -d 'Route name'

set -l router_dump_apache -c sf -n 'contains router:dump-apache (commandline -poc)'
complete $router_dump_apache -l 'base-uri' -d 'The base uri'

# server
set -l server_run -c sf -n 'contains server:run (commandline -poc); or contains server:start (commandline -poc)'
complete $server_run -x -l 'docroot' -a '(__fish_complete_directories "")' -d 'Document root (web/)'
complete $server_run -r -l 'router'  -a '(__fish_complete_suffix .php)'    -d 'Path to custom router script'

# translation
set -l trans_update -c sf -n 'contains translation:update (commandline -poc)'
complete $trans_update -x -l 'prefix'                           -d 'Override the default prefix'
complete $trans_update -x -l 'output-format' -a 'yml xliff php' -d 'Override the default output format'
complete $trans_update -x -l 'dump-messages'                    -d 'Should the messages be dumped in the console'
complete $trans_update -x -l 'force'                            -d 'Should the update be done'
complete $trans_update -x -l 'clean'                            -d 'Should clean not found messages'

# twig
set -l twig_lint -c sf -n 'contains twig:lint (commandline -poc); or contains lint:twig (commandline -poc)'
complete $twig_lint -a '(__fish_complete_suffix .twig)' -d 'Twig file'

# generate bundle
set -l generate_bundle -c sf -n 'contains generate:bundle (commandline -poc)'
complete $generate_bundle -x -l 'no-interaction'                                    -d 'Disable interactive dialog'
complete $generate_bundle -x -l 'namespace'                                         -d 'The namespace of the bundle to create'
complete $generate_bundle -x -l 'dir'         -a '(__fish_complete_directories "")' -d 'The directory where to create the bundle'
complete $generate_bundle -x -l 'bundle-name'                                       -d 'The bundle name'
complete $generate_bundle -x -l 'format'      -a 'php xml yml annotation'           -d 'Format for configuration files'
complete $generate_bundle -x -l 'structure'                                         -d 'Generate the whole directory structure'

# generate controller
set -l generate_controller -c sf -n 'contains generate:controller (commandline -poc)'
complete $generate_controller -x -l 'no-interaction'                              -d 'Disable interactive dialog'
complete $generate_controller -x -l 'controller'                                  -d 'The name of the controller to create'
complete $generate_controller -x -l 'route-format'    -a 'php xml yml annotation' -d 'The format that is used for the routing'
complete $generate_controller -x -l 'template-format' -a 'php twig'               -d 'The format that is used for templating'
complete $generate_controller -x -l 'actions'                                     -d 'The actions in the controller'

# generate doctrine crud
set -l generate_doctrine_crud -c sf -n 'contains generate:doctrine:crud (commandline -poc); or contains doctrine:generate:crud (commandline -poc)'
complete $generate_doctrine_crud -x -l 'entity'                                   -d 'The entity class name to initialize (shortcut notation)'
complete $generate_doctrine_crud -x -l 'route-prefix'                             -d 'The route prefix'
complete $generate_doctrine_crud -f -l 'with-write'                               -d 'Whether or not to generate create, new and delete actions'
complete $generate_doctrine_crud -x -l 'format'       -a 'php xml yml annotation' -d 'Use the format for configuration files'
complete $generate_doctrine_crud -x -l 'overwrite'                                -d 'Do not stop the generation if crud controller already exist'

# generate doctrine entity
set -l generate_doctrine_entity -c sf -n 'contains generate:doctrine:entity (commandline -poc); or contains doctrine:generate:entity (commandline -poc)'
complete $generate_doctrine_entity -x -l 'no-interaction'                              -d 'Disable interactive dialog'
complete $generate_doctrine_entity -x -l 'entity'                                      -d 'The entity class name to initialize (shortcut notation)'
complete $generate_doctrine_entity -x -l 'fields'                                      -d 'The fields to create with the new entity'
complete $generate_doctrine_entity -x -l 'format'          -a 'php xml yml annotation' -d 'Use the format for configuration files'
complete $generate_doctrine_entity -f -l 'with-repository'                             -d 'Whether to generate the entity repository or not'

# generate doctrine entities
set -l generate_doctrine_entities -c sf -n 'contains generate:doctrine:entities (commandline -poc); or contains doctrine:generate:entities (commandline -poc)'
complete $generate_doctrine_entities -x -l 'path' -a '(__fish_complete_directories "")' -d 'The path where to generate entities when it cannot be guessed'
complete $generate_doctrine_entities -x -l 'no-backup'                                  -d 'Do not backup existing entities files'

# security encode-password
set -l securioty_encode_password -c sf -n 'contains security:encode-password (commandline -poc)'
complete $securioty_encode_password -x -l 'empty-salt' -d 'Do not generate a salt or let the encoder generate one.'

# security check
set -l security_check -c sf -n 'contains security:check (commandline -poc)'
complete $security_check -a '(__fish_complete_suffix .lock)' -d 'Composer lock file'

# acl set
set -l acl_set -c sf -n 'contains acl:set (commandline -poc)'
complete $acl_set -xrf -l 'user'        -d 'A list of security identities'
complete $acl_set -xrf -l 'role'        -d 'A list of roles'
complete $acl_set -xf  -l 'class-scope' -d'Use class-scope entries'

# debug event dispatcher
set -l debug_event_dispatcher -c sf -n 'contains debug:event-dispatcher (commandline -poc)'
complete $debug_event_dispatcher -l 'format' -xa 'txt xml json md'                        -d 'The output format'
complete $debug_event_dispatcher             -xa '(__sf_get_events)\t"'(_ "Event name")'"' -d 'Show all listener for the given event'

# yaml lint
set -l yaml_lint -c sf -n 'contains yaml:lint (commandline -poc); or contains lint:yaml (commandline -poc)'
complete $yaml_lint -a '(__fish_complete_suffix .yml)' -d 'Yaml file'

# debug translation
set -l debug_translation -c sf -n 'contains debug:translation (commandline -poc); or contains translation:debug (commandline -poc)'
complete $debug_translation -xrf -l 'domain'       -d 'The message domain'
complete $debug_translation -xf  -l 'only-missing' -d 'Display only missing messages'
complete $debug_translation -xf  -l 'only-unused'  -d 'Display only unused messages'
