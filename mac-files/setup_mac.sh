install_homebrew() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

grab_dependencies() {
  brew install git
  brew install vim
  brew install zsh
  brew install caskroom/cask/brew-cask
}

main() {
  # abort if homebrew is already installed; we don't want to accidentaly stomp on things
  if hash brew 2>/dev/null; then
    exit(0)
  install_homebrew
  grab_dependencies
}

main
