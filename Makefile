all: vim nvim haskell tmux git shell latex python

vim:
	echo "Linking vim ..."
	ln -fs ${PWD}/vim/vimrc ~/.vimrc
	ln -fs ${PWD}/vim/encrypted_vimrc ~/.encrypted_vimrc
	rm ~/.vim
	ln -fs ${PWD}/vim ~/.vim
	echo "Installing vim-plug"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim:
	echo "Linking nvim ..."
	ln -fs ${PWD}/vim/vimrc ~/.nvimrc
	rm ~/.nvim
	ln -fs ${PWD}/vim ~/.nvim

haskell:
	echo "Linking GHCI configuration"
	ln -fs ${PWD}/ghci.conf ~/.ghc/ghci.conf

tmux:
	echo "Linking tmux ..."
	ln -fs ${PWD}/tmux_conf ~/.tmux.conf
	ln -fs ${PWD}/tmux-powerlinerc ~/.tmux-powerlinerc
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	
git:
	echo "Linking git ..."
	ln -fs ${PWD}/git/gitconfig ~/.gitconfig
	ln -fs ${PWD}/git/gitignore ~/.gitignore
	echo "Git SSH credential helper ..."
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		git config --global credential.helper osxkeychain
	fi


shell:
	echo "Linking shell profiles ..."
	ln -fs ${PWD}/bash_profile ~/.bash_profile
	ln -fs ${PWD}/zshrc ~/.zshrc
	echo "Linking inputrc ..."
	ln -fs ${PWD}/inputrc ~/.inputrc

latex:
	echo "Linking latexmkrc..."
	ln -fs ${PWD}/latexmkrc ~/.latexmkrc

python:
	echo "Linking IPython profile preferences (mbp) ..."
	rm -rf ~/.ipython/profile_mbp/startup
	rm ~/.ipython/profile_mbp/ipython_config.py
	rm -rf ~/.jupyter
	ln -fs ${PWD}/ipython/startup ~/.ipython/profile_mbp/startup
	ln -fs ${PWD}/ipython/ipython_config.py ~/.ipython/profile_mbp/ipython_config.py
	ln -fs ${PWD}/jupyter ~/.jupyter
	echo "Linking matplotlibrc ..."
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		ln -fs ${PWD}/ipython/matplotlibrc ~/.matplotlib/matplotlibrc
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		ln -fs ${PWD}/ipython/matplotlibrc ~/.matplotlib/matplotlibrc
	fi

brew:
	echo "Installing useful homebrew utilities"
	./brew.sh

pip:
	echo "Installing useful python modules"
	./python.sh
