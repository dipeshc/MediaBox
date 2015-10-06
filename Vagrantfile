MoviesDirectory = ENV["MoviesDirectory"] || "/path/to/movies"
TVShowsDirectory = ENV["TVShowsDirectory"] || "/path/to/tvshows"
NetworkAdapter = ENV["NetworkAdapter"] || ""


Vagrant.configure("2") do |config|
  config.vm.hostname = "MediaBox"
  config.vm.box = "trusty64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Creating private network for NFS share of /vargant directory. NFS is require by the plex meda server
  # to database for locking. This feature isn't supported by the default vbox share.
  config.vm.network "private_network", ip: "172.16.0.150"

  # Setting a dummy MAC address so that the DHCP server can use it to assign a static IP.
  config.vm.network "public_network", :mac => "000000000001", bridge: NetworkAdapter, type: "dhcp"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 32400, host: 32400
  config.vm.network "forwarded_port", guest: 51413, host: 51413

  config.vm.provider "virtualbox" do |v|
    v.memory = 1536
    v.cpus = 2
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # NFS share required by plex media server database (see above comments).
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.synced_folder "./downloads", "/media/downloads"
  config.vm.synced_folder MoviesDirectory, "/media/movies"
  config.vm.synced_folder TVShowsDirectory, "/media/tvshows"

  config.vm.provision "shell", path: "install.sh"
end
