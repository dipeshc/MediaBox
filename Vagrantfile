Vagrant.configure("2") do |config|
  config.vm.hostname = "Media"
  config.vm.box = "precise64"
  config.vm.network "public_network"

  config.vm.network "forwarded_port", guest: 5050, host: 5050   # Couchpotato
  config.vm.network "forwarded_port", guest: 8081, host: 8081   # Sickbeard
  config.vm.network "forwarded_port", guest: 9091, host: 9091   # Transmission
  config.vm.network "forwarded_port", guest: 32400, host: 32400 # Plex
  config.vm.network "forwarded_port", guest: 51413, host: 51413 # Transmission

  config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder "./downloads", "/media/downloads"
  config.vm.synced_folder "/host/path/to/movies", "/media/movies"
  config.vm.synced_folder "/host/path/to/tv", "/media/tv"

  config.vm.provision "shell", inline: $script
end

$script = <<SCRIPT
echo "deb http://plex.r.worldssl.net/PlexMediaServer/ubuntu-repo lucid main" > /etc/apt/sources.list.d/plexmediaserver.list
apt-get update
apt-get install -y curl git-core python-cheetah python-software-properties transmission-daemon
apt-get install -y --force-yes plexmediaserver
curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | python

service transmission-daemon stop
ln -fs /vagrant/settings/transmission/init.d /etc/init.d/transmission-daemon
ln -fs /vagrant/settings/transmission/settings.json /etc/transmission-daemon/settings.json
service transmission-daemon start

git clone git://github.com/junalmeida/Sick-Beard.git /opt/sickbeard -b torrent_1080_subtitles
ln -fs /opt/sickbeard/init.ubuntu /etc/init.d/sickbeard
ln -fs /vagrant/settings/sickbeard/default /etc/default/sickbeard
update-rc.d sickbeard defaults
/etc/init.d/sickbeard start

git clone git://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato
ln -fs /opt/couchpotato/init/ubuntu /etc/init.d/couchpotato
ln -fs /vagrant/settings/couchpotato/default /etc/default/couchpotato
update-rc.d couchpotato defaults
/etc/init.d/couchpotato start
SCRIPT