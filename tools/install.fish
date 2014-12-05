#!/usr/bin/env fish

# Fish-sf installation script
#
# Clone project in ~/.fish-sf and make symlinks in fish config

# Output in color
# First arg is the color name
# Second arg is the string to print
function colorize
        set_color $argv[1]
        echo $argv[2]
        set_color normal
end

# test if prject allready cloned
if test -d ~/.fish-sf
        colorize yellow 'You allready have fish-sf installed'
        exit
end

colorize blue 'Cloning fish-sf in ~/.fish-sf'

type git > /dev/null
and git clone https://github.com/mojoLyon/fish-sf.git ~/.fish-sf
or begin
	colorize red 'Error : git not installed'
end

colorize blue 'Making symlink for function and completion'

if test ! -d ~/.config/fish/functions
	mkdir ~/.config/fish/functions
end

if test ! -d ~/.config/fish/completions
	mkdir ~/.config/fish/completions
end

ln -s ~/.fish-sf/functions/sf.fish ~/.config/fish/functions/sf.fish
ln -s ~/.fish-sf/completions/sf.fish ~/.config/fish/completions/sf.fish

colorize green 'fish-sf is now installed'
