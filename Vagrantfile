MoviesDirectory = ENV["MoviesDirectory"] || "/path/to/movies"
TVShowsDirectory = ENV["TVShowsDirectory"] || "/path/to/tvshows"
NetworkAdapter = ENV["NetworkAdapter"] || ""


Vagrant.configure("2") do |config|
  config.vm.hostname = "MediaBox"
  config.vm.box = "phusion/ubuntu-14.04-amd64"

  # Setting a dummy MAC address so that the DHCP server can use it to assign a static IP.
  config.vm.network "public_network", :mac => "000000000001", bridge: NetworkAdapter, type: "dhcp"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 32400, host: 32400
  config.vm.network "forwarded_port", guest: 51413, host: 51413

  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.synced_folder "./downloads", "/media/downloads", type: "nfs"
  config.vm.synced_folder MoviesDirectory, "/media/movies", type: "nfs"
  config.vm.synced_folder TVShowsDirectory, "/media/tvshows", type: "nfs"

  config.vm.provision "shell", path: "install.sh"

  # VirtualBox specific config
  config.vm.provider "virtualbox" do |v, override|
    v.memory = 1536
    v.cpus = 2

    # VirtualBox requires a NFS share due to a lack of locking support in the basic share. Locking
    # is required by the Plex Media Service when writing to the database. VirtualBox NFS shares
    # require a private network.
    override.vm.network "private_network", ip: "172.16.0.150"
  end

  # Cache vagrant packages if vagrant-cachier plugin installed
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

end
