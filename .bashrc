export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# Shortcut to touch tmp/restart.txt for restarting passenger apps. Complain if wrong directory.
function ttr {
  if [ -x tmp ]; then
    touch tmp/restart.txt
  else
    echo "Wrong directory."
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
      $bundle_cmd_prefix shotgun $sinatra_rb
    else
      $bundle_cmd_prefix rails s
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

# Everyone needs X, servers are meant to run gui apps, right?
alias ssh='ssh -X'

alias vi='/usr/bin/vim'

# grep-fu gem aliases - for searching ruby projects - gem install grep-fu first
alias g='grep-fu'
alias ga='grep-fu a'

# Bundler aliases
alias be='bundle exec'
alias ber='bundle exec rake'
alias bu='bundle update'

# Git aliases
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | gedit'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gm='git merge --no-ff'

# This tells you the active git branch you're in
function parse_git_branch {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function rvm_version {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && echo "@$gemset"
}

# And this puts it at the end of your prompt.
export PS1="\[\033[0;32m\]\u@\h:\w\[\033[0;37m\] $(rvm_version) $(parse_git_branch)\n\[\033[0;33m\]⚡\[\033[0;37m\] "