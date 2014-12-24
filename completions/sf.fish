
function __sf_get_config_bundle
	type app/console > /dev/null
	and app/console config:dump-reference | sed -e 's/^[^:]*: *//'
end

function __sf_get_services
	type app/console > /dev/null
	and command ./app/console  --no-ansi container:debug | sed -e '1,2 d' -e 's/^\([^ ]*\).*/\1/'
end

function __sf_get_container_tag
	type app/console > /dev/null
	and command ./app/console --no-ansi container:debug --tags | awk '/^\[tag\]/ {print $0}' | sed -e 's/^\[tag\] *\(.*\)/\1/'
end

function __sf_get_routes
	type app/console > /dev/null
	and command ./app/console  --no-ansi router:debug | sed -e '1,2 d' -e 's/^\([^ ]*\).*/\1/'
end

complete -c sf -n '__fish_use_subcommand' -xa 'ca:cl'                 -d 'Clear cache'
complete -c sf -n '__fish_use_subcommand' -xa 'ca:wa'                 -d 'Warmup cache'
complete -c sf -n '__fish_use_subcommand' -xa 'assetic:dump'          -d 'Dump all assets to the filesystem'
complete -c sf -n '__fish_use_subcommand' -xa 'assets:install'        -d 'Installs bundles web assets under a public web directory'
complete -c sf -n '__fish_use_subcommand' -xa 'config:dump-reference' -d 'Dump default configuration for an extension'
complete -c sf -n '__fish_use_subcommand' -xa 'container:debug'       -d 'Displays current services for an application'
complete -c sf -n '__fish_use_subcommand' -xa 'router:debug'          -d 'Display current routes for an application'
complete -c sf -n '__fish_use_subcommand' -xa 'router:dump-apache'    -d 'Dumps all routes as Apache rewrite rules'
complete -c sf -n '__fish_use_subcommand' -xa 'router:match'          -d 'Helps debug routes by simulating a path info match'
complete -c sf -n '__fish_use_subcommand' -xa 'server:run'            -d 'Runs PHP built-in web server'
complete -c sf -n '__fish_use_subcommand' -xa 'translation:update'    -d 'Updates the translation file'
complete -c sf -n '__fish_use_subcommand' -xa 'twig:lint'             -d 'Lints a template and outputs encountered errors'

# assetic
set -l assetic_dump -c sf -n 'contains assetic:dump (commandline -poc)'
complete $assetic_dump -l 'watch' --description "Check for changes every second, debug mode only" -x

# assets
set -l assets_install -c sf -n 'contains assets:install (commandline -poc)'
complete $assets_install -l 'symlink' -d 'Symlinks the assets instead of copying it' -x

# config
set -l config_dump_ref -c sf -n 'contains config:dump-reference (commandline -poc)'
complete $config_dump_ref -xa '(__sf_get_config_bundle)' -d 'Bundle'

# container
set -l container_debug -c sf -n 'contains container:debug (commandline -poc)'
complete $container_debug                 -xa '(__sf_get_services)'                          -d 'Service name'
complete $container_debug -l 'tags'                                                          -d 'Display tagged services for an application'
complete $container_debug -l 'tag'        -xa '(__sf_get_container_tag)\t"'(_ "Tag name")'"' -d 'Show all services with a specific tag'
complete $container_debug -l 'parameters'                                                    -d 'Displays parameters for an application'
complete $container_debug -l 'parameter'                                                     -d 'Displays a specific parameter for an application'

# router
set -l router_debug -c sf -n 'contains router:debug (commandline -poc)'
complete $router_debug -c sf -xa '(__sf_get_routes)' -d 'Route name'

set -l router_dump_apache -c sf -n 'contains router:dump-apache (commandline -poc)'
complete $router_dump_apache -c sf -l 'base-uri' -d 'The base uri'

# server
set -l server_run -c sf -n 'contains server:run (commandline -poc)'
complete $server_run -x -c sf -l 'docroot' -a '(__fish_complete_directories "")' -d 'Document root (web/)'
complete $server_run -r -c sf -l 'router'  -a '(__fish_complete_suffix .php)'    -d 'Path to custom router script'

# translation
set -l trans_update -c sf -n 'contains translation:update (commandline -poc)'
complete $trans_update -x -c sf -l 'prefix'                           -d 'Override the default prefix'
complete $trans_update -x -c sf -l 'output-format' -a 'yml xliff php' -d 'Override the default output format'
complete $trans_update -x -c sf -l 'dump-messages'                    -d 'Should the messages be dumped in the console'
complete $trans_update -x -c sf -l 'force'                            -d 'Should the update be done'
complete $trans_update -x -c sf -l 'clean'                            -d 'Should clean not found messages'

# twig
set -l twig_lint -c sf -n 'contains twig:lint (commandline -poc)'
complete $twig_lint -c sf -a '(__fish_complete_suffix .twig)' -d 'Twig file'
