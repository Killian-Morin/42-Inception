
<a name="readme-top"></a>

<!-- PROJECT SUMMARY -->
<div align="center">

<h3 align="center">Philosophers</h3>

  <p align="center">
    Summary:
    This project is an introduction to Docker and all related technologies.
    <br>
  </p>
</div>

<!-- TABLE OF CONTENTS -->

- [About The Project](#about-the-project)
- [Sources](#sources)

<!-- ABOUT THE PROJECT -->
## About The Project

This project aims to broaden your knowledge of system administration by using Docker.

This project was done in a Virtual Machine using the `VirtualBox` application.

This project needed a lot of documentation to understand fully and even then it's just an introduction to those concept of Docker, containerization and more.

We had to have 3 containers: one with MariaDB, one with NGINX and one with WordPress. Furthermore we have a volume for the WordPress database and another volume for the WordPress website files.

A docker network links all those elements together.

The subject establishes other minor guidelines and conditions.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SOURCES -->
## Sources

* https://tuto.grademe.fr/inception/

* https://github.com/Forstman1/inception-42

* https://github.com/tblaase/inception

* https://github.com/vbachele/Inception

* https://github.com/JCluzet/Inception/tree/main

* https://stackoverflowteams.com/c/42network/questions/1770

* docker:
  * https://www.youtube.com/watch?v=3c-iBn73dDE
  * https://www.youtube.com/playlist?list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7 #3, 5, 11
  * https://www.youtube.com/playlist?list=PL8SZiccjllt1jz9DsD4MPYbbiGOR_FYHu #1, 2, 3
  * https://docs.docker.com/
  * https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
  * https://hub.docker.com/
  * https://www.youtube.com/watch?v=gAkwW2tuIqE
  * https://www.nicelydev.com/docker
  * https://www.youtube.com/watch?v=rIrNIzy6U_g

* dockerfile: 
  * https://docs.docker.com/engine/reference/builder/

* docker-compose: 
  * https://docs.docker.com/compose/reference/
  * https://docs.docker.com/compose/compose-file/compose-file-v3/

* volumes: 
  * https://earthly.dev/blog/docker-volumes/
  * https://docs.docker.com/storage/volumes/

* MariaDB: 
  * https://mariadb.com/kb/en/training-tutorials/
  * https://dev.mysql.com/doc/refman/8.0/en/data-directory.html

  * installation:
    * https://packages.debian.org/en/sid/mariadb-server
    * https://packages.debian.org/en/bullseye/procps
    * https://packages.debian.org/en/bullseye/mariadb-client

  * mysql:
    * https://dev.mysql.com/doc/refman/8.0/en/sql-statements.html
    * https://dev.mysql.com/doc/refman/8.0/en/mysql-command-options.html

  * mysqld:
    * https://dev.mysql.com/doc/refman/8.0/en/mysqld.html
    * https://dev.mysql.com/doc/refman/8.0/en/server-option-variable-reference.html
    * https://dev.mysql.com/doc/refman/8.0/en/server-options.html

  * fichier de config
    * https://mariadb.com/kb/en/configuring-mariadb-with-option-files/
    * https://mariadb.com/kb/en/configuring-mariadb-connectorc-with-option-files/
    * https://exampleconfig.com/view/mariadb-debian11-etc-mysql-mariadb-conf-d-50-server-cnf

* NGINX:
  * https://www.nginx.com/resources/wiki/start/
  * http://nginx.org/en/docs/beginners_guide.html
  * https://www.youtube.com/watch?v=JKxlsvZXG7c
  * https://www.nginx.com/resources/wiki/start/topics/recipes/wordpress/
  * https://www.openssl.org/docs/man3.0/man1/openssl-req.html

  * script:
    * http://nginx.org/en/docs/switches.html
    * http://nginx.org/en/docs/ngx_core_module.html#daemon

  * fichier de config:
    * http://nginx.org/en/docs/http/ngx_http_core_module.html > toutes les directives
    * https://www.digitalocean.com/community/tutorials/nginx-location-directive > `location` directive
    * https://www.digitalocean.com/community/tutorials/understanding-and-implementing-fastcgi-proxying-in-nginx > pour php-fpm

* WordPress: 
  * https://wiki.debian.org/PHP

  * PHP:
    * https://packages.debian.org/en/bullseye/php7.4
    * https://packages.debian.org/en/bullseye/php7.4-fpm
    * https://packages.debian.org/en/bullseye/php7.4-mysql
    * https://packages.debian.org/en/bullseye/mariadb-client

  * script:
    * https://linux.die.net/man/8/php-fpm

  * fichier de config:

    * https://github.com/php/php-src/blob/master/sapi/fpm/www.conf.in

* yaml:
  * https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html

https://exampleconfig.com/search/?t=Debian%2011 > check the default config files of ≠ applications

<p align="right">(<a href="#readme-top">back to top</a>)</p>
