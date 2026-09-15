[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

### OS detection ##############################################################
os=$OSTYPE
if [[ ${os:0:6} == "darwin" ]]; then
    os="darwin"
elif [[ ${os:0:5} == "linux" ]]; then
    os="linux"
fi

### ALIAS #####################################################################
 alias ..='cd ..'
 alias ls='lsd --group-directories-first'
 alias la='lsd --almost-all --group-directories-first'
 alias l1='lsd --almost-all --group-directories-first --oneline'
 alias ll='lsd --almost-all --group-directories-first --long'
 alias lr="tree --du -C -h"
 alias lrd='tree --du -C -h -l -d'
 alias nv="nvim"
 alias ss='du -s * | sort -n | cut -f 2- | while read a; do du -hs "$a"; done'
 alias filenamedate='date +"%Y_%m_%d_%H_%M"'
 alias uuid='uuidgen | tr " [A-Z]" " [a-z]"'
 alias cksum='sha256sum'
 alias pyserver='python3 -m http.server 8000 --bind 127.0.0.1'
 alias git-pull-all='find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull origin main \;'
 alias auth0-mcp-login="npx @auth0/auth0-mcp-server@latest init --scopes 'read:*'"

### OPTIONS ###################################################################

# vim-style line editing
 bindkey -v
 bindkey "jj" vi-cmd-mode
 bindkey '^R' history-incremental-search-backward

# with autocd you can type the name of the directory and it will become the
# current directory
 setopt autocd
 setopt extendedglob
 setopt nomatch
 setopt notify
# correct will enable spelling correction for commands
 setopt correct
# correctall will enable spelling correction for parameters
 unsetopt correctall
# noclobber will prevent accidentally overwriting an existing file
# If you really do want to clobber a file, you can use the >! operator.
 setopt noclobber

### HISTORY -------------------------------------------------------------------
# Like INC_APPEND_HISTORY + re-read history whenever accessing it
 setopt SHARE_HISTORY
# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
 setopt append_history

### AUTOCOMPLETION ------------------------------------------------------------

# TODO: enabling this vi mode plugin breaks tab autocomplete
#source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
#source /opt/homebrew/share/zsh-system-clipboard/zsh-system-clipboard.zsh

#source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh

#source /opt/homebrew/share/zsh-f-sy-h/F-Sy-H.plugin.zsh
#source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#source /opt/homebrew/share/zsh-autopair/autopair.zsh
#source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

#if type brew &>/dev/null; then
#    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#fi

#if type brew &>/dev/null; then
#  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#  autoload -Uz compinit
#  compinit
#fi

fpath=("$HOME/.zfunc" $fpath)
autoload -U compinit
compinit
#zstyle ':completion:*' menu select # autocompletion with menu select

# enable alias completion
 setopt completealiases

### Language-specific #########################################################

### ERLANG --------------------------------------------------------------------
# . /Users/igaray/.local/bin/erlang/23.3.4.9/activate

### ELIXIR --------------------------------------------------------------------
# test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
# source $HOME/.kiex/elixirs/elixir-1.11.4.env

### RUST ----------------------------------------------------------------------
source $HOME/.cargo/env

### FUNCTIONS #################################################################
source ~/src/dotfiles/zsh/common/.zsh_functions
source ~/.config/broot/launcher/bash/br

# BEGIN SHIPHERO --------------------------------------------------------------
autoload -U add-zsh-hook

function _load_venv () {
   if [ -d ".venv" ] && [ -z "$VIRTUAL_ENV" ]; then
        source .venv/bin/activate
   fi
}

# load the hook to be executed every time we change directory
add-zsh-hook chpwd _load_venv

# go to project root if inside a venv
alias cdproject='[ -n "$VIRTUAL_ENV" ] && cd "$(dirname "$VIRTUAL_ENV")"'
# END SHIPHERO -----------------------------------------------------------------

### THEME #####################################################################

# Disabled in favor of starship
#source ~/src/dotfiles/zsh/common/.zsh_theme

# load vcs info and colors for prompt
#autoload -Uz vcs_info
#autoload -U colors && colors
#setopt prompt_subst

# prompt theme
#autoload -U promptinit
#promptinit

#prompt_igaray_setup "$@"

# TODO: configure
# https://starship.rs/config/
# https://starship.rs/presets/
eval "$(starship init zsh)"
fortune ~/src/dotfiles/fortune/

### END OF FILE ###############################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
