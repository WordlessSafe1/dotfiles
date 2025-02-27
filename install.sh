#!/bin/bash

if [[ $1 == "link" ]]; then
	GLOBIGNORE=.:..
	files=(./*)
	unset GLOBIGNORE
	for file in "${files[@]}" ; do
		if [[ $file == "./.git" || !($file =~ ^\./\..* )  ]]; then
			continue
		fi
		echo Next: $file
		rm -f ~/$file
		ln -s ~/.dotfiles/$file ~/$file
	done
else
	mkdir -p ~/.dotfiles
	cd ~/.dotfiles

	files=$(curl https://api.github.com/repos/WordlessSafe1/dotfiles/contents/)
	files=($(grep -oE "\"path\":\s*\"([^\"]+)\"" <<< "$files"))
	
	for file in "${files[@]}" ; do
		if [[ $file == "\"path\":" ]]; then
			continue
		fi
		file="${file%?}"
		file="${file:1}"
		wget https://raw.githubusercontent.com/WordlessSafe1/dotfiles/refs/heads/master/$file
	done

	bash ./install.sh link
fi


