#! /usr/bin/env bash
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
set -e

install_homebrew() {
  user_command ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

grab_dependencies() {
  user_command brew install git
  user_command brew install vim
  user_command brew install zsh
  user_command brew install caskroom/cask/brew-cask
  user_command brew install tmux
  user_command brew install ag
  user_command brew install direnv
  user_command brew cask install hammerspoon
  user_command brew cask install karabiner
  user_command brew cask install seil
}

user_command() {
  echo "$@"
  sudo -u $(logname) $@
}

main() {
  # abort if homebrew is already installed; we don't want to accidentaly stomp on things
  if type brew &> /dev/null; then
    if [[ "$1" != "--force" ]]; then
      echo "homebrew is already installed; this mac has probably been set up already!"
      echo "run with --force if you really want to continue"
      exit 0
    fi
  else
    install_homebrew
  fi
  grab_dependencies
  if [ -z $ZSH_NAME ]; then
    echo "zsh is already the default shell :)"
  else
    change_shell_to_zsh
  fi
  echo "done setting up the mac!"
}

change_shell_to_zsh() {
  if grep -Fqx "$ZSH_PATH" /etc/shells; then
    echo "zsh already an allowed default shell :)"
  else
    echo "$(which zsh)" >> /etc/shells
  fi
  chsh -s $(which zsh)
}

main $@
