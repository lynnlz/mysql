#!/bin/bash
#
# File fill_table_space.sh
#
# Author: huxing1985@gmail.com
# Modify: wlzjsj@gmail.com
# 注意：这个脚本具有一定的误导性，可不使用。
# NOTE：This script has some misleading, completely without using
# If you any question,you can connect me by WeChat:Arthur434864,And please note the reason
# blog: www.colorfuldays.org
#
# Purpose: This script is a part of a tool recover mysql data from .frm and .idb file.
# This script is use to fill the table spaces.
#

if [[ $# -lt 2 ]]; then
    echo "Usage: fill_table_space.sh <num_of_space_ids> <dbuser> <dbpasswd>"
    exit;
fi

user=$2
passwd=$3
for i in `seq 1 $1`; 
do 
	mysql -u$user -p$passwd -S /tmp/mysql.sock  -e "use test;CREATE TABLE filltmp$i (id bigint(20) NOT NULL AUTO_INCREMENT,PRIMARY KEY (id)) ENGINE=innodb "; 
done
