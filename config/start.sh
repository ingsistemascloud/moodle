#!/usr/bin/env bash

source ./.env

usermod -u ${USER_ID} apache
groupmod -g ${GROUP_ID} apache

MOODLE_CONFIG=/var/www/html/moodle/config.php
PHP_INI=/etc/php.ini

if test -f "$MOODLE_CONFIG"; then

    sed -i "/wwwroot/c\$CFG->wwwroot   = '${MOODLE_URL}';"      $MOODLE_CONFIG
    sed -i "/dbhost/c\$CFG->dbhost    = '${DATABASE_URL}';"     $MOODLE_CONFIG
    sed -i "/dbport/c\  'dbport' => '${DATABASE_PORT}',"        $MOODLE_CONFIG
    sed -i "/dbtype/c\$CFG->dbtype    = '${DATABASE_TYPE}';"    $MOODLE_CONFIG
    sed -i "/dbname/c\$CFG->dbname    = '${DATABASE_NAME}';"    $MOODLE_CONFIG
    sed -i "/dbuser/c\$CFG->dbuser    = '${DATABASE_USER}';"    $MOODLE_CONFIG
    sed -i "/dbpass/c\$CFG->dbpass    = '${DATABASE_PASS}';"    $MOODLE_CONFIG
    
fi

sed -i "/post_max_size/c\post_max_size = ${MOODLE_MAX_UPLOAD_SIZE}" $PHP_INI
sed -i "/upload_max_filesize/c\upload_max_filesize = ${MOODLE_MAX_UPLOAD_SIZE}" $PHP_INI
sed -i "/max_execution_time/c\max_execution_time = 600" $PHP_INI
sed -i "/max_input_vars/c\max_input_vars = 5000" $PHP_INI
sed -i "/display_errors/c\display_errors = On" $PHP_INI
sed -i "/display_startup_errors/c\display_startup_errors = On" $PHP_INI
sed -i "/;error_log = php_errors.log/c\error_log = \"/var/log/httpd/php.log\"" $PHP_INI

echo ">    successful deployment"
echo ">    moodle run in ${MOODLE_NETWORK}:${MOODLE_PORT}"

/usr/sbin/apachectl -DFOREGROUND
