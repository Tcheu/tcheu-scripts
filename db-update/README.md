# db-update.sh

## About the script

This script can be used to automatically export data from a remote DB using mysqldump, then import the dump into a local database.
It will most likely be used to sync a shared CMS database with each local development environment.

## Configuration file

Prior to using the script, you have to rename `.db-update.sample.cfg` to `.db-update.cfg` and edit the options according to your needs.

### Prerequesites

The remote database should be accessible through an SSH tunnel. The SSH tunnel will be created automatically, as long as the user running the script is authorized on the SSH server through private/public key authentication. 

### .db-update.cfg

Here is a description of each variable and their meaning:

+ `DUMP_FILE` => Where to store the dump file. It has to be writable by the current user.
+ `LOCAL_DB_HOST` => IP address or domain name for the local database. Most likely localhost or 127.0.0.1
+ `LOCAL_DB_PORT` => TCP port of the local database. Most likely 3306.
+ `LOCAL_DB_SCHEMA` => Name of the local database schema in which the script should import the dump.
+ `LOCAL_DB_USER` => Name of the local database user.
+ `LOCAL_DB_PASSWORD` => Password for the local database user.
+ `REMOTE_HOST` => IP address or domain name for the SSH server that will be used to create a tunnel to access the remote DB.
+ `REMOTE_DB_HOST` => IP address or domain name on the remote network for the remote DB.
+ `REMOTE_DB_PORT` => TCP port of the remote database. Most likely 3306.
+ `REMOTE_DB_LOCAL_PORT` => TCP port that will be created with the SSH tunnel to access the remote DB. Ideally not 3306.
+ `REMOTE_DB_SCHEMA` => Name of the remote database schema that should be exported.
+ `REMOTE_DB_USER` => Name of the remote database user.
+ `REMOTE_DB_PASSWORD` => Password for the remote database user.

## Usage

Simply launch the script from the command line:

	./db-update.sh

No argument is needed as everything is stored in the configuration files.
