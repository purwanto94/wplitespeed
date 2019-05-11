# INSTALL WORDPRESS
cd /var/lib/litespeed/Example/html
rm -rf *
wget --no-check-certificate http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz  >/dev/null 2>&1
mv wordpress/* ./
chown -R nobody:nobody /var/lib/litespeed/Example/html

# DELETE INSTALL FILE
rmdir wordpress
rm latest.tar.gz
