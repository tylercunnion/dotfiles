install: install-zsh install-vim install-tig install-dircolors install-tmux install-fish

install-zsh: $(HOME)/.zshrc $(HOME)/.zsh
install-vim: $(HOME)/.vimrc $(HOME)/.vim $(HOME)/.vimpackfile install-minpac
install-tig: $(HOME)/.tigrc
install-dircolors: $(HOME)/.dir_colors
install-tmux: $(HOME)/.tmux.conf
install-fish: $(HOME)/.config/fish

$(HOME)/.zshrc:
	ln -s $(CURDIR)/zshrc $(HOME)/.zshrc
$(HOME)/.zsh:
	ln -s $(CURDIR)/zsh $(HOME)/.zsh

$(HOME)/.vimrc:
	ln -s $(CURDIR)/vimrc $(HOME)/.vimrc
$(HOME)/.vimpackfile:
	ln -s $(CURDIR)/vimpackfile $(HOME)/.vimpackfile
$(HOME)/.vim:
	ln -s $(CURDIR)/vim $(HOME)/.vim

install-minpac:
	mkdir -p $(HOME)/.vim/pack/minpac/opt
	cd $(HOME)/.vim/pack/minpac/opt && \
	git clone https://github.com/k-takata/minpac.git

$(HOME)/.tigrc:
	ln -s $(CURDIR)/tigrc $(HOME)/.tigrc

$(HOME)/.dir_colors:
	ln -s $(CURDIR)/dircolors-solarized/dircolors.ansi-universal $(HOME)/.dir_colors

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
