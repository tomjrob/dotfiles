### OPENSTACK ###
if [ -f ~/.BeatsonMicrobialGenomics-openrc.sh ]; then
  . ~/.BeatsonMicrobialGenomics-openrc.sh
fi

### PACKER ###
if [ -d /Volumes/MODHUB_TEST/ ]; then
  mkdir -p /Volumes/MODHUB_TEST/packer_cache
  export PACKER_CACHE_DIR=/Volumes/MODHUB_TEST/packer_cache
fi

### GOPATH ###
export GOPATH=$HOME/Source/Go
export PATH="$PATH:$GOPATH/bin"

### HOMEBREW ###
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# Add homebrew bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

### RUBY ###
if [ -f ~/.bundler-exec.sh ]; then
  source ~/.bundler-exec.sh
fi

### PYTHON ###
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
# Load virtualenv
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
  export WORKON_HOME=~/.virtualenvs
  export PIP_REQUIRE_VIRTUALENV=true
  . /usr/local/bin/virtualenvwrapper.sh
  gpip(){ PIP_REQUIRE_VIRTUALENV="" pip "$@"; }
else
  echo "WARNING: Can't find virtualenvwrapper.sh"
fi
#Load autoenv
if [ -f /usr/local/opt/autoenv/activate.sh ]; then
  . /usr/local/opt/autoenv/activate.sh
else
  echo "WARNING: Can't find autoenv/activate.sh"
fi

### DOTFILES - Where the magic happens ###
export DOTFILES=~/.dotfiles
# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH
# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    . "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      . "$file"
    done
  fi
}
# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}
src
