Oracle Database 12c Release 1 Docker image template
===================================================

Server installation
-------------------

This is [Docker](https://www.docker.com/) image template you can use to dockerize [Oracle Database 12c Release 1 Enterprise Edition](http://www.oracle.com/technetwork/database/enterprise-edition/overview/index.html) on the [Oracle Linux 7.2](https://www.oracle.com/linux/index.html). It's goal is to provide the most easy way to get the Oracle Database 12c Release 1 Enterprise Edition up and running as well as populate it with some [sample schemas](https://docs.oracle.com/database/121/COMSC/toc.htm) to experiment with it. Besides that, probably the virtualisation is the only one way to get this software running on unsupported host OS, ie. MacOS. For supported operating systems an argument in favor of Docker is possible unwillingness of not messing up your host OS with database, its dependencies and other files.

Oracle Database 12c installation guide can be found [there](https://docs.oracle.com/database/121/LADBI/toc.htm). Administration guide is [there](https://docs.oracle.com/database/121/ADMIN/toc.htm).

In order to build the image you have to visit [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html) page, and download both files of Linux x86-64 distribution. After that you have to unzip them into the `assets` folder of this repository:

    $ unzip -o <path_to_downloaded_files>/linuxamd64_12102_database_1of2.zip -d <path_to_template>/assets/
    $ unzip -o <path_to_downloaded_files>/linuxamd64_12102_database_2of2.zip -d <path_to_template>/assets/

Then run the following command from the root of the repository in order to build the image (it assumes you allready have installed Docker).

    $ docker build -m 3g --shm-size=4g -t orcl12c .


Client installation
-------------------

To access Oracle database tools like [Instant Client](http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html) or [SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index-098778.html) can be used. Instant Client offers various clients to access Oracle Database as well as standard CLI client called [SQL*Plus](https://docs.oracle.com/database/121/SQPUG/ch_three.htm#SQPUG013) whilst SQL Developer is a pure GUI client sollution.

In order to install SQL*Plus on MacOS you have to follow these [instructions](http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html#ic_osx_inst).

Usage
-----

Run Oracle Database in isolated Docker container (map ports to different ones if you don't want direct mapping) and start instance:

    $ docker run -dit --shm-size=4g -p 1521:1521 -p 5500:5500 --name=orcl12c orcl12c
    $ docker exec -it orcl12c lsnrctl start
    $ docker exec -it orcl12c sqlplus / as sysdba

    SQL*Plus: Release 12.1.0.2.0 Production on Thu Nov 17 17:34:18 2016

    Copyright (c) 1982, 2014, Oracle.  All rights reserved.

    Connected to an idle instance.

    SQL> startup
    ORACLE instance started.

    Total System Global Area 1895825408 bytes
    Fixed Size		    2925744 bytes
    Variable Size		 1191185232 bytes
    Database Buffers	  687865856 bytes
    Redo Buffers		   13848576 bytes
    Database mounted.
    Database opened.

Passwords for the starter database for the **SYS**, **SYSTEM** and  **DBSNMP** are lowercased values **sys**, **system** and **dbsnmp**.
