source $HOME/.bash/git-completion.bash
source $HOME/.bash/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

PS1='\e[36m\]\u \e[33m\][\w]\e[35m\]$(__git_ps1) \e[36m\]\$ \e[0m\]'

HISTTIMEFORMAT='%F %T '
HISTSIZE=1000
HISTFILESIZE=2000

case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

complete -C '/usr/local/bin/aws_completer' aws

export TF_LOG=TRACE
export TF_LOG_PATH='./terraform.log'

alias ls='ls -lhAF'
