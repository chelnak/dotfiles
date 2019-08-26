function update_dotfiles
    curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/chelnak/dotfiles/master/linux/install.sh | bash
    make -C $HOME/.dotfiles/linux
end
