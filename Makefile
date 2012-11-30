install: install-zsh install-vim install-tig install-dircolors

install-zsh: $(HOME)/.zshrc $(HOME)/.zsh
install-vim: $(HOME)/.vimrc $(HOME)/.vim
install-tig: $(HOME)/.tigrc
install-dircolors: $(HOME)/.dir_colors


$(HOME)/.zshrc:
	ln -s $(CURDIR)/zshrc $(HOME)/.zshrc
$(HOME)/.zsh:
	ln -s $(CURDIR)/zsh $(HOME)/.zsh

$(HOME)/.vimrc:
	ln -s $(CURDIR)/vimrc $(HOME)/.vimrc
$(HOME)/.vim:
	ln -s $(CURDIR)/vim $(HOME)/.vim

$(HOME)/.tigrc:
	ln -s $(CURDIR)/tigrc $(HOME)/.tigrc

$(HOME)/.dir_colors:
	ln -s $(CURDIR)/dircolors-solarized/dircolors.ansi-universal $(HOME)/.dir_colors

clean:
	rm $(HOME)/.zshrc
	rm $(HOME)/.zsh
	rm $(HOME)/.vimrc
	rm $(HOME)/.vim
	rm $(HOME)/.tigrc
	rm $(HOME)/.dir_colors
