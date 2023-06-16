# Usa una imagen base de nginx con PHP-FPM
FROM nginx:stable

# Instala PHP-FPM y el controlador PDO MySQL
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql

#Instala Mariadb
RUN apt-get install -y mariadb-server


COPY php.ini /etc/php/7.4/php.ini
# Configurar PHP-FPM
RUN sed -i 's/^listen = .*/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/^;daemonize = .*/daemonize = no/' /etc/php/7.4/fpm/php-fpm.conf

RUN mkdir -p /var/www/html
RUN mkdir -p /var/run/mysqld

RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www
RUN chown -R www-data:www-data /var/run
RUN chmod -R 755 /var/run
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod -R 755 /var/run/mysqld

RUN rm -f /var/run/mysqld/mysqld.sock

# Configura nginx y mariadb
COPY nginx.conf /etc/nginx/nginx.conf
COPY my.cnf /etc/mysql/my.cnf
COPY mariadb.cnf /etc/mysql/conf.d/mariadb.cnf

# Configura PHP-FPM
COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

#RUN chown -R www-data:www-data /var/www/html/registro.php
#RUN chmod -R 755 /var/www/html/registro.php
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Agrega la siguiente línea para configurar la contraseña de root
RUN echo 'mysql-server mysql-server/root_password password 316170040' | debconf-set-selections
RUN echo 'mysql-server mysql-server/root_password_again password 316170040' | debconf-set-selections

COPY setup.sql /docker-entrypoint-initdb.d/setup.sql
# Expone el puerto 80 para que pueda ser accedido desde fuera del contenedor
EXPOSE 80
EXPOSE 3306

# Inicia nginx y PHP-FPM
CMD service mariadb start && service php7.4-fpm start && nginx -g 'daemon off;'  && tail -f /dev/null 
#-p316170040 < /docker-entrypoint-initdb.d/setup.sql
#RUN service mariadb restart
#RUN mysql -u root -p"316170040" < /docker-entrypoint-initdb.d/setup.sql
# Configurar el punto de entrada del contenedor
# Configurar el punto de entrada del contenedor
#CMD service php7.4-fpm start && service nginx start && service mysql start 
#&& tail -f /dev/null

