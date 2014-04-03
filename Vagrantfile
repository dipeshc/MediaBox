Vagrant.configure("2") do |config|
  config.vm.hostname = "Media"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network "public_network", :mac => "000000000001", ip: "192.168.1.150"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1536
    v.cpus = 2
  end

  config.vm.network "forwarded_port", guest: 53, host: 53       # PlexConnect   DNS
  config.vm.network "forwarded_port", guest: 80, host: 8080     # Nginx         HTTP
  config.vm.network "forwarded_port", guest: 443, host: 8443    # Nginx         HTTPS
  config.vm.network "forwarded_port", guest: 9080, host: 9080   # PlexConnect   HTTP
  config.vm.network "forwarded_port", guest: 9443, host: 9443   # PlexConnect   HTTPS
  config.vm.network "forwarded_port", guest: 5050, host: 5050   # Couchpotato   HTTP
  config.vm.network "forwarded_port", guest: 8081, host: 8081   # Sickbeard     HTTP
  config.vm.network "forwarded_port", guest: 9091, host: 9091   # Transmission  HTTP
  config.vm.network "forwarded_port", guest: 32400, host: 32400 # Plex          HTTP
  config.vm.network "forwarded_port", guest: 51413, host: 51413 # Transmission  Torrents

  config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder "./downloads", "/media/downloads"
  config.vm.synced_folder "/host/path/to/movies", "/media/movies"
  config.vm.synced_folder "/host/path/to/tv", "/media/tv"

  config.vm.provision "shell", inline: $script
end

$script = <<SCRIPT
echo "deb http://plex.r.worldssl.net/PlexMediaServer/ubuntu-repo lucid main" > /etc/apt/sources.list.d/plexmediaserver.list
apt-get update
apt-get install -y screen curl git-core python-cheetah python-software-properties transmission-daemon nginx
apt-get install -y --force-yes plexmediaserver
curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | python

service nginx stop
ln -fs /vagrant/settings/nginx/nginx.conf /etc/nginx/nginx.conf
service nginx start

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