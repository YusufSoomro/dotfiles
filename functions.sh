warn_message() {
    print -P "%F{yellow}$1%f"
}

success_message() {
    print -P "%F{green}$1%f"
}

symlink_dotfile() {
    if [[ -L $HOME/.$1 && $(readlink $HOME/.$1) = $HOME/dotfiles/.$1 ]]
    then
        # Do nothing because symlink exists with correct destination already
    elif [[ -L $HOME/.$1 && $(readlink $HOME/.$1) != $HOME/dotfiles/.$1 ]]
    then
        warn_message "Detected incorrect symlink for ~/.$1. Regenerating..."
        rm $HOME/.$1

        ln -s $HOME/dotfiles/.$1 $HOME/.$1

        success_message "Created sym link ($HOME/.$1 -> $HOME/dotfiles/.$1)"
    elif [[ -f $HOME/.$1 && ! -L $HOME/.$1 ]]
    then
        warn_message "Detected existing .$1 in home directory. Renaming to: \".deprecated-$1\""
        mv $HOME/.$1 $HOME/.deprecated-$1

        ln -s $HOME/dotfiles/.$1 $HOME/.$1

        success_message "Created sym link ($HOME/.$1 -> $HOME/dotfiles/.$1)"
    fi
}

cp_dotfile_dir_and_symlink() {
    if [[ -L $HOME/.$1 && $(readlink $HOME/.$1) = $HOME/dotfiles/.$1 ]]
    then
        # Do nothing because symlink exists with correct destination already
    elif [[ -L $HOME/.$1 && $(readlink $HOME/.$1) != $HOME/dotfiles/.$1 ]]
    then
        warn_message "Detected incorrect symlink for ~/.$1. Regenerating..."
        rm -rf $HOME/.$1

        ln -s $HOME/dotfiles/.$1 $HOME/.$1

        success_message "Created sym link for directory ($HOME/.$1 -> $HOME/dotfiles/.$1)"
    elif [[ -d $HOME/.$1 && ! -L $HOME/.$1 ]]
    then
        warn_message "Detected existing .$1 in home directory. Copying to dotfiles directory and renaming original to \".deprecated-$1\""
        cp -r $HOME/.$1 $HOME/dotfiles/.$1
        touch $HOME/dotfiles/.$1/.gitkeep

        mv $HOME/.$1 $HOME/.deprecated-$1

        ln -s $HOME/dotfiles/.$1 $HOME/.$1

        success_message "Created sym link for directory ($HOME/.$1 -> $HOME/dotfiles/.$1)"
    fi
}