#!/bin/bash

[[ ! -d "~/default" ]] && mkdir -p "~/default"

[[ ! -e ~/default/dotfiles ]] && cat << 'EOF' > ~/default/dotfiles
# Defaults for dotfiles - sourced by various dotfiles scripts

# Location of dotfiles GIT Repo
DOTFILES_GIT_REPO="${DOTFILES_GIT_REPO:=git@github.com:pjfoley/dotfiles.git}"

# User's Home Location
USER_HOME="${USER_HOME:=${HOME}}"

# Location to store dotfiles
DOTFILES_LOC="${DOTFILES_LOC:=${USER_HOME}/.dotfiles}"

# Location of the Home Directory files withing the dotfiles repo
DOTFILES_SRC="${DOTFILES_SRC:=${DOTFILES_LOC}/home}"

# Backup existing dotfiles if it will be replaced
DOTFILES_BKUP="${DOTFILES_BKUP:=${USER_HOME}/.dotfiles_org}"

# Do we want to backup existing dotfiles
BACKUP=true

# Setup Dotfiles location for GIT variables
DOTFILES_GIT_DIR="${DOTFILES_GIT_DIR:=${DOTFILES_LOC}/.git}"
DOTFILES_GIT_WORK_TREE="${DOTFILES_GIT_WORK_TREE:=${DOTFILES_LOC}}"
EOF

l_CURRENT_DIR=${PWD}

# Install the GIT Repo
if [[ ! -d ${DOTFILES_LOC} ]]; then
  git clone ${DOTFILES_GIT_REPO} ${DOTFILES_LOC}

  cd ${DOTFILES_LOC}

  # Update submodules
  git submodule update --recursive --init
  cd ${l_CURRENT_DIR}
fi
