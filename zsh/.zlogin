# ~/.zlogin: executed by zsh for login shells.
# Run after .zshrc and all other startup files.

# Only run these login commands if we are NOT already inside a tmux session
if [[ -z "$TMUX" ]]; then
    neofetch
    tmux
fi
