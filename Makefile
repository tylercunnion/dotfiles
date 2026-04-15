install: install-tig install-dircolors install-tmux install-fish install-nvim #brew-bundle

install-nvim: $(HOME)/.config/nvim install-pynvim
install-tig: $(HOME)/.tigrc
install-dircolors: $(HOME)/.dir_colors
install-tmux: $(HOME)/.tmux.conf
install-fish: $(HOME)/.config/fish

setup-remote:
	./setup-remote.sh

install-pynvim:
	./install-pynvim.sh

brew-bundle:
	brew bundle

install-rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

$(HOME)/.config/nvim:
	mkdir -p $(HOME)/.config
	ln -s $(CURDIR)/nvim $(HOME)/.config/nvim

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
	rm $(HOME)/.tigrc
	rm $(HOME)/.dir_colors
	rm $(HOME)/.tmux.conf
	rm $(HOME)/.config/fish
	rm $(HOME)/.config/nvim
	rm -rf $(CURDIR)/pynvim-venv
