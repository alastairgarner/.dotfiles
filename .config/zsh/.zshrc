#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

source_config_for_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS"
    source "${ZDOTDIR:-$HOME}/.zsh_macos"
    return
  fi

  OS=$(cat /etc/os-release | grep -Po '^NAME=\K.*')

  # Source sensitive aliases.
  if [[ $OS == *"Debian"* ]]; then
    echo "Debian"
    source "${ZDOTDIR:-$HOME}/.zsh_debian"
  elif [[ $OS == *"Nix"* ]]; then
    echo "NixOS"
    source "${ZDOTDIR:-$HOME}/.zsh_nix"
  else
    echo "Unknown OS type: $OSTYPE"
  fi
}

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source .env.
if [[ -s "${ZDOTDIR:-$HOME}/.env" ]]; then
  source "${ZDOTDIR:-$HOME}/.env"
fi

source_config_for_os

# Source any shared config
if [[ -s "${ZDOTDIR:-$HOME}/.zsh_shared" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh_shared"
fi

# Aliases
# I store non-sensitive aliases here, but keep any sensitive aliases in a
# separate file, so I don't have to commit it to source control.

# Utility
alias myip="curl http://ipecho.net/plain; echo"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
