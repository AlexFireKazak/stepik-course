#!/bin/bash

mv /home/box/stepik-course/web /home/box/

WORK_DIR="/home/box"
PROJ_DIR="$WORK_DIR/web"
DJ_PROJ_DIR="$PROJ_DIR/ask"
DJ_APP_NAME="qa"
DB_NAME="ask"
DB_USER_NAME="box"


init_nginx()
{
	# include our settings to nginx main config
	sudo ln -sf $PROJ_DIR/etc/nginx.conf /etc/nginx/sites-enabled/nginx.conf
	# delete default location settings
	sudo rm -rf /etc/nginx/sites-enabled/default
	# start/restart nginx
	sudo /etc/init.d/nginx restart
}

init_gunicorn()
{
	# delete example settings
	sudo rm /etc/gunicorn.d/*
	# include settings for hello.py to gunicorn
	sudo ln -sf $PROJ_DIR/etc/hello.conf /etc/gunicorn.d/hello.conf
	# include settings for app ask to gunicorn 
	sudo ln -sf $PROJ_DIR/etc/ask.conf /etc/gunicorn.d/ask.conf
	# start gunicorn
	sudo /etc/init.d/gunicorn restart
}

init_mysql()
{
	# Delete old settings
	sudo rm /etc/mysql/conf.d/mysql.cnf
	# Start MySQL
	sudo /etc/init.d/mysql start
	# Create database
	sudo mysql -u root -e "create database if not exists $DB_NAME;"
	# Create user with privileges to manage this database
	sudo mysql -u root -e "grant all privileges on $DB_NAME.* to '$DB_USER_NAME'@'localhost' with grant option;"
}


################
####  MAIN  ####
################
case "$1" in
	init)
		init_nginx
		init_gunicorn
		init_mysql
	;;
	start)
		sudo /etc/init.d/nginx start
		sudo /etc/init.d/gunicorn start
		sudo /etc/init.d/mysql start
	;;
	restart)
		sudo /etc/init.d/nginx restart
		sudo /etc/init.d/restart restart
		sudo /etc/init.d/mysql restart
	;;
	stop)
		sudo /etc/init.d/nginx stop
		sudo /etc/init.d/gunicorn stop
		sudo /etc/init.d/mysql stop
	;;
	*)
		echo "Usage: $0 {init|start|stop|restart}" >&2
		exit 1
	;;
esac