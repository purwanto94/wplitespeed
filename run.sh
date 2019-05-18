# INSTALL WORDPRESS
cd /home/defdomain/html/
rm -rf *
wget --no-check-certificate http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz  >/dev/null 2>&1
mv wordpress/* ./
chown -R nobody:nobody /home/defdomain/html/

# DELETE INSTALL FILE
rmdir wordpress
rm latest.tar.gz
