#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# move vim stuff
for FILENAME in vimrc vim
do
	if [ -e $HOME/.$FILENAME ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/vim-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/vim-files/$FILENAME $HOME/.$FILENAME
done

# move tmux stuff

for FILENAME in tmux.conf
do
	if [ -e $HOME/.${FILENAME} ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/tmux-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/tmux-files/$FILENAME $HOME/.$FILENAME
done

for FILENAME in bashrc bash_profile
do
	if [ -e $HOME/.${FILENAME} ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/bash-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/bash-files/$FILENAME $HOME/.$FILENAME
done

for FILENAME in zshrc oh-my-zsh
do
	if [ -e $HOME/.${FILENAME} ]; then
		echo "Moving old .$FILENAME to .${FILENAME}.bak"
		mv $HOME/.$FILENAME $HOME/.${FILENAME}.bak
	fi
	echo "linking $DIR/zsh-files/$FILENAME $HOME/.$FILENAME"
	ln -s $DIR/zsh-files/$FILENAME $HOME/.$FILENAME
done
