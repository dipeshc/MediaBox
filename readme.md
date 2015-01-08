#MediaBox
A virtual media center based on Plex, Couchpotato, Sickbeard and Transmission.

## Getting Started
Install [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/)
```
export MoviesDirectory=/path/to/your/movies/directory/
export TVShowsDirectory=/path/to/your/tvshow/directory/
vagrant up
```
Browse to http://172.16.0.150, username is "admin", password is "password"

## FAQs
###### Can I change the default username and password?
Yes. Run `htpasswd -c <path to checkout directory>/settings/nginx/htpasswd <username>`

###### Can I access the box from anywhere on my local network?
Yes. The box will have got an IP address from your local DHCP server. Either see the DHCP server for the IP details OR run `vagrant ssh -c ifconfig`

###### Can I speed up my downloads in Transmission?
Yes. Port forward 51413 from the router to the host machine.

###### Can I publish my plex server to http://plex.tv/web/app?
Yes. Port forward 32400 from the router to the host machine.

###### Do I have to export my Movies and TV Shows directory everytime?
Nope. Either update bash profile to include the above export commands OR update the vagrant file.

###### Do I have to select a network adapter everytime I run `vagrant up`?
Nope. Either update your bash profile to export NetworkAdapter with the adapter name OR update the vagrant file.

###### Can I installing a beta plexpass version of plex?
Yes. Download the installer from the plexpass website and drop it in the mediabox directory. The next time the box is provisioned it will use the new version.

###### Why is the MAC address set to 000000000001?
This is an dummy addres, which can be used by the DHCP server to set a static IP for the box.
