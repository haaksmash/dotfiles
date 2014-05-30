#! /usr/bin/env bash
set -e

main() {
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	# sore the calling directory to return later
	CALLING_DIR=$PWD
	cd $DIR
    if [[ $1 == "--ycm" ]]; then
		rm .youcompletemesetup
		vim +BundleInstall +qall
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

	create_local_bin
	setup_local_symlinks
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
		if [ -e $HOME/.${filename} ]; then
			echo "moving old .$filename to .${filename}.bak"
			mv $HOME/.$filename $HOME/.${filename}.bak
		fi
		echo "linking $DIR/$source_dir/$filename $HOME/.$filename"
		ln -s "$DIR/$source_dir/$filename" "$HOME/.$filename"
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

create_local_bin() {
	(cd ~/local) || mkdir ~/local
	(cd ~/local/bin) || mkdir ~/local/bin
}

setup_local_symlinks() {
	setup_vim_symlink
}

setup_vim_symlink() {
	vim_version=`vim --version | head -1 | cut -d " " -f 5`
	if [[ $(echo "$vim_version >= 7.4" | bc) = 1 ]]; then
		ln -s `which vim` ~/local/bin/vim
	else
		if [ -d $DIR/vim-files/vim/bundle/YouCompleteMe ]; then
			echo "Your version of vim is too old to use YCM -- removing the YCM bundle..."
			echo "rerun this installer with the --ycm option once vim is >= 7.4"
			echo "your new shellrc files will look for 'vim' in ~/local/bin, but this has not been setup for you."
			rm -rf $DIR/vim-files/vim/bundle/YouCompleteMe
		fi
	fi
}

main $@
