# arch installer
I just want to make clear that this is by no means perfect, it's just a little project I started working on because it seemed quite fun. There was a lot of trial and error involved to get it working but it's complete and hopefully it can help some people or they at least find it interesting. It installs arch along with the gnome desktop environment, adds a regular user and all that good stuff. I should say that it configures the system to slovak timezone and slovak locale (along with the US one) but you can change the timezone easily in the gui. 

# HOW TO USE
after booting into your installation thing execute these commands:
´´´
$ pacman -Sy
$ pacman -S git
$ git clone http://github.com/5h4d/arch.git
$ cd arch
$ chmod +x install.sh
$ ./install.sh
´´´

then follow the instructions and you should be all good
