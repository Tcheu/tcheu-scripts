# db-update.sh

## About the script

This script can be used to automatically export data from a remote DB using mysqldump, then import the dump into a local database.
It will most likely be used to sync a shared CMS database with each local development environment.

## Configuration files

Prior to using the script, you have to configure 3 configuration files:

+ .db-update.cfg => main configuration file
+ .creds-local.cfg => file containing credentials to access the local database
+ .creds-remote.cfg => file containing credentials to access the remote database

### Prerequesites

The remote database should be accessible through an SSH tunnel. The SSH tunnel will be created automatically, as long as the user running the script is authorized on the SSH server through private/public key authentication. 

### .db-update.cfg

Here is a description of each variable and their meaning:

+ DUMP_FILE => Where to store the dump file. It has to be writable by the current user.
+ LOCAL_DB_HOST => IP address or domain name for the local database. Most likely localhost or 127.0.0.1
+ LOCAL_DB_PORT => TCP port of the local database. Most likely 3306.
+ LOCAL_DB_SCHEMA => Name of the local database schema in which the script should import the dump.
+ REMOTE_HOST => IP address or domain name for the SSH server that will be used to create a tunnel to access the remote DB.
+ REMOTE_DB_HOST => IP address or domain name on the remote network for the remote DB.
+ REMOTE_DB_PORT => TCP port of the remote database. Most likely 3306.
+ REMOTE_DB_LOCAL_PORT => TCP port that will be created with the SSH tunnel to access the remote DB. Ideally not 3306.
+ REMOTE_DB_SCHEMA => Name of the remote database schema that should be exported.

### .creds-local.cfg

This configuration file should contain the user name and password to access the local DB.

### .creds-remote.cfg

This configuration file should contain the user name and password to access the remote DB.

## Usage

Simply launch the script from the command line:

	./db-update.sh

No argument is needed as everything is stored in the configuration files.
