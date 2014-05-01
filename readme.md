#MediaBox
A virtual media center based on Plex, Couchpotato, Sickbeard and Transmission.

## Getting Started
1. Install [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/)
1. export MoviesDirectory=/path/to/your/movies/directory/ && export TVDirectory=/path/to/your/tvshow/directory/
1. git clone https://github.com/<path to this repo> mediabox && cd mediabox
1. vagrant up

## FAQs
###### Do I have to export my Movie and TV Show directory everytime?
Nope. For a more permanent solution simple edit the VagrantFile.

###### How can I speed up my downloads in Transmission?
Port forward 51413 from your router to the host machine.

###### How can I publish my plex server to http://plex.tv/web/app?
Port forward 32400 from your router to the host machine.

###### How can I installing a beta plexpass version of plex?
Download the installer from the plexpass website and drop it in the mediabox directory. The next time the box is provisioned it will use the new version.
