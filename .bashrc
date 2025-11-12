# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

random_element() {
    local -n arr=$1
    local len=${#arr[@]}
    local idx=$((RANDOM % len))
    echo "${arr[idx]}"
}
icons_default=("🤖" "😎")
icons_fruit=("🍇" "🍈" "🍉" "🍊" "🍋‍🟩" "🍌" "🍍" "🥭" "🍎" "🍏" "🍐" "🍑" "🍒" "🍓" "🫐" "🫑" "🥝" "🍅" "🫒" "🥥")
icons_emotion=("😀" "😃" "😄" "😁" "😅" "🤣" "🙂" "🙃" "😉" "🫠" "😊" "😇")
icons_red=("🥵" "😡" "🤬" "👹" "👺" "💖" "💋" "👄" "🫦" "💯" "🫀" "🧠" "🫁" "🧑‍🚒" "💃" "🐦" "🦀" "🦞" "🦐" "🐞" "🌸" "🌺" "🍁" "🫖" "🏯" "⛩️" "🏍️" "🛵" "⛽" "🛑" "🧨" "🧧" "🎀" "🎟️")
icons_green=("🤢" "👽" "💚" "🐸" "🐊" "🐢" "🦎" "🐍" "🐲" "🐉" "🦕" "🦖" "🐛" "🪲" "🦗" "🦠" "🌲" "🌳" "🌵" "🌿" "🍀" "🍃" "🍈" "🍋‍🟩" "🍏" "🍐" "🫑" "🫒" "🥒" "🥦" "🥬" "🫛" "🗾" "🗽" "⛺" "🚜" "🎄" "🥎")
icons_blue=("🥶" "💙" "🩵" "💦" "💤" "👨‍🏭" "👮" "🧙" "🕺" "🐳" "🐋" "🐬" "🐟" "🐠" "🪼" "🪰" "🥣" "🫗" "🧊" "🌐" "🌍" "🌎" "🌏" "🗺️" "🏬" "🏙️" "🚄" "🚙" "🛴" "🛢️" "⚓" "⛴️" "💺" "🧳" "🌬️" "💧" "🌊" "🥏" "🧶" "🪢")
icons_purple=("😈" "👿" "👾" "💜" "🧕" "🗣️" "👤" "👥" "🫂" "👣" "🐈‍⬛" "🕷️" "🫐" "🍆" "🌆" "🛹" "🌑" "🌚" "⛈️" "🌀" "🌂" "☔" "🎆" "🪀" "🎮")
icons_white=("🤖" "👻" "💀" "🤍" "💨" "💬" "🦾" "🦿" "👀" "🦷" "🦴" "👁️" "🐩" "🐺" "🦝" "🫏" "🦓" "🐄" "🐏" "🐑" "🦙" "🐘" "🐻‍❄️" "🐨" "🐼" "🐔" "🐧" "🕊️" "🦆" "🦢" "🦤" "🪽" "🦭" "🦈" "🐚" "🍶" "🍽️" "🍴" "🥄" "🏛️" "🪨" "🌁" "🕛" "🌨️" "🌪️" "🌫️" "🏐" "🥋" "🪩")
icons_brown=("💩" "🙈" "🙉" "🙊" "🤎" "🐵" "🐒" "🐴" "🫎" "🐎" "🦬" "🐂" "🦣" "🦫" "🦔" "🦇" "🐻" "🐓" "🦅" "🪿" "🪳" "🦂" "🦟" "🫘" "🌰" "🍩" "🏺" "🪵" "🛖" "🏈" "🦉" "🪶" "🐌")

if [ ! -v "$TERMINAL_ICON" ]; then
	# TERMINAL_ICON=${icons_default[0]}
    TERMINAL_ICON=$(random_element icons_blue)
fi

docker_container=''
if [ -e "/.dockerenv" ]; then
    docker_container="🐳" # 🐳🐋
fi

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\e[96m\e[2m[\D{%Y/%m/%d %H:%M:%S}]\e[0m $TERMINAL_ICON$docker_container \e[96m\u@\h \e[94m\w\n\[\e[94m\e[6m\]>> \[\e[0m\[\033[00m\]'
    # PS1='$(random_element icons_emotion) \[\e[96m\]\u:\[\e[96m\]\w\[\e[94m\]\$\[\e[0m\] '
    # PS1='$TERMINAL_ICON \[\e[96m\]\u:\[\e[96m\]\w\[\e[94m\]\$\[\e[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -AlhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

ros_source () {
	if [ -e "$1" ]; then
		source $1
	fi
}
. "$HOME/.local/bin/env"
ros_source /opt/ros/humble/setup.bash
ros_source /opt/ros/melodic/setup.bash
ros_source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
ros_source /usr/share/bash-completion/completions/git

if [ -v $TMUX ] && [ -z "$TERM_PROGRAM"  ]; then
	cd && tmux
fi
