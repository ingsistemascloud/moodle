#!/usr/bin/env bash

USER_ID=$(id -u)
GROUP_ID=$(id -g)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
NORMAL=$(tput sgr0)

if [[ $USER_ID = 0 ]]; then
    echo ${RED}">    WARNING: you should not use sudo."${NORMAL}
    echo ${RED}">    user id  :"$USER_ID${NORMAL}
    echo ${RED}">    group id :"$GROUP_ID${NORMAL}
else
    echo ${GREEN}">    user id  :"$USER_ID${NORMAL}
    echo ${GREEN}">    group id :"$GROUP_ID${NORMAL}
fi
