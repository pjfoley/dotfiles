#!/bin/bash

l_DOTFILES_GIT_REMOTE="git@github.com:pjfoley/dotfiles.git"
l_DOTFILES_DIRECTORY="${HOME}/.dotfiles"

l_CURRENT_DIR=${PWD}

# Install the GIT Repo
if [[ ! -d ${l_DOTFILES_DIRECTORY} ]]; then
  git clone ${l_DOTFILES_GIT_REMOTE} ${l_DOTFILES_DIRECTORY}

  cd ${l_DOTFILES_DIRECTORY}

  # Update submodules
  git submodule update --recursive --init
  cd ${l_CURRENT_DIR}
fi
