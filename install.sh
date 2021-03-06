#! /usr/bin/env bash
set -e

main() {
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	# sore the calling directory to return later
	CALLING_DIR=$PWD
	cd $DIR
	if [[ $1 == "--ycm" ]]; then
		local vim_version=`vim --version | head -1 | cut -d " " -f 5`
		if [[ $(echo "$vim_version >= 7.4" | bc) = 1 ]]; then
			rm .youcompletemesetup
			vim +BundleInstall +qall
			setup_youcompleteme
		else
			echo "YCM requires vim 7.4 and up; you have ${vim_version}."
		fi

	else
		install_everything

	fi
	cd $CALLING_DIR
}

install_everything() {
	echo "setting up the mac environment"
	bash mac-files/setup_mac.sh

	echo "updating git modules..."
	setup_gitmodules

	echo "setting up vim files..."
	symlink_files vim-files vimrc vim
	echo "installing bundles (vim will appear)..."
	vim +BundleInstall +qall
	setup_youcompleteme

  echo "setting up neovim files..."
  mkdir ~/.config
  ln -s ~/.vim ~/.config/nvim

	echo "setting up tmux files..."
	symlink_files tmux-files tmux.conf

	echo "setting up bash files..."
	symlink_files bash-files bashrc bash_profile

	echo "setting up zsh files..."
	setup_zsh

	echo "setting up powerline..."

	echo "setting up git files..."
	symlink_files git-files gitconfig

	create_local_bin
	setup_local_symlinks

	echo "sourcing rc files..."
	source_rc_files
}

setup_gitmodules() {
	# assumes we're already in a git repo
	git submodule init
	git submodule update --init --recursive
}

symlink_files() {
	local source_dir=$1
	local filenames=${@:2}

	for filename in $filenames
	do
		if [ -e $HOME/.${filename} ]; then
			echo "moving old .$filename to .${filename}.bak"
			mv $HOME/.$filename $HOME/.${filename}.bak
		fi
		echo "linking $DIR/$source_dir/$filename -> $HOME/.$filename"
		ln -s "$DIR/$source_dir/$filename" "$HOME/.$filename"
	done
}

setup_youcompleteme() {
	# YouCompleteMe is slow to setup, so don't do it if we don't have to
	if [ -e $DIR/.youcompletemesetup ]; then
		echo "YouCompleteMe already setup, skipping... (remove .youcompletemesetup to force)"
	else
		echo "setting up YouCompleteMe..."
		cd vim-files/vim/plugged/YouCompleteMe
		./install.sh --clang-completer
		cd $DIR
		touch .youcompletemesetup
	fi
}

setup_zsh() {
	symlink_files zsh-files zshrc
	symlink_antigen
}

symlink_antigen() {
	if [ -e $HOME/antigen.zsh ]; then
		echo "moving old antigen file to antigen.zsh.bak"
		mv $HOME/antigen.zsh $HOME/antigen.zsh.bak
	fi
	echo "linking $DIR/zsh-files/antigen/antigen.zsh -> $HOME/antigen.zsh"
	ln -s "$DIR/zsh-files/antigen/antigen.zsh" "$HOME/antigen.zsh"
}

create_local_bin() {
	(cd ~/local) || mkdir ~/local
	(cd ~/local/bin) || mkdir ~/local/bin
}

setup_local_symlinks() {
	setup_vim_symlink
}

setup_vim_symlink() {
	local vim_version=`vim --version | head -1 | cut -d " " -f 5`
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

source_rc_files() {
	local current_shell=$(ps -p $$ | grep `echo $$` | awk '{print $4}')
	if [[ "$current_shell" == "zsh" ]]; then
		source ~/.zshrc
	elif [[ "$current_shell" == "bash" ]]; then
		source ~/.bashrc
	fi
}

main $@
