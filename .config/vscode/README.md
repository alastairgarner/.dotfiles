# VSCode config files

There is no way (as far as I know) to set a custom path for your VSCode config files. Instead, I'm storing the config in `~/.config/vscode` then generating symlinks to these files on a given machine.

```bash
# Commands on MacOS
ln -s ~/.dotfiles/.config/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/.dotfiles/.config/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.dotfiles/.config/vscode/profiles/ ~/Library/Application\ Support/Code/User
ln -s ~/.dotfiles/.config/vscode/snippets/ ~/Library/Application\ Support/Code/User

# Cursor
ln -s ~/.dotfiles/.config/vscode/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json
ln -s ~/.dotfiles/.config/vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -s ~/.dotfiles/.config/vscode/profiles/ ~/Library/Application\ Support/Cursor/User
ln -s ~/.dotfiles/.config/vscode/snippets/ ~/Library/Application\ Support/Cursor/User

# Commands on Linux
ln -s ~/.dotfiles/.config/vscode/keybindings.json ~/.config/Code/User/keybindings.json
ln -s ~/.dotfiles/.config/vscode/settings.json ~/.config/Code/User/settings.json
ln -s ~/.dotfiles/.config/vscode/profiles/ ~/.config/Code/User
ln -s ~/.dotfiles/.config/vscode/snippets/ ~/.config/Code/User
```
