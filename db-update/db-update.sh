#!/bin/bash

#Import the configuration file
echo "Import configuration"
source ./.db-update.cfg
echo "Local schema: $LOCAL_DB_SCHEMA"
echo "Remote schema: $REMOTE_DB_SCHEMA"

#Script variables
SOCKET_FILE=.db-update-socket

#Create SSH tunnel to remote host
echo "Create SSH tunnel to access remote DB"
ssh -M -S $SOCKET_FILE -fnNT -L $REMOTE_DB_LOCAL_PORT:$REMOTE_DB_HOST:$REMOTE_DB_PORT $REMOTE_HOST

#Create config file for access to remote DB
echo "Generate config file for remote DB"
echo "[mysqldump]" >> ./.creds-remote.cfg
echo "user=$REMOTE_DB_USER" >> ./.creds-remote.cfg
echo "password=$REMOTE_DB_PASSWORD" >> ./.creds-remote.cfg

#Export remote database into a local file
echo "Exporting remote DB"
mysqldump --defaults-file=.creds-remote.cfg  --skip-lock-tables -h localhost -P $REMOTE_DB_LOCAL_PORT --protocol=tcp $REMOTE_DB_SCHEMA --result-file=$DUMP_FILE

#Remove remote db config file
rm ./.creds-remote.cfg

#Create config file for access to local DB
echo "Generate config file for local DB"
echo "[mysql]" >> ./.creds-local.cfg
echo "user=$LOCAL_DB_USER" >> ./.creds-local.cfg
echo "password=$LOCAL_DB_PASSWORD" >> ./.creds-local.cfg

#Import database in local DB
echo "Importing DB into local server"
mysql --defaults-file=.creds-local.cfg -h $LOCAL_DB_HOST -P $LOCAL_DB_PORT --protocol=tcp $LOCAL_DB_SCHEMA < $DUMP_FILE

# Remove local db config file
rm ./.creds-local.cfg

#Delete dump file as we no longer need it
echo "Removing DB dump file"
rm $DUMP_FILE

#Terminate SSH tunnel
echo "Closing SSH tunnel"
ssh -S $SOCKET_FILE -O exit $REMOTE_HOST
