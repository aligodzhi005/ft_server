service nginx start
service mysql start
service php7.3-fpm start

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='admin';"| mysql -u root --skip-password

bash