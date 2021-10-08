# alpine-linux-setup
Alpine Linux Desktop Setup Script

# Alpine Linux
## Base Installation
* download iso from internet
* create vm or dd the iso to a usb, and boot os
* run `setup-alpine` script
* typical answers to questions asked: us, us, sys, dhcp  
* `reboot`

## Auto Personalization
* login as `root` (no password)
* `apk add git`
* `git clone https://github.com/komputes/alpine-linux-setup`
* `cd alpine-linux-setup`
* `./setup.sh`

## Manual Personalization
* login
* `ssh-keygen`

````
eval `ssh-agent -s`
ssh-add
````
