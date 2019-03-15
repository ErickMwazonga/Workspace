# Alias.
# ---------------------------

# System
# --------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias .='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias d='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias dc='cd ~/Documents'

# https://github.com/sharkdp/bat
# alias cat='bat'

# Git.
# --------------------------
alias g='git'
alias gi='git init'
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias gc='git commit -m'
alias gac='git commit -am'
alias gpm='git push -u origin master'
alias gph='git push origin HEAD'
alias gpo='git pull origin master'

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gls='git log --oneline --graph --decorate --stat' #git log stats.
alias gll='git log --pretty=format:"%C(green)[%h]%Creset %gd %s %C(yellow)(%cr)%Creset %C(cyan)%cn%Creset" --graph'
alias glp='git shortlog'


# Python
# --------------------------
alias python='python3'
alias pip='pip3'
alias dserver='python manage.py runserver'


# Vagrant.
# --------------------------
alias vg="vagrant"
alias vgu="vagrant up"
alias vgs="vagrant status"
alias vgss="vagrant ssh"
alias vgh="vagrant halt"
alias vgp="vagrant provision"
alias vgrp="vagrant reload --provision"
alias vgd="vagrant destroy"

# Laravel
# --------------------------
alias serve="php artisan serve"    
alias art="php artisan"
alias test="vendor/bin/phpunit"
alias cu='composer update'
alias ci='composer install'
alias cdo="composer dump-autoload -o"
alias vu='vagrant up'
alias vs='vagrant ssh'
alias wakeup='cd ~/Homestead && vagrant up && vagrant ssh'
alias cclear='php artisan cache:clear'


# Docker
# --------------------------
alias dc='docker-compose'
alias dm='docker-machine'
alias vgbl="vagrant box list"

# Pgadmin4
alias pgadmin4='~/pgAdmin4/pgadmin4.sh'
