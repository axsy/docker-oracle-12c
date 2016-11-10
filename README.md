Oracle Database 12c Release 1 Docker image template
---------------------------------------------------------------

This is Docker image template you can use to dockerize [Oracle Database 12c Release 1](http://www.oracle.com/technetwork/database/enterprise-edition/overview/index.html) over the lightweight [Alpine Linux](https://alpinelinux.org/).

The reason for this project is started is to be able to run Oracle Database 12c Release 1 primarily in MacOS development environment and save SSD space as much as possible. Any other environment, that is supported by Docker, can be used.

In order to build the image you have to visit [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html) page, accept license agreement (in case you agree with it), and download both files of Linux x86-64 distribution. After that you have to unzip them into the `assets` folder of this repository:

    unzip -o <path_to_downloaded_files>/linuxamd64_12102_database_1of2.zip -d <path_to_template>/assets/
    unzip -o <path_to_downloaded_files>/linuxamd64_12102_database_2of2.zip -d <path_to_template>/assets/

Then run the following command from the root of the repository in order to build the image (it assumes you allready have installed and configured Docker environment).

    docker build -t oracle-database-12c-r1 .