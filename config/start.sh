#!/usr/bin/env bash

ls -l /home/

source ./.env

usermod -u ${USER_ID} apache
groupmod -g ${GROUP_ID} apache

MOODLE_CONFIG=/var/www/html/moodle/config.php

if test -f "$MOODLE_CONFIG"; then

    sed -i "/wwwroot/c\$CFG->wwwroot   = '${MOODLE_URL}';"      $MOODLE_CONFIG
    sed -i "/dbhost/c\$CFG->dbhost    = '${DATABASE_URL}';"     $MOODLE_CONFIG
    sed -i "/dbport/c\  'dbport' => '${DATABASE_PORT}',"        $MOODLE_CONFIG
    sed -i "/dbtype/c\$CFG->dbtype    = '${DATABASE_TYPE}';"    $MOODLE_CONFIG
    sed -i "/dbname/c\$CFG->dbname    = '${DATABASE_NAME}';"    $MOODLE_CONFIG
    sed -i "/dbuser/c\$CFG->dbuser    = '${DATABASE_USER}';"    $MOODLE_CONFIG
    sed -i "/dbpass/c\$CFG->dbpass    = '${DATABASE_PASS}';"    $MOODLE_CONFIG
fi

echo ">    successful deployment"
echo ">    moodle run in ${MOODLE_NETWORK}:${MOODLE_PORT}"

/usr/sbin/apachectl -DFOREGROUND
