# Build an APEX Stack with Docker

> For background information on this repository, please read this [blog post](https://fuzziebrain.com/content/id/1902/).

## Prerequisites

* `sudo` rights.
* Installed the following:
    * Git
    * Curl
    * Docker (of course)

> IMPORTANT
>
> Build and execution has been tested in Linux only. It should work in Mac OS, but likely not with Windows. Sorry.

## Getting Started

1. Git clone this repository and set it as the working directory.
2. Download the installer files:
    * [Oracle Database 18c XE](https://oracle.com/xe) or any of the required installation files from [OTN](https://www.oracle.com/technetwork/database/)
    * [Oracle Application Express](https://apex.oracle.com/download) (the latest version is 19.1 as of March 29, 2019)
    * [Oracle REST Data Services](https://www.oracle.com/technetwork/developer-tools/rest-data-services/downloads/index.html) (the latest version is 18.4 as of February 16, 2019)
    * [Java Development Kit SE 8](https://www.oracle.com/technetwork/java/javase/downloads/)
3. Place all three files in the sub-directory `files`.
4. Create a new file that contains the required variables. Make a copy of `settings.env.sample`, e.g. `mysettings.env`, and modify as desired. The file should contain the following variables:
    ```bash
    ORACLE_SID=XE
    ORACLE_PDB=XEPDB1
    ORACLE_PWD=Oracle18
    APEX_ADMIN_EMAIL=myemail@domain.com
    APEX_ADMIN_PWD=Oracle__18
    INSTALL_FILE_APEX=apex_19.1.zip
    INSTALL_FILE_ORDS=ords-18.4.0.354.1002.zip
    INSTALL_FILE_JAVA=jdk-8u201-linux-x64.tar.gz
    DOCKER_ORDS_PORT=50080
    DOCKER_EM_PORT=55500
    DOCKER_DB_PORT=51521
    DB_VERSION=18.4.0
    DB_EDITION=XE
    ```
5. Run the first script to grab the latest Docker [images](https://github.com/oracle/docker-images) from Oracle and build the Oracle Database image. The script takes one parameter, the environment filename (`mysettings.env`):
    ```bash
    $ . 01-build.sh mysettings.env
    ```
6. Run the final script to create and run the container, where the container name is `axer` (it is preferred that you execute a command using `sudo` before executing this script):
    ```bash
    $ . 02-run.sh axer mysettings.env
    ```

    > **IMPORTANT**
    >
    > The second script requires `sudo` rights. If your user does not have this privilege, comment out `sudo chown 54321:54321 oradata` and replace it with `chmod 777 oradata`.

Using the sample settings, the following are accessible:

| Port | Application | URL |
|-|-|-|
| 50080 | APEX | http://localhost:50080 |
| 51521 | Database | N/A |
| 55500 | Enterprise Manager Express | https://localhost:55500/em | 
