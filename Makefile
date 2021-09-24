install: install-zsh install-vim install-tig install-dircolors install-tmux install-fish brew-bundle

install-zsh: $(HOME)/.zshrc $(HOME)/.zsh
install-vim: $(HOME)/.vimrc $(HOME)/.vim install-pynvim
install-nvim: $(HOME)/.config/nvim
install-tig: $(HOME)/.tigrc
install-dircolors: $(HOME)/.dir_colors
install-tmux: $(HOME)/.tmux.conf $(HOME)/.tmux
install-fish: $(HOME)/.config/fish

install-pynvim:
	pip3 install --upgrade pynvim

brew-bundle:
	brew bundle

$(HOME)/.zshrc:
	ln -s $(CURDIR)/zshrc $(HOME)/.zshrc
$(HOME)/.zsh:
	ln -s $(CURDIR)/zsh $(HOME)/.zsh

$(HOME)/.vimrc:
	ln -s $(CURDIR)/vimrc $(HOME)/.vimrc
$(HOME)/.vim:
	ln -s $(CURDIR)/vim $(HOME)/.vim

$(HOME)/.config/nvim:
	mkdir -p $(HOME)/.config
	ln -s $(CURDIR)/nvim $(HOME)/.config/nvim

$(HOME)/.tigrc:
	ln -s $(CURDIR)/tigrc $(HOME)/.tigrc

$(HOME)/.dir_colors:
	ln -s $(CURDIR)/dircolors-solarized/dircolors.ansi-dark $(HOME)/.dir_colors

$(HOME)/.tmux:
	ln -s $(CURDIR)/tmux $(HOME)/.tmux

$(HOME)/.tmux.conf:
	ln -s $(CURDIR)/tmux.conf $(HOME)/.tmux.conf

$(HOME)/.config/fish:
	mkdir -p $(HOME)/.config
	ln -s $(CURDIR)/fish $(HOME)/.config/fish

clean:
	rm $(HOME)/.zshrc
	rm $(HOME)/.zsh
	rm $(HOME)/.vimrc
	rm $(HOME)/.vim
	rm $(HOME)/.tigrc
	rm $(HOME)/.dir_colors
	rm ($HOME)/.config/fish
