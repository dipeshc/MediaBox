#!/bin/bash

# Install base packages
echo "deb http://plex.r.worldssl.net/PlexMediaServer/ubuntu-repo lucid main" > /etc/apt/sources.list.d/plexmediaserver.list
apt-get update
apt-get install -y screen curl git-core python-cheetah python-software-properties python-setuptools

# Install nginx
apt-get install -y nginx
service nginx stop
ln -fs /vagrant/settings/nginx/nginx.conf /etc/nginx/nginx.conf
service nginx start

# Install plex
PlexMediaServerPackage="$(find /vagrant -name "plexmediaserver_*.deb" 2>/dev/null | head -1)"
if [ -z $PlexMediaServerPackage ]; then
    apt-get install -y --force-yes plexmediaserver
else
    echo "Local plexmediaserver package $PlexMediaServerPackage found. Will be installing it."
    apt-get install -y avahi-daemon avahi-utils
    dpkg -i $PlexMediaServerPackage
fi
service plexmediaserver stop
ln -fs /vagrant/settings/plex/default /etc/default/plexmediaserver
service plexmediaserver start

## Install transmission
apt-get install -y transmission-daemon
service transmission-daemon stop
ln -fs /vagrant/settings/transmission/default /etc/default/transmission-daemon
ln -fs /vagrant/settings/transmission/settings.json /vagrant/data/transmission
service transmission-daemon start

## Install sickbeard
git clone git://github.com/junalmeida/Sick-Beard.git /opt/sickbeard -b torrent_1080_subtitles
ln -fs /opt/sickbeard/init.ubuntu /etc/init.d/sickbeard
ln -fs /vagrant/settings/sickbeard/default /etc/default/sickbeard
update-rc.d sickbeard defaults
/etc/init.d/sickbeard start

## Install couchpotato
git clone git://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato
ln -fs /opt/couchpotato/init/ubuntu /etc/init.d/couchpotato
ln -fs /vagrant/settings/couchpotato/default /etc/default/couchpotato
update-rc.d couchpotato defaults
/etc/init.d/couchpotato start