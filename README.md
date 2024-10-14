# .dotfiles

This repo is for managing my dotfiles across different machines

## Setup

**Dependencies**

- Git
- GNU Stow

**Steps**

```bash
# Pull the repo
git clone git@github.com:alastairgarner/.dotfiles.git ~/.dotfiles

# Pull the submodules
cd ~/.dotfiles
git submodule update --init --recursive

# Create symlinks in ~/ for everything in ~/.dotfiles
stow .

# Restart the terminal
```
