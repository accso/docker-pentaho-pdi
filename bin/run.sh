# Start the Pentaho Spoon fat client in a container using the X11 server of the host
# See https://github.com/accso/docker-pentaho-pdi

# These are paths that have been preconfigured for a typical Linux environment. You have have
# to change them to match your OS.

MACHINE_ID_FILE=${MACHINE_ID_FILE:-/etc/machine-id}
XAUTHORITY_FILE=${XAUTHORITY_FILE:-$HOME/.Xauthority}
X11_DIR=${X11_DIR:-/tmp/.X11-unix}
XKB_DIR=${XKB_DIR:-/usr/share/X11/xkb}

# Determine UID and GID of the user starting the script and pass them to the container
# so that the executing container process can be started using the very same UID and GID.

TARGET_UID=`id -u`
TARGET_GID=`id -g`

# This a
DOCKER_USER=pentaho
DOCKER_CONTAINER=pentaho-pdi-${USER}

docker run --rm \
       -v $X11_DIR:/tmp/.X11-unix \
       -v $MACHINE_ID_FILE:/etc/machine-id \
       -v $XAUTHORITY_FILE:/home/$DOCKER_USER/.Xauthority \
       -h $HOSTNAME \
       -e DISPLAY=$DISPLAY \
       -e DOCKER_USER=$DOCKER_USER \
       -e TARGET_UID=$TARGET_UID \
       -e TARGET_GID=$TARGET_GID \
       -v $HOME:/home/$DOCKER_USER/home_on_host \
       -v $HOME/.docker_qt_config:/home/$DOCKER_USER/.config \
       -v $XKB_DIR:/usr/share/X11/xkb \
       --name $DOCKER_CONTAINER \
       accso/docker-pentaho-pdi:latest 
