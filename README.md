# shell-snippets
Notes and code snippets to capture handy shell things I've accumulated over the years.

Some of the snippets are presented here in the README, some will be as stand-alone scripts. Unless otherwise noted, these materials relate to the [Bash](https://www.gnu.org/software/bash/) shell. Please note as well that these materials are framed against Bash running under MacOS (at the time of writing Catalina).

Finally, this is not an exhaustive list of weird and wonderful tricks, it's a record of things that I find useful and use all the time - what is interesting to me is that the set of additional things like this I use is becoming less over time, as more tools evolve simpler and more intuitive interfaces.

## Startup Stuff

While the distinction is not particularly clear-cut, in my head I've long thought that any "rc" file contains run time properties or information, and the "profile" files are things that are actually run. [Wikipedia](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) has a good run down on what files are generally automagically used as you login to a Bash shell, or launch
a Bash script.

### .bash_profile

The rough shape of my usual `.bash_profile` is:

```
SSH_ENV=$HOME/.ssh/environment

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
    /usr/bin/ssh-add $HOME/.ssh/github
}

[[ -s ~/.bashrc ]] && source ~/.bashrc

if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    ps ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || start_agent
else
    start_agent
fi
```

Here you see that I have some wiring to start up an [ssh-agent](https://www.ssh.com/ssh/agent) when I open an interactive terminal (note of course that if I have a password on any of the keys I add, I will be prompted for that password). Also note before anything I read the "rc" file

## .bashrc

The RC file has environmental variables I want hanging around as defaults, configures the `PATH`, and adds some aliases:

```
export M2_HOME=$HOME/Applications/apache-maven-3.5.4
export JAVA_HOME=$(/usr/libexec/java_home)
export PYTHON_ROOT=/Library/Frameworks/Python.framework/Versions/3.7

# note that $PATH is set via /usr/libexec/path_helper parsing /etc/paths.d
export PATH=$HOME/Applications/bin:$PYTHON_ROOT/bin:$PATH:/usr/local/bin:/usr/local/sbin:$HOME/Applications/terraform:$JAVA_HOME/bin:$M2_HOME/bin

alias ll="ls -al"
alias listen="/usr/sbin/lsof -P -iTCP -sTCP:LISTEN"
alias add=ssh-add

alias dps="docker ps -a"
alias di="docker images"
alias drm="docker rm \$(docker ps -a -q)"
alias drmi="docker image prune -f"
alias drme="docker rm \$(docker ps -a -q --filter 'exited!=0')"
alias dprune="docker system prune -a -f; docker volume prune -f"

alias myip="echo \$(curl -s https://api.ipify.org)"
```

## Scripts

| Script | Comment |
| ------ | -------- |
| docker-clean.sh | A nuclear option to erase anything and everything running |
| updateAwsCli.sh | updates or installs the [AWS CLI 2.x](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html) package - note this is MacOS specific! |

### update.sh

I use `update.sh` to be able to do bulk operations across a tree of directories containing Git projects.

Note that I have a single script that I put somewhere in my path (in my case `$HOME/Applications/bin`), then symlink to make available as a set of different tools:

```
ln -s update.sh branch.sh
ln -s update.sh remote.sh
ln -s update.sh status.sh
```

| Script | Comment |
| ------ | ------- |
| update.sh | does a `git pull --all` on each directory |
| status.sh | gets the status of each directory |
| remote.sh | lists what remotes are defined for each directory |
| branch.sh | lists what branch each directory currently is |

## License
Copyright 2020 Little Dog Digital

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
