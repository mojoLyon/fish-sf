# Fish-sf

Provide a symfony2 console function with completion.

## Install

This tool still in development.

If you have copied files manually in your fish config directory, delete files before running the below command.

```shell
curl -L https://github.com/mojoLyon/fish-sf/raw/master/tools/install.fish | fish
```

## Usage

Some completion are only available when you are in a symfony directory, the command just use `app/console` provided by symfony2 
to provide some completion

### Available completion 

 - Cache
    * ca:cl
    * ca:wa
 - assetic:dump
    * --watch
 - assets:install
    * --symlink
 - config:dump-reference with completion of bundle
 - container:debug with completion of services
    * --tags
    * --tag with tag completion
    * --parameters
    * --parameter
 - router:debug with completion of route name
 - router:dump-apache
    * --base-uri
 - router:match
 - server:run
    * --docroot
    * --router
 - translation:update
    * --prefix
    * --force
    * --clean
    * --output-format
    * --dump-messages
 - twig:lint with file filtering
 - generate:bundle
    * --no-interaction
    * --namespace
    * --dir with directories completion
    * --bundle-name
    * --format with format suggestion
    * --structure
 - generate_controlle
    * --no-interaction
    * --controller
    * --route-format with format suggestion
    * --template-format with format suggestion
    * --actions
 - generate:doctrine:crud and alias doctrine:generate:crud
    * --entity
    * --route-prefix
    * --with-write
    * --format with format suggestion
    * --overwrite
 - generate:doctrine:entity and alias doctrine:generate:entity
    * --no-interaction
    * --entity
    * --fields
    * --format with format suggestion
    * --with-repository
 - generate:doctrine:entities and alias doctrine:generate:entities
    * --path with directories completion
    * --no-backup
