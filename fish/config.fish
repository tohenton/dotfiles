################################################################################
# brew
################################################################################
if status is-interactive
    if test (uname) = Darwin
        if test -e /opt/homebrew/bin/brew
            eval (/opt/homebrew/bin/brew shellenv)
        end
    end
end

################################################################################
# PATH
################################################################################
fish_add_path ~/.local/bin


################################################################################
# Shell customizing
################################################################################

# history
# https://qiita.com/yoshiori/items/f1c01dd94bb5f0489cf6
function history-merge --on-event fish_preexec
    history --save
    history --merge
end

# Aliases
alias ls 'ls --color'
alias ll 'ls -l'
alias lla 'ls -la'

if command -q rg && command -q fzf
    alias lll 'ls -l --time-style "+%Y-%m-%d %H:%M" | rg -v / | fzf --preview=(command -s bat; or command -s batcat)" --color=always {-1}" --header-lines=1 --preview-window=down,border-top'
end

alias now 'date +%Y-%m-%d--%H-%M-%S'
alias today 'date +%Y-%m-%d'
if command -sq colordiff
    alias diff colordiff
end
alias jman 'LANG=ja_JP.utf8 man'
alias OD 'od -v -tx1z -Ax'

# Suppress greeting message
set -U fish_greeting ""

if functions --query tide
    set -g tide_git_truncation_length 64

    # Show username and hostname always
    set -g tide_left_prompt_items os context pwd git newline character
    set -g tide_right_prompt_items status cmd_duration jobs direnv node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig time
    set -g tide_context_always_display true
end

# Increase the maximum number of open file descriptors
if status --is-login
    ulimit --file-descriptor-count 65535
end


################################################################################
# Locale
################################################################################
set -Ux LANG en_US.UTF-8
set -Ux LC_CTYPE en_US.UTF-8


################################################################################
# Python
################################################################################

# pyenv
if test -d ~/.pyenv
    set -gx PYENV_ROOT ~/.pyenv
    fish_add_path $PYENV_ROOT/bin
    if command -q pyenv; and status is-interactive
        pyenv init - fish | source
    end
end

# venv
# Auto activate and deactivate venv
# https://gist.github.com/tommyip/cf9099fa6053e30247e5d0318de2fb9e
function __auto_activate_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return

    # Check if we are inside a git directory
    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
    else
        set gitdir "."
    end

    # If venv is not activated or a different venv is activated and venv exist.
    if test "$VIRTUAL_ENV" != "$gitdir/.venv" -a -e "$gitdir/.venv/bin/activate.fish"
        source $gitdir/.venv/bin/activate.fish
        # If venv activated but the current (git) dir has no venv.
    else if not test -z "$VIRTUAL_ENV" -o -e "$gitdir/.venv"
        deactivate
    end
end

# uv
if command -q uv
    uv generate-shell-completion fish | source
    if test -d ~/.venv
        source ~/.venv/bin/activate.fish
    end
end


################################################################################
# Emacs
################################################################################
set -Ux EDITOR "emacs"
function emacs
    start-emacs
    sleep 0.3
    emacsclient -t $argv
end

function is-emacs-daemon-running
    # Check if emacs daemon is running
    # Return value
    #   0 - emacs daemon is running
    #   Non-zero - emacs daemon is not runnig
    emacsclient -e "()" > /dev/null 2>&1
    return $status
end

function start-emacs
    if is-emacs-daemon-running
        echo Daemon already running
    else
        echo Starting emacs daemon
        eval (whereis emacs | tr ' ' '\n' | grep bin | head -n 1) --daemon
        echo Done
    end
end

function kill-emacs
    if is-emacs-daemon-running
        echo Killing emacs daemon
        emacsclient -e '(kill-emacs)'
        echo Done
    else
        echo No daemon running
    end
end

function remacs
    kill-emacs && emacs
end


################################################################################
# Golang
################################################################################
if test -d ~/.goenv
    set -gx GOENV_ROOT ~/.goenv
    fish_add_path $GOENV_ROOT/bin
    if command -q goenv; and status is-interactive
        goenv init - | source
    end
end


################################################################################
# Rust
################################################################################
if command -q cargo
    fish_add_path $HOME/.cargo/bin
end


################################################################################
# Misc. tools
################################################################################

# ls color setting
set -Ux LSCOLORS gxfxcxdxbxegedabagacad

# fzf
if command -q fzf
    set -Ux FZF_DEFAULT_OPTS "--no-mouse --ansi --reverse --height 75% --multi --select-1 --exit-0"
end

# GNU Global
set -Ux GTAGSLABEL pygments

# translate-shell
if command -sq trans
    alias ej 'trans en:ja'
    alias je 'trans ja:en'
end

# deepl-cli
# https://github.com/eggplants/deepl-cli/
if command -sq deepl
    function dej
        echo $argv | deepl en:ja
    end
    function dje
        echo $argv | deepl ja:en
    end
end

# mattn/memo
# https://teratail.com/questions/36536
if command -sq memo
    alias m memo
end

# less
set -Ux LESS '-R'  # R: ANSI color

# bat
if command -sq batcat
    alias bat batcat
end

# zoxide
if command -q zoxide
    zoxide init fish | source
end

# gomi
if command -q gomi
    alias rm gomi
end

# fd-find
if command -q fdfind
    alias fd fdfind
end


################################################################################
# Node
################################################################################
if test -d $HOME/.volta
    set -gx VOLTA_HOME "$HOME/.volta"
    fish_add_path "$VOLTA_HOME/bin"
end


################################################################################
# Completion
################################################################################
if ! test -f ~/.config/fish/completions/docker.fish
    curl -q https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/fish/docker.fish -o ~/.config/fish/completions/docker.fish
end
if ! test -f ~/.config/fish/completions/docker-compose.fish
    curl -q https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish -o ~/.config/fish/completions/docker-compose.fish
end


################################################################################
# ripgrep
################################################################################
if command -q rg
    set -gx RIPGREP_CONFIG_PATH ~/.ripgreprc
end


################################################################################
# claude code
################################################################################
if command -q claude
    set -gx CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN 1
end

################################################################################
# Local settings  (must be at the bottom of this file!)
################################################################################
if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end
