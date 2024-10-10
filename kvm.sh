#!/bin/bash
ktlintvm() {
  if [ -z "$1" ]
  then 
    echo "No ktlint version provided."
    exit 0
  else
    mkdir -p $HOME/.kvm
    mkdir -p $HOME/.kvm/bin
    if [ -d "$HOME/.kvm/$1" ] && [ -f "$HOME/.kvm/$1/ktlint" ]
    then
      echo "ktlint $1 already exists, updated $1 as default version."
    else
      echo "Downloading ktlint $1..."
      curl -sSLOf https://github.com/pinterest/ktlint/releases/download/$1/ktlint
      if [ $? -eq 0 ]
      then
        mkdir -p "$HOME/.kvm/$1"
        mv ktlint $HOME/.kvm/$1/ktlint
      else
        echo "Failed to download ktlint $1."
        exit 0
      fi
    fi
    chmod a+x $HOME/.kvm/$1/ktlint
    cp $HOME/.kvm/$1/ktlint $HOME/.kvm/bin/ktlint
    ktlint --version
  fi
}
export PATH="$HOME/.kvm/bin:$PATH"
alias kvm=ktlintvm
