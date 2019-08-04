#!/usr/bin/env bash

if test -f ./.env; then

    source ./.env
    
    GREEN=$(tput setaf 2)
    RED=$(tput setaf 1)
    NORMAL=$(tput sgr0)
    
    USER_NAME=$(eval getent passwd $USER_ID | cut -d: -f1)
    GROUP_NAME=$(eval getent group $GROUP_ID | cut -d: -f1)

    if [ $USER_ID != "" ]; then
        if [ $GROUP_ID != "" ]; then
            if test -d "$MOODLE_FOLDER"; then
                if test -d "$MOODLEDATA_FOLDER"; then
                    echo '>    start assigning permissions'
                    
                    chown -R $USER_ID:$GROUP_ID $MOODLE_FOLDER
                    chmod 0755 $MOODLE_FOLDER
                    find $MOODLE_FOLDER -type d -exec chmod 0755 {} \;
                    find $MOODLE_FOLDER -type f -exec chmod 0644 {} \;
                    echo ">    moodle user:"$USER_NAME" group:"$GROUP_NAME
                    echo '>    moodle folders: 755'
                    echo '>    moodle folders: 644'
                    
                    
                    chown -R $USER_ID:$GROUP_ID $MOODLEDATA_FOLDER
                    chmod 0700 $MOODLEDATA_FOLDER
                    find $MOODLEDATA_FOLDER -type d -exec chmod 0700 {} \;
                    find $MOODLEDATA_FOLDER -type f -exec chmod 0600 {} \;
                    echo ">    moodledata user:"$USER_NAME" group:"$GROUP_NAME
                    echo '>    moodledata folders: 700'
                    echo '>    moodledata folders: 600'

                    echo ${GREEN}">    assigned moodle permissions"${NORMAL}
                else
                    echo ${RED}">    ERROR: the folder "$MOODLEDATA_FOLDER" not found."${NORMAL}
                fi
            else
                echo ${RED}">    ERROR: the folder "$MOODLE_FOLDER" not found."${NORMAL}
            fi
        else
            echo ${RED}">    ERROR: the GROUP_ID is not assigned, check your .env file"${NORMAL}
        fi
    else
        echo ${RED}">    ERROR: the USER_ID is not assigned, check your .env file"${NORMAL}
    fi
else
    echo ${RED}">    ERROR: the .env file not found."${NORMAL}
fi
