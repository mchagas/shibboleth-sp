#/bin/bash

service apache2 restart

service shibd restart

while true; do sleep 30; done;
