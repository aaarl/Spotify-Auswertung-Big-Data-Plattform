FROM mysql
COPY init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod -R 775 /docker-entrypoint-initdb.d