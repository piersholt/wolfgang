INSTALL RASPBIAN
----------------
2018-10-09-raspbian-stretch

RASPBIAN CONFIGURATION
----------------------
    $ sudo raspi-config

8. update to latest version
2. network options
- set hostname to 'pi'
- add wifi
5. interface options
- enable SSH
force audio to 3.5mm
3 boot options
- disbale graphic


    $ sudo apt-get update


ENABLE SSH KEY AUTH
-------------------

    $ ssh pi@pi (enter password)

create ` ~/.ssh/authorized_keys` if required

(i had no permissions issues on my key file)

    $ mkdir ~/.ssh
    $ touch authorized_keys

add chosen public key to authorized keys

    $ echo $PUB_KEY >> ~/.ssh/authorized_keys

Disable password auth, enable key auth.

    $ sudo nano /etc/ssh/sshd_config

    # PasswordAuthentication no
    # PubkeyAuthentication yes

Restart the ssh service

    $ sudo service ssh restart

Double check key is added to ssh-agent... Test ssh.

    ssh pi@pi

ADD PACKAGES
------------

1. byobu
pi@pi:~ $ sudo apt-get install byobu


BLUETOOTH
---------

DESKTOP ONLY!
1. Remove remove the existing bluetooth lxpanel plugin
$ sudo apt-get remove lxplug-bluetooth

2. Install advanced bluetooth GUI plugin
$ sudo apt-get install blueman

BLUETOOTH CONFIG
----------------

1. disable inbuilt bluetooth controller

$ sudo bluetoothctl

[bluetooth]# list
  Controller B8:27:EB:E2:79:E7 pi #2
  Controller 00:1A:7D:DA:71:13 pi [default]
[bluetooth]# select B8:27:EB:E2:79:E7
  Controller B8:27:EB:E2:79:E7 pi #2 [default]
[bluetooth]# power off


2. set alias for onboard bluetooth to make it easier....
i did this via bluetooth panel

BLUEZ
-----
i had it installed, but get v5.0+
$ sudo apt-get install bluez

PULSE AUDIO
-----------
get the pulseaudio plugins

DESKTOP ONLY!
$ sudo apt-get install pavucontrol

Pulse Audio Bluez Plugin
(I didn't have Pulse Audio on Raspbian Lite)
$ sudo apt-get install pulseaudio-module-bluetooth



HEADLESS
--------

$ sudo nano /boot/config.txt
  >> dtoverlay=pi3-disable-bt

$ sudo systemctl disable hciuart'

TEST
----

    $ sudo bluetoothctl

    [bluetooth]# select B8:27:EB:E2:79:E7

    [bluetooth]# agent on
    Agent registered

    [bluetooth]# default-agent
    Default agent request successful

    [bluetooth]# discoverable on
    Changing discoverable on succeeded
    [CHG] Controller B8:27:EB:E2:79:E7 Discoverable: yes

    [NEW] Device E0:F5:C6:07:55:B3 Piers's iPad
    [CHG] Device E0:F5:C6:07:55:B3 Connected: no
    [DEL] Device E0:F5:C6:07:55:B3 Piers's iPad
    [NEW] Device E0:F5:C6:07:55:B3 Piers's iPad

    Request confirmation
    [agent] Confirm passkey 630333 (yes/no): yes

    [Piers's iPad]# trust
    [CHG] Device E0:F5:C6:07:55:B3 Trusted: yes
    Changing  trust succeeded

    [Piers's iPad]#

okay, pairing good...
but no audio servie
i'm rebooting as unsure if modules good
yep, how we're good!


Ruby
-----------

rbenv
`$ sudo apt-get install rbenv`

rbenv plugin: ruby-build
`$ sudo apt-get install ruby-build`

that worked
i should note.. rbenv was v1.0.0
and ruby-build had MRI latest of... 2.4.0! :O
i think debian 10 is around the corner...

install ruby
` $ rbenv install 2.4.0`

worked

don't forget setting up rbenv with shell

    $ rbenv init
    $ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    $ source ~/.bashrc

check ruby version is good

    $ which ruby
    /home/pi/.rbenv/shims/ruby

    $ ruby -v
    ruby 2.4.0p0 (2016-12-24 revision 57164) [armv7l-linux-eabihf]

get [bundler](https://bundler.io)

    $ gem install bundler


Ruby ZeroMQ
----------

Okay, despite all that, the rbzmc gem will encounter an extention install failure

    $ cd ~/Wolfgang
    $ gem instll rbczmq

We're going to need to download, and modify the gem extention build scripts to get the win.


To begin, there are multiple build dependencies...

    $ sudo apt-get libtool

    # https://github.com/methodmissing/rbczmq/issues/36
    $ sudo apt-get install autogen

    # https://askubuntu.com/questions/625523/libtool-installed-but-not-on-path-after-installation
    $ sudo apt-get install libtool-bin

    $ sudo apt-get install autoconf automake

    # Cut to the chase
    $ sudo apt-get install libtool libtool-bin autogen automake

#### Edit the gem source


    $ gem env | grep -i 'INSTALLATION DIRECTORY'
    - INSTALLATION DIRECTORY: /home/pi/.rbenv/versions/2.4.0/lib/ruby/gems/2.4.0

    $ cd /home/pi/.rbenv/versions/2.4.0/lib/ruby/gems/2.4.0

    $ gem fetch rbczmq
    Fetching: rbczmq-1.7.9.gem (100%)
    Downloaded rbczmq-1.7.9

    $ gem unpack rbczmq-1.7.9.gem
    Unpacked gem: '/home/pi/.rbenv/versions/2.4.0/lib/ruby/gems/2.4.0/gems/rbczmq-1.7.9'

    $ cd rbczmq-1.7.9

Look for the build flags...

    $ grep -r -n '\-Wall *                                                                                             
    ext/zeromq/CMakeLists.txt:101......

Edit the build files to remove error flags

    $ nano ext/rbczmq/extconf.rb
    $ nano ext/czmq/configure.ac
    $ nano ext/czmq/Makefile
    $ nano ext/czmq/src/Makefile

#### Build gem from source

First we'll need `rake-compiler`

    $ gem install rake-compiler

Generate the MakeFile. This will take a while, and will pump out feedback..

    $ ruby ext/rbczmq/extconf.rb

Compile

    make ext/rbczmq/Makefile

Generate the gem specification. https://guides.rubygems.org/command-reference/#gem-install

    # From unpacked gem root:
    $ gem spec ../../cache/rbczmq-1.7.9.gem > ../../specifications/rbczmq-1.7.9.gemspec




build will fail

edit GEM_PATH/ext/rbczmq/extconf.rb
remove -Wall, and -Wextra to avoid deprecation warnings

you need to compile locally as gem install will downloa and re-unpack the soruce
gem install make-compiler
cd GEM_ROOT
$ rake


fuck.... that shit is all over the place
i'm just:
$ grep '\-W' *
and deleting everything i can find

----

In the end i...
- fetched and unpacked the gem.
- manually built and installed libzmq and czmq
- added `/usr/local/lib` to `ldconfig`
- verified libraries via `pry` and `mkmf#have_library`
- gem install rbczmq = win
----

useful commands:

sudo service bluetooth status|stop
sudo bluetoothctl

$ alias ll="ls -lah"
