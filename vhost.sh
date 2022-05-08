#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Insert domain name (eg: local-app.test):"
read domain_name

echo "Insert path (eg: /home/yo/Sites/app/public):"
read app_path 

echo "Use custom PHP version? (y/n):"
read use_custom_php

if [ $use_custom_php = "y" ]
then
	echo "Insert PHP version (eg: 7.4):"
	read php_version
fi

echo "Ok, wait";

vhost_file=/etc/apache2/sites-available/$domain_name.conf

if [ -f "$vhost_file" ]; then 
	echo "File $vhost_file already exists"
else

touch $vhost_file

tee -a $vhost_file << END
<VirtualHost *:80>
        ServerName $domain_name
        ServerAdmin webmaster@localhost
        DocumentRoot $app_path 

	ErrorLog /var/log/apache2/error.log
	CustomLog /var/log/apache2/access.log combined

        <Directory $app_path>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>
END

if [ $use_custom_php = "y" ]
then
tee -a $vhost_file << END
    <FilesMatch \.php$>
      SetHandler "proxy:unix:/run/php/php$php_version-fpm.sock|fcgi://localhost"
    </FilesMatch>
END
fi


tee -a $vhost_file << END
</VirtualHost>
END

a2ensite $domain_name
systemctl reload apache2


fi

if grep -Fxq "127.0.0.1 $domain_name" /etc/hosts 
then
	# ignore it
	echo "Already on /etc/hosts"
else
	sed -i "1s/^/127.0.0.1 $domain_name\n/" /etc/hosts 
fi

echo "done";

echo "Your app url: http://$domain_name"
echo "Your app path: $app_path"
