#!/bin/bash

#Import the configuration file
echo "Import configuration"
source ./.db-update.cfg
echo "Local schema: $LOCAL_DB_SCHEMA"
echo "Remote schema: $REMOTE_DB_SCHEMA"

#Create config file for access to remote DB
echo "Generate config file for remote DB"
echo "[mysqldump]
user=$REMOTE_DB_USER
password=$REMOTE_DB_PASSWORD" | ssh $REMOTE_USER@$REMOTE_HOST  "cat > ./.creds-remote.cfg"

#Build the arguments to exclude ignored tables
#Script found here: http://stackoverflow.com/a/425172/1441729
IGNORED_TABLES_STRING=''
for TABLE in "${EXCLUDED_TABLES[@]}"
do :
   IGNORED_TABLES_STRING+=" --ignore-table=${REMOTE_DB_SCHEMA}.${TABLE}"
done

#Export remote database into a local file
echo "Exporting remote DB"
ssh $REMOTE_USER@$REMOTE_HOST "mysqldump --defaults-file=.creds-remote.cfg --skip-lock-tables -h $REMOTE_DB_HOST -P $REMOTE_DB_PORT --protocol=tcp  $IGNORED_TABLES_STRING $REMOTE_DB_SCHEMA" > $DUMP_FILE

#Remove remote db config file
ssh $REMOTE_USER@$REMOTE_HOST  "rm ./.creds-remote.cfg"

#Create config file for access to local DB
echo "Generate config file for local DB"
echo "[mysql]
user=$LOCAL_DB_USER
password=$LOCAL_DB_PASSWORD" > ./.creds-local.cfg

#Import database in local DB
echo "Importing DB into local server"
mysql --defaults-file=.creds-local.cfg --host=$LOCAL_DB_HOST --port=$LOCAL_DB_PORT --protocol=tcp $LOCAL_DB_SCHEMA < $DUMP_FILE

# Remove local db config file
rm ./.creds-local.cfg

#Delete dump file as we no longer need it
echo "Removing DB dump file"
rm $DUMP_FILE