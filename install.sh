#!/bin/bash

set_environment() {
	# Use colors, but only if connected terminal supports them.
	if which tput >/dev/null 2>&1; then
		ncolors=$(tput colors)
	fi

	if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
		RED="$(tput setaf 1)"
	   	GREEN="$(tput setaf 2)"
		YELLOW="$(tput setaf 3)"
		BLUE="$(tput setaf 4)"
		BOLD="$(tput bold)"
		NORMAL="$(tput sgr0)"
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		NORMAL=""
	fi
}

install_dependencies() {
	printf "${BLUE}Installing Raspbian dependencies...${NORMAL}\n"

	sudo apt-get update \
		&& sudo apt-get upgrade -y \
		&& sudo apt-get install gammu \
					gammu-smsd \
					git \
					python-pip -y
}

clone_repository() {
	printf "${BLUE}Cloning gsmpi...${NORMAL}\n"
	command -v git >/dev/null 2>&1 || {
 		echo "Error: git is not installed"
		exit 1
	}

	env git clone --depth=1 https://github.com/3volutionsGmbH/gsmpi.git "$ZSH" || {
		printf "Error: git clone of gsmpi repo failed\n"
		exit 1
	}
}

set_environment
install_dependencies
clone_repository
