if [ -d "$HOME/.bashrc.d" ]; then
  for rc in "$HOME"/.bashrc.d/*; do
    [ -f $rc ] && . $rc;
  done
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$HOME/.local/bin:$PATH"
export DYLD_LIBRARY_PATH="$HOME/.local/lib:$DYLD_LIBRARY_PATH"
