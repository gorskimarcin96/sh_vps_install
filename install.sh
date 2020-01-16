#PAMIETAJ O SPACJACH W PHPMYADMIN
#PAMIETAJ O SPACJACH W PHPMYADMIN
#PAMIETAJ O SPACJACH W PHPMYADMIN
#spacja, tab, enter

ssh -i .ssh/stefan root@164.132.42.211

#firewall
sudo ufw allow OpenSSH
sudo ufw enable #-y
sudo ufw allow 'Apache Full'

#apache
sudo apt update
sudo apt install apache2 -y

#VirtualHost
echo '<VirtualHost *:80>' > /etc/apache2/sites-available/mgorski.dev.conf
echo '  ServerName mgorski.dev' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '  ServerAlias www.mgorski.dev' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '  DocumentRoot "/var/www/html/public"' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '<Directory /var/www/>' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '  Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '  AllowOverride All' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '  Require all granted' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '  FallbackResource /index.php' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '</Directory>' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '' >> /etc/apache2/sites-available/mgorski.dev.conf
echo 'ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/mgorski.dev.conf
echo 'CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/mgorski.dev.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/mgorski.dev.conf
#nano /etc/apache2/sites-available/mgorski.dev.conf 
sudo a2ensite mgorski.dev.conf 

#VirtualHost 2
echo '<VirtualHost *:80>' > /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '  ServerName forum.mgorski.dev' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '  ServerAlias www.forum.mgorski.dev' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '  DocumentRoot "/var/www/forum/public"' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '<Directory /var/www/>' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '  Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '  AllowOverride All' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '  Require all granted' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '  FallbackResource /index.php' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '</Directory>' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo 'ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo 'CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/forum.mgorski.dev.conf
#nano /etc/apache2/sites-available/forum.mgorski.dev.conf 
sudo a2ensite forum.mgorski.dev.conf 
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
clear
sudo apache2ctl configtest
sudo systemctl reload apache2
sudo systemctl restart apache2

#certbot
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get update
sudo apt-get install certbot python-certbot-apache
sudo certbot --apache -d mgorski.dev -d www.mgorski.dev -m gorskimarcin96@gmail.com

#php
sudo apt install php libapache2-mod-php php-mysql -y
echo '<IfModule mod_dir.c>' > /etc/apache2/mods-enabled/dir.conf
echo '    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm' >> /etc/apache2/mods-enabled/dir.conf
echo '</IfModule>' >> /etc/apache2/mods-enabled/dir.conf
sudo apt install php-cli

#mysql
sudo apt install mysql-server -y
sudo mysql_secure_installation -y
sudo mysql <<EOF
	ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'TWOJE_HASŁO';
	FLUSH PRIVILEGES;
	exit
EOF

#phpMyAdmin
sudo apt update
sudo apt install phpmyadmin php-mbstring php-gettext -y
sudo phpenmod mbstring
sudo systemctl restart apache2

#mysql naprawa groupBy
echo 'sql-mode=""' >> /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

#mysql dostęp do bazy danych z innych adresów (komentujemy linijkę bind-address)
#/etc/mysql/mysql.conf.d/mysqld.cnf
#bind-address = 127.0.0.1

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
sudo npm install -g
