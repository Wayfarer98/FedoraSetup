#!/bin/bash

cd ~

echo "Getting dotfiles..."
git init
echo * > .gitignore
git remote add origin git@github.com:Wayfarer98/.dotfiles.git
git fetch
git reset --hard origin/main

# Build nerd font
fc-cache -fv

# Install neovim
echo "Installing neovim..."
sudo dnf copr enable agriffis/neovim-nightly
sudo dnf install -y neovim python3-neovim

# Install oh-my-zsh
echo "Installing oh-my-zsh..."
cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

echo "Cloning oh-my-zsh plugins..."
git clone https://github.com/ptavares/zsh-exa.git ~/.oh-my-zsh/custom/plugins/zsh-exa
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


echo "Installing tmux..."
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure
make && sudo make install

echo "Cloning tmux package manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing fzf..."
cd ~
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz

echo "Installing nvm and node..."
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash'

echo "Installing alacritty..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exec zsh
rustup override set stable
rustup update stable

git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

echo "Follow the remaining steps in the README to finish configuration"
