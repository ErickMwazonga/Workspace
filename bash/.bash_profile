# Set Paths
PATH="$PATH:$HOME/.config/composer/vendor/bin"

export PATH="~/.composer/vendor/bin:$PATH"


# Environment configuration.
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh


# Other configs
# export DB_PASSWORD=1234

export PATH=$PATH:'/home/erick/Android/Sdk/platform-tools':'/home/erick/Android/Sdk/tools'


# Set Default Editor (change 'Nano' to the editor of your choice)
# export EDITOR=/usr/bin/nano


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Load the shell dotfiles, and then some:
for file in ~/.{path,bash_prompt,exports,bash_aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;



# Add color to terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced


# Config LESS output.
export LESS=-iXFR
