MoviesDirectory = ENV["MoviesDirectory"] || "/path/to/movies"
TVShowsDirectory = ENV["TVShowsDirectory"] || "/path/to/tvshows"
NetworkAdapter = ENV["NetworkAdapter"] || ""


Vagrant.configure("2") do |config|
  config.vm.hostname = "MediaBox"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Setting a dummy MAC address so that DHCP server can be used assign a static IP
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

  config.vm.synced_folder "./downloads", "/media/downloads"
  config.vm.synced_folder MoviesDirectory, "/media/movies"
  config.vm.synced_folder TVShowsDirectory, "/media/tvshows"

  config.vm.provision "shell", path: "install.sh"
end