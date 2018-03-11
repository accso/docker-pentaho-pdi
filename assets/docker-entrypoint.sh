#! /bin/sh
USER_HOME=/home/${DOCKER_USER}
echo "Mapping UID $TARGET_UID and GID $TARGET_GID for container user ${DOCKER_USER}..."
sed -i s/$DOCKER_USER:x:1000:1000/$DOCKER_USER:x:$TARGET_UID:$TARGET_GID/ /etc/passwd

export JAVA_HOME=/opt/java

echo "Mapping UID and GID in files..."
chown $DOCKER_USER.$DOCKER_USER /home/$DOCKER_USER

echo "Using $DISPLAY for contacting X server..."

#cat ~/.Xauthority

SCRIPT=$USER_HOME/start.sh
echo "#!/bin/sh" > $SCRIPT
echo "export DISPLAY=$DISPLAY" >> $SCRIPT
echo "export QT_GRAPHICSSYSTEM=opengl"  >> $SCRIPT
echo "cd /opt" >> $SCRIPT
echo "echo Starting spoon.sh" >> $SCRIPT
echo "./data-integration/spoon.sh" >> $SCRIPT
chmod +x $SCRIPT

echo "Starting start script..."
su -l $DOCKER_USER -c $SCRIPT
