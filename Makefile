# -*- mode: Makefile -*-
.PHONY: bash emacs fish git go python tmux vim zsh

all:

install: bash emacs fish git go python tmux vim zsh
	@echo install

bash:
	@ln -sfnv $(abspath bash/.bashrc) ~/

emacs:
	@mkdir -p ~/.emacs.d
	@ln -sfnv $(abspath emacs/init.el) ~/.emacs.d/

fish:
	@mkdir -p ~/.config/fish/functions
	@ln -sfnv $(abspath fish/config.fish)                      ~/.config/fish/
	@ln -sfnv $(abspath fish/functions/fish_prompt.fish)       ~/.config/fish/functions/
	@ln -sfnv $(abspath fish/functions/fish_right_prompt.fish) ~/.config/fish/functions/
	@ln -sfnv $(abspath fish/functions/fish_remove_path.fish) ~/.config/fish/functions/


git:
	@mkdir -p ~/.config/git
	@ln -sfnv $(abspath git/config) ~/.config/git/config

go:
	@ln -sfnv $(abspath go/.goenvrc) ~/

python:
	@mkdir -p ~/.ipython/profile_default
	@ln -sfnv $(abspath ipython_config.py) ~/.ipython/profile_default
	@ln -sfnv $(abspath python/.flake8)    ~/

tmux:
	@ln -sfnv $(abspath tmux/.tmux.conf) ~/

vim:
	@ln -sfnv $(abspath vim/.vimrc) ~/

zsh:
	@ln -sfnv $(abspath zsh/.zshrc)  ~/
	@ln -sfnv $(abspath zsh/.zlogin) ~/

uninstall:
	@echo 'Remove installed dot files...'
	@-rm -v ~/.bashrc
	@-rm -v ~/.emacs.d/init.el
	@-rm -v ~/.config/fish/config.fish
	@-rm -v ~/.config/fish/functions/fish_prompt.fish
	@-rm -v ~/.config/fish/functions/fish_right_prompt.fish
	@-rm -v ~/.config/git/config
	@-rm -v ~/.goenvrc
	@-rm -v ~/.flake8
	@-rm -v ~/.ipython/profile_default/ipython_config.py
	@-rm -v ~/.tmux.conf
	@-rm -v ~/.vimrc
	@-rm -v ~/.zshrc
	@-rm -v ~/.zlogin
