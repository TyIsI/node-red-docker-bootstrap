#!/bin/sh

cd /data

if [ -f package.json ] ; then
 echo "Caching installed packages..."
 npm list --depth=0 | egrep -v $(pwd) | awk '{ print $2 }' | cut -f1 -d'@' | egrep -v '^$' > /bootstrap/cache/packages-installed.txt
 
 echo "Installing missing packages..."
 cat /bootstrap/conf/packages.txt | egrep -v '^(#|;|$)' | egrep -v -f /bootstrap/cache/packages-installed.txt | while read line node_module
 do
  npm install "$node_module"
  res=$?
  if [ $res -eq 0 ] ; then
   echo "$node_module" >> /bootstrap/cache/packages-installed.txt
  else
   echo "Failed to install node_module: $node_module"
   echo "Please fix the issue and restart the container."
   exit
  fi
 done
else
 echo "Skipping packages install"
fi

cd /usr/src/node-red

exec "$@"
