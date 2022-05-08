echo "Install PHP Version (eg: 7.4, 8.1):"

read php_version

sudo apt install php php$php_version-cli php$php_version-curl php$php_version-xml php$php_version-mbstring php$php_version-zip php$php_version-gd php$php_version-fpm php$php_version-mysql libapache2-mod-php$php_version libapache2-mod-fcgid

systemctl start php$php_version-fpm

systemctl status php$php_version-fpm
