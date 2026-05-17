# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm)
    PS1='\n\[\033]0;\w\007\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[31m \033[0m\] \n$ '
    ;;
xterm-color)
    PS1='\n\[\033]0;\w\007\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[31m \033[0m\] \n$ '
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'


# mc
# If running interactively, then:
function title() {
  arg=${1}
  if [ -z $arg ]
  then
    arg=$HOSTNAME
  fi
  if [ "-" == $arg ]
  then
    arg=`basename $PWD`
    arg2=${2}
    if [ ! -z $arg2 ]
    then
      arg="$arg - $arg2"
    fi
  fi
  echo -ne "\033]0;${arg}\007"
}

function gvimr() {  
  arg=${1}
  if [ -n ${2} ]
  then
	  server="--servername ${2}"
  fi
  dir=`dirname ${arg}`
  base=`basename ${arg}`
  old_dir=$PWD
  gvim $server --remote-send ":split ${PWD}/${arg}" 2> /dev/null || gvim ${arg}
}

function grs() {
  grep -r $@ *
}
function gmr() {  
  mozilla-new-tab "file:///$PWD/$1"
}

function grsvlog() {
  grep -r $@ * | grep -v log
}

function grsvlogvvendor() {
  grep -r $@ * | grep -v log | grep -v ^vendor
}

function Colorize() {
    sed -e "s/^\(.*\)$/[0;$1;$2m\1[0m/"
}

function InstallSshKey() {
    cat ~/.ssh/id_dsa.pub | ssh -l ${1} ${2} "cat >> ~/.ssh/authorized_keys2"
}

function PushMvn() {
  pushd $1
  mvn $MAVEN_OFFLINE -Dmaven.test.skip=true $2 $3 $4 $5 $6 $7 $8 $9
  popd
}

function PushInstall() {
  for a in $@
  do
    PushMvn $a install
  done
}

function MavenOffline() {
  export MAVEN_OFFLINE="-o"
}

function MavenOnline() {
  export MAVEN_OFFLINE=""
}

function MavenDebug() {
  export MAVEN_OPTS="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=4000,server=y,suspend=n"
}

function MavenDontDebug() {
  export MAVEN_OPTS=""
}


function Rake() {
  rake $@
  notify-send "Rake Complete"
}


if [ "$SSH_AGENT_PID" ]; then
  if [ ! "$SSH_SESSION_SET" ]; then
      ssh-add
    export SSH_SESSION_SET="true"
  fi
fi
if [ "$PS1" ]; then

    # enable color support of ls and also add handy aliases

    #eval `dircolors`
    alias ls='ls --color=auto '
    alias g='grep'
    #alias ll='ls -l'
    #alias la='ls -A'
    #alias l='ls -CF'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    # set a fancy prompt

    #PS1='\[\033]0;\w\007 \033[32m\]\u@\h \[\033[33m\w\033[0m\] $ '
    #PS1='\n\[\033]0;\w\007\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[31m`P4Client` \033[0m\] \n$ '
PS1='\n\[\033]0;\w\007\033[32m\]\u@\h \[\033[33m\w\033[0m\] \[\033[31m \033[0m\] \n$ '
    #PS1='\u@\h:\w\$ '
#PS1='[\w]$ '
fi
if [ "x$TERM" = "xdumb" ]
then
  export TERM=xterm
fi
export EDITOR="vi"
#export VISUAL="gvim"
export VI="gvim"

#export MAVEN_HOME="/media/shared/java/apache-maven-2.0.9"
export MAVEN_HOME="/home/micah/opt/apache-maven-3.1.0"
#export JAVA_HOME="/usr/lib/jvm/java-1.5.0-sun"
#export JAVA_HOME="/usr/lib/jvm/java-6-sun"
export JBOSS_HOME="/media/shared/server/jboss/jboss-4.0.5"
export JBOSS_SERVER="mslo"
#export GRAILS_HOME="/usr/share/grails"
export GRAILS_HOME="/home/micah/grails/grails"


#alias vi="$VI"
alias sb="source ~/.bashrc"
alias vb="$VI ~/.bashrc"
alias vv="$VI ~/.vimrc"
alias vms="$VI ~/.m2/settings.xml"
alias fn="find . -name"
alias psag="ps auxww | grep"
alias scpresume="rsync --partial --progress --rsh=ssh"

