#!/bin/bash

# Magarena Start Script
# License: Public Domain

maghome="$HOME/.magarena"

bootstrap() {

  echo -e "\033[1m==> Updating local cache..\033[0m\n"
  cp -rf /usr/share/magarena-base/. $maghome/

}

# check if user needs update
if [ ! -d "$maghome" ]; then
    mkdir $maghome
    bootstrap
elif [ "$1" == "update" ]; then
    bootstrap
elif ! diff /usr/share/magarena-base/Magarena/VERSION $maghome/Magarena/VERSION >/dev/null 2>&1; then
    bootstrap
fi

# this is needed to get Readme.txt to work
cd $maghome/Magarena

jardir=/usr/share/java/magarena
CP=$CP:$jardir/magarena.jar:$jardir/lib/groovy-all-2.2.1.jar
CP=$CP:$jardir/lib/miglayout-core-4.2.jar:$jardir/lib/miglayout-swing-4.2.jar
CP=$CP:$jardir/lib/commons-io-2.4.jar:$jardir/lib/trident-1.3.jar

echo "If magarena wont start delete the .magarena/Magarena/scripts folder and start with \"magarena update\""

exec "$JAVA_HOME/bin/java" -Xms256M -Xmx512M -Dmagarena.dir=$maghome -cp $CP magic.MagicMain
