# docker-pentaho-pdi
Docker container to start the Pentaho Spoon fat client using the XWindows server on the docker host.

## GUI

The container uses the approach of letting the application communicate with the X server running on the host by using specific X11 files located on the host server. The application can be started as though it were residing on the host server. The mounted files and directories are as follows:

 * `/tmp/.X11-unix`
 * `/etc/machine-id`
 * `$HOME/.Xauthority`

## Accessing Spoon files from outside the container

The aim of the container is to let the user consistently read and write PDI files located on the host server without having to worry about mismatching UID or GID. In order to achieve this the following measures have been taken:

 * provide a user (`pentaho`) in the container and run the application using that user and its default group,
 * dynamically change the UID of that user and the GID of its group to match the UID and GID of the host user starting the container,
 * add the username of the calling user to the container name so that possible several users can call the run script and have seperate containers without collision,
 * map the home directory of the calling user as `home_on_host` in the home directory of user `pentaho`,
 
## Usage

On a linux system just copy the [run.sh](bin/run.sh) to your local file system, make it executable and run it. Use the script [build.sh](bin/build.sh) to build the container locally after cloning https://github.com/accso/docker-pentaho-pdi.

## Dockerfile

The [Dockerfile](Dockerfile) executes the following steps:

 * retrieve the Debian installation package from [SourceForge](https://kent.dl.sourceforge.net/project/pentaho),
 * install the package using `unzip`,
 * install a `docker-entrypoint.sh` script.
 
## Caveats

* Exiting the application does not terminate the container. It must be stopped manually.