export MavenRepo="~/.m2"
alias cdMaven='cd $MavenRepo'

alias SshAgent='ssh-agent bash'

alias dc="cd"
alias gcim="gvim"
alias cd..="cd .."
alias kilall="killall"
alias grepv="grep -v"

alias ColorizeRedOnBlack="Colorize 31 40"
alias ColorizeGreenOnBlack="Colorize 32 40"
alias ColorizeYellowOnBlack="Colorize 33 40"
alias ColorizeBlueOnBlack="Colorize 34 40"
alias ColorizeMagentaOnBlack="Colorize 35 40"
alias ColorizeCyanOnBlack="Colorize 36 40"

alias ColorizeBlackOnRed="Colorize 30 41"
alias ColorizeBlackOnGreen="Colorize 30 42"
alias ColorizeBlackOnYellow="Colorize 30 43"
alias ColorizeBlackOnBlue="Colorize 30 44"
alias ColorizeBlackOnMagenta="Colorize 30 45"
alias ColorizeBlackOnCyan="Colorize 30 46"

alias Mvn="mvn -Dmaven.test.skip=true"
alias MVn="mvn -Dmaven.test.failure.ignore=true"
alias MVN="MAVEN_OPTS='-Xms128m -Xmx512m -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=4000,server=y,suspend=n' mvn -Dmaven.test.skip=true"

alias GitStashPullAndPop="git stash && git pull && git stash pop"
alias GitPullAndPush="git pull && git push"

alias KillFlash='pkill -f "chromium-browser.*libflashplayer.so"'

#alias StartJboss="'$JBOSS_HOME'/bin/run.sh"
#alias StopJboss="'$JBOSS_HOME'/bin/shutdown.sh -S"
#alias cdJbossHome="cd '$JBOSS_HOME'"

#export jbossMsloServer="$JBOSS_HOME/server/mslo"
#alias cdJbossHomeMsloServer="cd '$jbossMsloServer'"
#export jbossMsloServerDeploy="$jbossMsloServer/deploy"
#alias RestartCrowdWorksMslo="pushd $jbossMsloServerDeploy && touch crowdworks-exp.ear/META-INF/application.xml msloLayout-1.0-SNAPSHOT.war/WEB-INF/web.xml msloportal-1.0-SNAPSHOT.war/WEB-INF/web.xml && popd"

#export CwSvnHost="cvsgroovy.commote.com"
#export CwSvnRoot="https://$CwSvnHost/repos"

#alias SshCore1="ssh -l mcraig core1"
#alias SshIntegrate="ssh -l mcraig -p 2223 integrate.crowdfactory.com"
#alias SshIntegrate="ssh -l mcraig integrate.crowdfactory.com"
#alias SshDev="ssh -l mcraig -p 2222 dev.crowdfactory.com"

#alias SshSW="ssh -l socialwo host3.socialworkout.com"
#alias SshSowo="ssh -l socialwo sowo.socialworkout.com"
#alias SshQa="ssh -l qa qa.socialworkout.com"
#alias SshZeus="ssh -p2222 zeus"

## IntelliJ ##
export IntelliJHome="~/IDEA/idea-IU-123.155"
alias cdIntelliJHome="cd $IntelliJHome"
alias IntelliJ="$IntelliJHome/bin/idea.sh"

#export View="/media/shared/view"
export View="~/view"
alias cdView="cd $View"
alias pushdView="pushd $View"

## SecureZone ##
export SecureZone="$View/securezone/trunk"
alias cdSecureZone="cd $SecureZone"
alias pushdSecureZone="pushd $SecureZone"

## 20x200 ##
export MONGODB_HOST="localhost"
export TwentyXTwohundred="$View/20x200"
alias cdTwentyXTwohundred="cd $TwentyXTwohundred"
alias pushdTwentyXTwohundred="pushd $TwentyXTwohundred"

