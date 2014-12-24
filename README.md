# Fish-sf

Provide a symfony2 console function with completion for [fish shell](http://fishshell.com)

## Install

### Automatic installer

Run the below command if you trust me :)

```shell
curl -L https://github.com/mojoLyon/fish-sf/raw/master/tools/install.fish | fish
```

### Manual installation

1. Clone the repository :

```shell
git clone git://github.com/mojoLyon/fish-sf.git ~/.fish-sf
```

2. Create symbolic link to function and completion

```shell
ln -s ~/.fish-sf/functions/sf.fish ~/.config/fish/functions/sf.fish
ln -s ~/.fish-sf/completions/sf.fish ~/.config/fish/completions/sf.fish
```

## Usage

Some tab completion are only available when you are in a symfony directory, the command just use `app/console` provided by symfony2 
to get some completion

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
