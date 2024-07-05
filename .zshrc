# alectrocute's .zshrc dotfile

# oh my zsh-related
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# deno-related
export DENO_INSTALL="/Users/alec/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# nvm-related
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pyenv-related
eval "$(pyenv init --path)"

### git/gpg-related
# https://esc.sh/blog/gpg-error-inappopriate-ioctl-for-device/
export GPG_TTY=$(tty);
git config --global gpg.program gpg;
ssh-add ~/.ssh/github &> /dev/null;

# mongodb-related
mongo_up() {
  mongod --config /opt/homebrew/etc/mongod.conf;
}

# misc. shortcuts and utils
# that make my life easier
c_ports() {
  if [ $# -eq 0 ]; then
    sudo lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
  else
    echo "Usage: listening [pattern]"
  fi
}

c_portkill() {
  c_ports $1 | awk '{print $2}' | xargs sudo kill -9; 
}

vidc() {
  ffmpeg -i "$@" /Users/alec/Desktop/converted.mp4;
}

flushdns() {
  sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder;
}

checkcodesigning() {
  codesign -dv --verbose=4 $1;
}

checknotarization() {
  spctl -a -vvv -t install $1;
}

getshorttermawscreds() {
  aws sts get-session-token \
    --duration-seconds 900
}
