#PAMIETAJ O SPACJACH W PHPMYADMIN
#PAMIETAJ O SPACJACH W PHPMYADMIN
#PAMIETAJ O SPACJACH W PHPMYADMIN
#spacja, tab, enter

#apache2
sudo apt update
sudo apt install apache2 -y

#mysql
sudo apt install mysql-server -y
sudo mysql_secure_installation -y
sudo mysql <<EOF
	ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'TWOJE_HASŁO';
	FLUSH PRIVILEGES;
	exit
EOF

#php
sudo apt install php libapache2-mod-php php-mysql -y
cd /etc/apache2/mods-enabled/
echo '<IfModule mod_dir.c>' > dir.conf
echo '    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm' >> dir.conf
echo '</IfModule>' >> dir.conf
sudo apt install php-cli

#phpMyAdmin
sudo apt update
sudo apt install phpmyadmin php-mbstring php-gettext -y
sudo phpenmod mbstring
sudo systemctl restart apache2

#composer
sudo apt install composer -y

#yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn -y
yarn install

#node.js
sudo apt-get install npm -y
npm install -g @angular/cli
sudo npm cache clean -f
sudo npm install -g n

#htaccess
sudo a2enmod rewrite
sudo systemctl restart apache2

#mysql naprawa groupBy
cd /etc/mysql/mysql.conf.d
echo 'sql-mode=""' >> mysqld.cnf
sudo systemctl restart mysql

#mysql dostęp do bazy danych z innych adresów (komentujemy linijkę bind-address)
/etc/mysql/mysql.conf.d/mysqld.cnf
#bind-address = 127.0.0.1

#VirtualHost
#<VirtualHost *:80>
#    DocumentRoot "/var/www/html/public"
#    ServerName mgorski.dev
#    ServerAlias www.mgorski.dev
#
#<Directory /var/www/>
#    Options Indexes FollowSymLinks
#    AllowOverride All
#    Require all granted
#    FallbackResource /index.php
#</Directory>
#
#ErrorLog ${APACHE_LOG_DIR}/error.log
#CustomLog ${APACHE_LOG_DIR}/access.log combined
#</VirtualHost>
#
#<VirtualHost *:80>
#    DocumentRoot "/var/www/html_test/public"
#    ServerName test.mgorski.dev
#    ServerAlias www.test.mgorski.dev
#
#<Directory /var/www/>
#    Options Indexes FollowSymLinks
#    AllowOverride All
#    Require all granted
#    FallbackResource /index.php
#</Directory>
#
#ErrorLog ${APACHE_LOG_DIR}/test_error.log
#CustomLog ${APACHE_LOG_DIR}/test_access.log combined
#</VirtualHost>
