#!/bin/bash
#
# File: create_init_sql.sh
#
# modify: wlzjsj@gmail.com
# 
# NOTE: You may need to modify part of the code to suit your environment
# Purpose: This script is a part of an tool to recover mysql data from .frm and .idb file.
# This script is read the db data dir's file, generate an script to create the tables.
## If you any question,you can connect me by WeChat:Arthur434864,And please note the reason
usage()
{
    echo "Usage: $0 <datafiledir> <user> <passwd> <dbname>"
    echo "<dir> is the frm directory."
    echo "<user> is the database's user."
    echo "<passwd> is the database's passwd."
    echo "<dbname> is the datafile's database name."
    echo "output files:"
    echo "create_tmp_table.sql: use to init create tables,use to recover table schema from .frm file"
    echo "discard_tablespace.sh: use to discard tablespace when recover data file."
    echo "import_tablespace.sh: use to discard tablespace when recover data file."
}

if [[ $# -lt 3   ]]; then
    usage $0;
    exit;
fi

dir=$1
user=$2
passwd=$3
dbname=$4

for i in `find $dir -name "*.frm"`
do
    tablename=`echo $i | awk -F "/" '{print $NF}' | awk -F "." '{print $1}'`
    if [[ "x$tablename" != "x" ]]; then
 	echo 'mysql -u'$user' -p'$passwd' -S /tmp/mysql_3307.sock -s -e "use '$dbname'; ALTER TABLE '$tablename' discard tablespace;"' >> discard_tablespace.sh
	echo 'mysql -u'$user' -p'$passwd' -S /tmp/mysql_3307.sock -s -e "use '$dbname'; ALTER TABLE '$tablename' import tablespace;"' >> import_tablespace.sh       
	echo "CREATE TABLE $tablename(id int(11) NOT NULL) ENGINE=InnoDB;" >> create_tmp_table.sql
    fi
done

case "$1" in
    -h)
       usage ;;
esac
