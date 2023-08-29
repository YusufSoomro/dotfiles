# Function definitions
source $HOME/dotfiles/functions.sh

# Alias definitions
source $HOME/dotfiles/aliases.sh

# ZSH config for command line prompt
source $HOME/dotfiles/.zshrc

# Git config
if [[ -L $HOME/.gitconfig && $(readlink $HOME/.gitconfig) = $HOME/dotfiles/.gitconfig ]]
then
    # Do nothing because symlink exists with correct destination already
elif [[ -L $HOME/.gitconfig && $(readlink $HOME/.gitconfig) != $HOME/dotfiles/.gitconfig ]]
then
    warn_message "Detected incorrect symlink for ~/.gitconfig. Regenerating..."
    rm $HOME/.gitconfig

    ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

    success_message "Created sym link ($HOME/.gitconfig -> $HOME/dotfiles/.gitconfig)"
elif [[ -f $HOME/.gitconfig && ! -L $HOME/.gitconfig ]]
then
    warn_message "Detected existing .gitconfig in home directory. Renaming to: .deprecated-gitconfig"
    mv $HOME/.gitconfig $HOME/.deprecated-gitconfig

    ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

    success_message "Created sym link ($HOME/.gitconfig -> $HOME/dotfiles/.gitconfig)"
fi