export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DISABLE_SPRING=true
# Shortcut to touch tmp/restart.txt for restarting passenger apps. Complain if wrong directory.
function ttr {
  if [ -x tmp ]; then
    touch tmp/restart.txt
  else
    echo "Wrong directory."
  fi
}

VIM=`which vim`

function vim() {
  IFS=':' read -ra PARAMS <<< "$1"
  if [ -z "${PARAMS[1]}" ]; then
    $VIM "$@"
  else
    $VIM ${PARAMS[0]} -c ${PARAMS[1]}
  fi
}

function sc {
  if [ -e Gemfile ]; then
    export bundle_cmd_prefix="bundle exec"
  else
    export bundle_cmd_prefix=""
  fi
  if [ -x script/console ]; then
    $bundle_cmd_prefix script/console
  else
    sinatra_rb=`egrep -l "^require.+sinatra.$" *.rb 2>/dev/null`
    if [ -e "$sinatra_rb" ]; then
      $bundle_cmd_prefix irb -r $sinatra_rb
    else
      $bundle_cmd_prefix rails console
    fi
  fi
}

function ss {
  if [ -e Gemfile ]; then
    export bundle_cmd_prefix="bundle exec"
  else
    export bundle_cmd_prefix=""
  fi
  if [ -x script/server ]; then
    echo 'script/server' $*
    $bundle_cmd_prefix script/server $*
  else
    sinatra_rb=`egrep -l "^require.+sinatra.$" *.rb 2>/dev/null`
    if [ -e "$sinatra_rb" ]; then
      $bundle_cmd_prefix shotgun $sinatra_rb $*
    else
      $bundle_cmd_prefix rails s $*
    fi
  fi
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Useful ls aliases
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

# some more ls aliases because it's funny when people tell you you spelt "ls" wrong and see it still worked.
alias ks='ls'
alias kls='ls'
alias lks='ls'

alias vi='vim'

# Bundler aliases
alias be='bundle exec'
alias ber='bundle exec rake'
alias bu='bundle update'

# Git aliases
alias gst='git status'
#alias gl='git log --oneline --decorate --color --graph'
# This adds author info to the above:
alias gl='git log --graph --pretty="format:%C(yellow)%h%Cblue%d%Creset %an%C(green): %s %C(white) (%ar%Creset)"'
alias gp='git push'
alias gd='git diff | gedit'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gm='git merge --no-ff'

export GIT_ASKPASS=/usr/local/bin/keyring-get-pass

# This tells you the active git branch you're in
function parse_git_branch {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function rvm_version {
  local gemset=$(echo $GEM_HOME | awk -F'ruby-' '{print $2}')
  [ "$gemset" != "" ] && echo "$gemset"
}

# And this puts it at the end of your prompt.
export EDITOR=$VIM

export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_INIT_SLOTS=800000
export RUBY_GC_HEAP_FREE_SLOTS=600000
#export LD_PRELOAD=/usr/lib64/libtcmalloc_minimal.so.4
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PATH="/usr/local/opt/sqlite/bin:$PATH"

#export LDFLAGS="-L/usr/local/opt/sqlite/lib:$LDFLAGS"
#export CPPFLAGS="-I/usr/local/opt/sqlite/include:$CPPFLAGS"

export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG_PATH"

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

source ~/.dev_profile

export PS1='\[\033[0;32m\]\u@\h:\w\[\033[0;37m\] $(rbenv version-name) $(parse_git_branch)\n\[\033[0;33m\]$\[\033[0;37m\] '

# Set by mco_client_install.sh
export PATH=$PATH:$HOME/code/puppet_projects/puppet/tools:$HOME/bin
source ~/bin/mco_wrapper.sh

# added by travis gem
[ -f /Users/cameron.walsh/.travis/travis.sh ] && source /Users/cameron.walsh/.travis/travis.sh

alias gshs=gssh

export PATH="${HOME}/.sbtenv/bin:${HOME}/.scalaenv/bin:${PATH}"
