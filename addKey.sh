#!/bin/bash

if [ ! -d "$1/.ssh" ]; then
   mkdir -p "$1/.ssh"
   chown $2 "$1/.ssh"
fi

if [ ! -f $1/.ssh/config ]; then
  if [ -z $4 ]; then
     echo -e "Host *\n    IdentityFile $3\n    StrictHostKeyChecking no" > $1/.ssh/config
  else
     echo -e "Host $4\n    IdentityFile $3\n    StrictHostKeyChecking no" > $1/.ssh/config
  fi
  chown $2 $1/.ssh/config
  chmod 0600 $1/.ssh/config
  echo "$1/.ssh/config created"
else
  # insert the text at line 1
  sed -i -e "1i \ \ \ \ IdentityFile $3\n    StrictHostKeyChecking no" $1/.ssh/config
  if [ -z $4 ]; then
    sed -i -e "1i Host *" $1/.ssh/config
  else
    sed -i -e "1i Host $4" $1/.ssh/config
  fi
  echo "$1/.ssh/config updated"
fi
