FROM centos:7
RUN rpm -i https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm 
RUN yum -y install httpd mariadb-server mariadb php php-mysql php-gd python-pip python-pip
RUN pip install supervisor
RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql


# Install WordPress
WORKDIR  /var/www/html/
RUN curl -LO http://wordpress.org/latest.tar.gz; tar xzf latest.tar.gz ; chown -R apache:apache *
RUN cd /var/www/html/wordpress; cp wp-config-sample.php wp-config.php

# Set database, user and password
RUN sed -i 's/database_name_here/wordpress/' /var/www/html/wordpress/wp-config.php
RUN sed -i 's/username_here/wordpress/' /var/www/html/wordpress/wp-config.php
RUN sed -i 's/password_here/password/' /var/www/html/wordpress/wp-config.php

# make wordpress as DocumentRoot
RUN sed -i 's/\/var\/www\/html/\/var\/www\/html\/wordpress/' /etc/httpd/conf/httpd.conf

EXPOSE 80
ADD supervisord.conf /tmp
CMD ["supervisord", "-n", "-c", "/tmp/supervisord.conf" ]




