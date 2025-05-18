#!/bin/bash

# Automatically assign incus profiles to all containers (and some other functionalities).


for i in $(incus list | awk '{print $2}' | grep "ds"); do
    echo "$i"
    incus stop "$i" && echo "Container stopped!"
#    incus move "$i" "$i" --storage tank4 && echo "Container transffered!"
    incus profile remove "$i" development
    incus profile assign "$i" prod
    incus exec "$i" -- dhclient -i Dev -> nije potrebno jer smo promenili ime same mreze u eth0 tako da ce networkd na containerima prepoznati fajl eth0 koji je po defaultu
    incus restart "$i"
    incus start "$i" && echo "Container started!!!"
done

incus ls
incus network ls
incus storage ls
