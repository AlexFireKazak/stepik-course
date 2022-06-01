DB_NAME="ask"
DB_USER_NAME="box"
DJ_APP_NAME="qa"

mv web /home/box/
sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default
sudo ln -sf /home/box/web/etc/nginx.conf /etc/nginx/sites-enabled/test.conf
sudo ln -sf /home/box/web/etc/nginx.conf /etc/nginx/sites-available/test.conf
sudo /etc/init.d/nginx restart
gunicorn -w 2 -c /home/box/web/etc/hello.py hello:app &
gunicorn -w 2 -c /home/box/web/etc/gunicorn_django_conf.py ask.wsgi:application &
# SQL Parth
#put my setup
sudo ln -sf /home/box/web/etc/mysql.cnf /etc/mysql/conf.d/mysql.cnf
sudo /etc/init.d/mysql restart
sudo mysql -u root -e "create database if not exists $DB_NAME;"
sudo mysql -u root -e "grant all privileges on $DB_NAME.* to '$DB_USER_NAME'@'localhost' with grant option;"

/home/box/web/ask/manage.py makemigrations $DJ_APP_NAME
/home/box/web/ask/manage.py migrate
/home/box/web/ask/manage.py syncdb