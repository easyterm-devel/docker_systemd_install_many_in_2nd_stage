#echo -e "127.0.0.1   `hostname -f`.$FIRST_DOMAIN   `hostname -f`     localhost \n" >> /etc/hosts
#echo "127.0.0.1   `hostname -f`.$FIRST_DOMAIN   `hostname -f`     localhost" | cat - /etc/hosts > temp && mv temp /etc/hosts

sed -i "s/_VMAIL_DB_BIND_PASSWD/$VMAIL_DB_BIND_PASSWD/g" config
sed -i "s/_VMAIL_DB_ADMIN_PASSWD/$VMAIL_DB_ADMIN_PASSWD/g" config
sed -i "s/_MYSQL_ROOT_PASSWD/$MYSQL_ROOT_PASSWD/g" config
sed -i "s/_FIRST_DOMAIN/$FIRST_DOMAIN/g" config
sed -i "s/_DOMAIN_ADMIN_PASSWD_PLAIN/$DOMAIN_ADMIN_PASSWD_PLAIN/g" config
sed -i "s/_AMAVISD_DB_PASSWD/$AMAVISD_DB_PASSWD/g" config
sed -i "s/_IREDADMIN_DB_PASSWD/$IREDADMIN_DB_PASSWD/g" config
sed -i "s/_RCM_DB_PASSWD/$RCM_DB_PASSWD/g" config
sed -i "s/_SOGO_DB_PASSWD/$SOGO_DB_PASSWD/g" config
sed -i "s/_SOGO_SIEVE_MASTER_PASSWD/$SOGO_SIEVE_MASTER_PASSWD/g" config
sed -i "s/_IREDAPD_DB_PASSWD/$IREDAPD_DB_PASSWD/g" config

REDMAIL_DEBUG='NO' \
AUTO_USE_EXISTING_CONFIG_FILE=y \
AUTO_INSTALL_WITHOUT_CONFIRM=y \
AUTO_CLEANUP_REMOVE_SENDMAIL=y \
AUTO_CLEANUP_REMOVE_MOD_PYTHON=y \
AUTO_CLEANUP_REPLACE_FIREWALL_RULES=n \
AUTO_CLEANUP_RESTART_IPTABLES=y \
AUTO_CLEANUP_REPLACE_MYSQL_CONFIG=y \
AUTO_CLEANUP_RESTART_POSTFIX=n \
bash ./iRedMail.sh 2>&1 install.log && halt