alias JBP_SshHaProxy1='ssh -i ~/.ssh/biz_rsa root@184.73.246.251'
alias JBP_SshHaProxy2='ssh -i ~/.ssh/biz_rsa root@184.73.248.71'
alias JBP_SshStaging='ssh -i ~/.ssh/biz_rsa root@staging.20x200.com'
function JBP_ScpToStaging() {
  scp -i ~/.ssh/biz_rsa "$1" root@staging.20x200.com:"$2"
}
function JBP_ScpFromStaging() {
  scp -i ~/.ssh/biz_rsa root@staging.20x200.com:"$1" "$2"
}
function JBP_SshProd() {
  ssh -i ~/.ssh/biz_rsa "root@$1"
}
alias JBP_SshBiz='ssh -i ~/.ssh/biz_rsa root@biz.20x200.com'
function JBP_ScpMysqlDumpFromBiz() {
  scp -i ~/.ssh/biz_rsa root@biz.20x200.com:/var/www/vhosts/backups/mysql/jbp_mysql_dump.tgz ./jbp_mysql_dump.`date "+%Y%m%d"`.tgz
}
function JBP_ScpToBiz() {
  scp -i ~/.ssh/biz_rsa "$1" root@biz.20x200.com:"$2"
}
function JBP_ScpFromBiz() {
  scp -i ~/.ssh/biz_rsa root@biz.20x200.com:"$1" "$2"
}
alias JBP_SshRMHaproxy1Staging='ssh rails@haproxy1.staging.20x200.managedmachine.com'

## DOM & TOM ##
export DomAndTom="$View/domandtom"
alias cdDomAndTom="cd $DomAndTom"
alias pushdDomAndTom="pushd $DomAndTom"
export YPN="$DomAndTom/ypn"
alias cdYPN="cd $YPN"
alias pushdYPN="pushd $YPN"
export Zola="$DomAndTom/zola"
alias cdZola="cd $Zola"
alias pushdYPN="pushd $Zola"
#alias Zola_SshStaging="ssh -i ~/.ssh/Zola-Staging-Micro.pem ubuntu@ec2-23-22-158-221.compute-1.amazonaws.com"
alias Zola_SshStaging="ssh -i ~/.ssh/Zola-Staging-Micro.pem ubuntu@zolastaging.com"
#alias Zola_SshBea="ssh -i ~/.ssh/Zola-BEA.id_dt ec2-user@ec2-50-17-161-238.compute-1.amazonaws.com"
#alias Zola_SshBea="ssh -i ~/.ssh/Zola-BEA.id_dt ec2-user@ec2api.zolabooks.com"
alias Zola_SshBea="ssh -i ~/.ssh/Zola-BEA.id_dt ec2-user@bea.zola"
function BBN_HerokuStage() {
  heroku $@ --app ypn
}
function BBN_HerokuProd() {
  heroku $@ --app buildersbidnetwork
}

## SOCIALISTING ##
export Socialisting="$View/socialisting"
alias cdSocialisting="cd $Socialisting"
alias pushdSocialisting="pushd $Socialisting"
alias SL_SshDev="ssh -l socialisting.com s100034.gridserver.com"

## LOCATIONSTAR ##
export LocationStar="$View/locationstar"
alias cdLocationStar="cd $LocationStar"
alias pushdLocationStar="pushd $LocationStar"


## STRINGER ##
export Stringer="$View/stringer"
alias cdStringer="cd $Stringer"
alias pushdStringer="pushd $Stringer"
export STRINGER_DATABASE="stringer_live"
export STRINGER_DATABASE_USERNAME="stringer"
export STRINGER_DATABASE_PASSWORD="stringer"
export RACK_ENV="production"

## mc.net ##
alias MC_Ssh="ssh -l micahc micahcraig.net"


## media ##
alias Media_Ssh="ssh -l root media"



alias TailSMTranscodeLog="ssh sm-stage 'sudo tail -f /home/shapemix/rails/shapemix/transcode.out' | ColorizeBlueOnBlack"

#export ANDROID_SDK="/media/shared/java/android-sdk-linux_x86-1.0_r2"
export ANDROID_SDK="/home/micah/opt/android-sdk-linux"

#export PATH="`cygpath $PERL_HOME`/bin:/c/Vim/vim70:/usr/bin:$PATH:/sbin:~/bin:`cygpath $MAVEN_HOME`/bin:`cygpath $ANT_HOME`/bin:`cygpath.exe -u \"$JAVA_HOME/bin\"`"
export PATH="$PATH:$MAVEN_HOME/bin:$JAVA_HOME/bin:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$GRAILS_HOME/bin:~/bin"

# /mc

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
