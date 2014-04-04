Vagrant.configure("2") do |config|
  config.vm.hostname = "Media"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network "private_network", ip: "10.0.0.150"  # private network required for NFS using Virtual Box
  config.vm.network "public_network", :mac => "000000000001", ip: "192.168.1.150"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1536
    v.cpus = 2
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.synced_folder ".", "/vagrant", type: "nfs" # nfs required for couchpotato to access data directory correctly
  config.vm.synced_folder "./downloads", "/media/downloads"
  config.vm.synced_folder "/Volumes/Data/Media/Movies", "/media/movies"
  config.vm.synced_folder "/Volumes/MyPassport/TV Shows", "/media/tv"

  config.vm.provision "shell", inline: $script
end

$script = <<SCRIPT
echo "deb http://plex.r.worldssl.net/PlexMediaServer/ubuntu-repo lucid main" > /etc/apt/sources.list.d/plexmediaserver.list
apt-get update
apt-get install -y screen curl git-core python-cheetah python-software-properties transmission-daemon nginx
apt-get install -y --force-yes plexmediaserver
curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | python

service plexmediaserver stop
ln -fs /vagrant/settings/plex/default /etc/default/plexmediaserver
service plexmediaserver start

service nginx stop
ln -fs /vagrant/settings/nginx/nginx.conf /etc/nginx/nginx.conf
service nginx start

service transmission-daemon stop
ln -fs /vagrant/settings/transmission/default /etc/default/transmission-daemon
ln -fs /vagrant/settings/transmission/settings.json /vagrant/data/transmission
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
