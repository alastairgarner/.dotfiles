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

**Keeping submodules in sync**

Git submodules allow you to nest a git repo inside another git repo locally. The parent then refers to a specific commit in the child repo.

Example workflow: Committing and pushing.

```bash
# Navigate to the submodule
cd ~/.dotfiles/.config/nvim

# Make a commit to the submodule and push
git commit -m "Update leader key"
git push

# Navigate to the parent directory
cd ~/.dotfiles/

# Commit and push the reference to the latest child commit
git add .config/nvim
git push
```

Example workflow: Pulling changes on another machine

```bash
# Pull and sync changes on another machine
git submodule update --recursive

# You can optionally use the --init flag, if it's the first time you're setting up the repo
```

## Neovim

General tidbits for working with the Kickstart.nvim template

**Update neovim packages using the lazy lock file**

With nvim open type `:Lazy` to enter the lazy.nvim menu, then hit `R` to restore packages to the version in the `lazy-lock.json` file.
