#!/bin/bash

l_DOTFILES_DIRECTORY="${HOME}/.dotfiles"
l_DOTFILES_BASH_DIRECTORY="${l_DOTFILES_DIRECTORY}/bash"
l_DOTFILES_GIT_REMOTE="https://github.com/pjfoley/dotfiles.git"
l_ORG_DOTFILES_BACKUP_LOCATION="${HOME}/.dotfiles_org"

[[ ! -d ${l_DOTFILES_DIRECTORY} ]] && echo "~/.dotfiles does not exist, please clone your repo exiting" && exit 1;

source ${l_DOTFILES_DIRECTORY}/lib/utils

usage() {

cat <<EOT
Install dotfiles from git repo - Peter Foley - http://github.com/pjfoley

Usage: $(basename "$0") [options]

Options:
    -l, --dotfiles-loc      Location to install dotfiles (defaults to ~/.dotfiles)
    -g, --git-loc           Git Repo (defaults to my repo)

Documentation can be found at https://github.com/pjfoley/dotfiles/

Copyright (c) Peter Foley
Licensed under the MIT license.
EOT

}

# Test for known flags
for opt in $@
do
    case $opt in
        -l | --dotfiles-loc) shift
                             l_DOTFILES_DIRECTORY=$1
          ;;
        -g | --git-loc)      shfit
                             l_DOTFILES_GIT_REMOTE=$1
          ;;
        -h|--help)           usage
                             exit 1
          ;;
        -*|--*) echo "Warning: invalid option $opt" 
                exit 1 ;;
    esac
done

mkdir -p ~{bin,dev/scratch,tmp}

e_header "Backing up original dotfiles ..."
  source ${l_DOTFILES_DIRECTORY}/lib/post-merge.git_hook
e_success "Finished backing up!!!"

cp ${l_DOTFILES_DIRECTORY}/lib/post-merge.git_hook ${l_DOTFILES_DIRECTORY}/.git/hooks/post-merge

source ~/.profile
