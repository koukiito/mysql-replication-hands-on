echo "Starting the MySQL slave initialization script..."

# Execute the command to set up the slave
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='$MASTER_HOST', SOURCE_PORT=$MASTER_PORT, SOURCE_USER='$REPLICA_USER', SOURCE_PASSWORD='$REPLICA_PASSWORD', GET_MASTER_PUBLIC_KEY=1;"
if [ $? -ne 0 ]; then
    echo "Error: Unable to set up the slave server."
    exit 1
fi
echo "Successfully set up the slave server."

# Dump the master database
mysqldump -u $MASTER_USER -h $MASTER_HOST -P $MASTER_PORT -p$MASTER_PASSWORD --all-databases --single-transaction --routines --triggers --events --master-data=1 > /tmp/master_dump.sql
if [ $? -ne 0 ]; then
    echo "Error: Unable to dump the master database."
    exit 1
fi
echo "Successfully dumped the master database."

# Import the dump into the slave
mysql -u root -p$MYSQL_ROOT_PASSWORD < /tmp/master_dump.sql
if [ $? -ne 0 ]; then
    echo "Error: Unable to import the dump into the slave."
    exit 1
fi
echo "Successfully imported the dump into the slave."
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "START SLAVE;"
if [ $? -ne 0 ]; then
    echo "Error: Unable to start the slave."
    exit 1
fi
echo "Successfully started the slave server."