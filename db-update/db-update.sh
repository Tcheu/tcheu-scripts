#!/bin/bash

#Import the configuration file
. .db-update.cfg

#Script variables
SOCKET_FILE=.db-update-socket

#Create SSH tunnel to remote host
ssh -M -S $SOCKET_FILE -fnNT -L $REMOTE_DB_LOCAL_PORT:$REMOTE_DB_HOST:$REMOTE_DB_PORT $REMOTE_HOST

#Export remote database into a local file
mysqldump --defaults-file=.creds-remote.cfg -v -h localhost -P $REMOTE_DB_LOCAL_PORT --protocol=tcp $REMOTE_DB_SCHEMA > $DUMP_FILE

#Import database in local DB
mysql --defaults-file=.creds-local.cfg -v -h $LOCAL_DB_HOST -P $LOCAL_DB_PORT --protocol=tcp $LOCAL_DB_SCHEMA < $DUMP_FILE

#Delete dump file as we no longer need it
rm $DUMP_FILE

#Terminate SSH tunnel
ssh -S $SOCKET_FILE -O exit $REMOTE_HOST
