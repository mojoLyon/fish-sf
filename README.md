# Fish-sf

Provide a symfony2 console function with completion.

## Install

This tool still in development.

For test purpose only you can add the file `functions/sf.fish` in your `~/.config/fish/functions` 
and  `completions/sf.fish` in your `~/.config/fish/completions`

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
    * --tag with completion of tag
    * --parameters
    * --parameter
 - router:debug with completion of route name
 - router:dump-apache
    * --base-uri
 - router:match
 - server:run
    * --address
    * --docroot
    * --router
 - translation:update
    * --address
    * --force
    * --clean
    * --output-format
 - twig:lint with file filtering