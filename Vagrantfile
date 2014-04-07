MoviesDirectory = ENV['MoviesDirectory'] || "/path/to/movies"
TVDirectory = ENV['TVDirectory'] || "/path/to/tv"

Vagrant.configure("2") do |config|
  config.vm.hostname = "Media"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network "private_network", ip: "10.0.0.150"  # private network required for NFS using Virtual Box
  config.vm.network "public_network", :mac => "000000000001", type: "dhcp"
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

  config.vm.synced_folder ".", "/vagrant", type: "nfs" # nfs required for couchpotato to access data directory correctly
  config.vm.synced_folder "./downloads", "/media/downloads"
  config.vm.synced_folder MoviesDirectory, "/media/movies"
  config.vm.synced_folder TVDirectory, "/media/tv"

  config.vm.provision "shell", path: "install.sh"
end
