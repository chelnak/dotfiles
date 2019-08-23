function update_dotfiles
    bash -c "`curl -fsSL https://raw.githubusercontent.com/chelnak/dotfiles/master/linux/install.sh`"
    make -C $HOME/.dotfiles/linux
end
