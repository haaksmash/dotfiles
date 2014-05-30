#! /usr/bin/env bash
set -e

main() {
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	# sore the calling directory to return later
	CALLING_DIR=$PWD
	cd $DIR
    if [[ $1 == "--ycm" ]]; then
		rm .youcompletemesetup
		setup_youcompleteme
		exit 0
	else
		install_everything
	fi
	cd $CALLING_DIR
}

install_everything() {

	echo "updating git modules..."
	setup_gitmodules

	echo "setting up vim files..."
	symlink_files vim-files vimrc vim
	echo "installing bundles (vim will appear)..."
	vim +BundleInstall +qall
	setup_youcompleteme

	echo "setting up tmux files..."
	symlink_files tmux-files tmux.conf

	echo "setting up bash files..."
	symlink_files bash-files bashrc bash_profile

	echo "setting up zsh files..."
	symlink_files zsh-files zshrc oh-my-zsh

	echo "setting up powerline..."

	echo "setting up git files..."
	symlink_files git-files gitconfig
}

setup_gitmodules() {
	# assumes we're already in a git repo
	git submodule init
	git submodule update --init --recursive
}

symlink_files() {
	source_dir=$1
	filenames=${@:2}

	for filename in $filenames
	do
		if [ -f $home/.${filename} ] || [ -l $home/.$filename ]; then
			echo "moving old .$filename to .${filename}.bak"
			mv $home/.$filename $home/.${filename}.bak
		fi
		echo "linking $dir/$source_dir/$filename $home/.$filename"
		ln -s "$dir/$source_dir/$filename" "$home/.$filename"
	done
}

setup_youcompleteme() {
	# YouCompleteMe is slow to setup, so don't do it if we don't have to
	if [ -e $DIR/.youcompletemesetup ]; then
		echo "YouCompleteMe already setup, skipping... (remove .youcompletemesetup to force)"
	else
		echo "setting up YouCompleteMe..."
		cd vim-files/vim/bundle/YouCompleteMe
		./install.sh --clang-completer
		cd $DIR
		touch .youcompletemesetup
	fi
}

main $@
