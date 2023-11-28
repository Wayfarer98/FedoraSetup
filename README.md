# Setup guide for new fresh Ubuntu install

1. run:  
    ```
    sudo visudo
    ```
    Find the line ``` %wheel ALL=(ALL) ALL ```
    Comment it out and uncomment line ``` %wheel ALL=(ALL) NOPASSWD:ALL ```

2. run:
    ```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Wayfarer98/FedoraSetup/main/setup.sh)"
    ```
    Follow the prompt

3. run:
    ```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Wayfarer98/FedoraSetup/main/configure.sh)"
    ```

4. To finish the setup, do the following in order:
    - Relog on the computer
    - Change the terminal default font to Hack Nerd Font
    - Open the terminal and allow oh-my-zsh to install plugins
    - Run ```nvm install node``` to install the lates version of node
    - Open tmux by running ```tmux```
    - If tmux does not automatically install plugins, press <prefix> I. The prefix is currently set to <C-a>. The default is <C-b>
    - Open neovim by running ```nvim .``` This might be a bit wonky because a lot needs installation
    - If you wish to rebind caps lock, go to `Tweaks -> Keyboard & Mouse -> Additional Layout Options` and change caps lock behaviour to act as Ctrl
    - You are now done
