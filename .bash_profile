export VISUAL=vim
export EDITOR="$VISUAL"

# Support XDG home 
export PATH="$HOME/.local/bin:$PATH"
export DYLD_LIBRARY_PATH="$HOME/.local/lib:$DYLD_LIBRARY_PATH"

# source bashrc on login shell
[[ $- == *i* && -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
