#!/bin/bash

cd ~ > log.txt

echo "Updating..."
sudo dnf check-update
echo "Upgrading..."
sudo dnf upgrade -y

wget "https://raw.githubusercontent.com/Wayfarer98/FedoraSetup/main/packages.txt" >> log.txt
echo "Installing packages..."
xargs -a packages.txt sudo dnf install -y
rm packages.txt

echo "Upgrading pip..."
python -m pip install --upgrade pip
python -m pip install cmake

read -p 'Please write the name you wish to use for git: ' gituser
read -p 'Please write the email you wish to use for git: ' gitemail
read -p 'Write your company email: ' companyemail

echo  "[user]" > .gitconfig-work
echo "    user = $gituser" >> .gitconfig-work
echo "    email = $companyemail" >> .gitconfig-work
echo "    #signingkey = add key here" >> .gitconfig-work

echo "[user]" > .gitconfig
echo "    name = $gituser" >> .gitconfig
echo "    email = $gitemail" >> .gitconfig
echo "# Uncomment below when signingkey has been added" >> .gitconfig
echo "    #signing = add key here" >> .gitconfig
echo "#[commit]" >> .gitconfig
echo "    #gpgsign = true" >> .gitconfig
echo '[includeIf "gitdir:~/Documents/Work/"]' >> .gitconfig
echo "    path = ~/.gitconfig-work" >> .gitconfig
echo "[init]" >> .gitconfig
echo "    defaultBranch = main" >> .gitconfig

echo "Git credentials are set up"

echo "Adding ssh key to github"
yes "" | ssh-keygen -t ed25519 -C "$gitemail"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

sudo dnf install gh -y

# authenticate gh on the web
echo 'Authenticate the github CLI'
gh auth login -h github.com -s admin:public_key

# Install zsh
echo "Installing zsh..."
sudo dnf install zsh -y
sudo -k chsh -s "$(which zsh)" "$USER"

echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh

echo -e "\nYour initial setup is complete\n"
