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
	git clone https://github.com/WordlessSafe1/dotfiles .dotfiles

	cd .dotfiles
	./install.sh link
fi


