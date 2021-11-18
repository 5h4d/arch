# THIS PROGRAM IS NO LONGER MAINTAINED!
# I MIGHT COME BACK TO IT BUT CURRENTLY I REMEMBER THERE BEING SOME ISSUES SO IT'S NOT IN A WORKING CONDITION RIGHT NOW
# IT HAS ALSO KIND OF BEEN DEPRECATED BY THE INCLUDED INSTALLER SO GOING FORWARD IF I'M GOING TO MAINTAIN IT, IT WILL BE CATERED SPECIFICALLY FOR MY PERSONAL USE
# PROBABLY
# arch installer
I just want to make clear that this is by no means perfect, it's just a little project I started working on because it seemed quite fun. There was a lot of trial and error involved to get it working but it's complete and hopefully it can help some people or they at least find it interesting. It installs arch along with the gnome desktop environment, adds a regular user and all that good stuff. I should say that since I live in slovakia I made it to configure the system to slovak timezone and slovak locale (along with the US one) but you can change the timezone easily in the gui. I should also note that this script works with efi machines only so if you're using an older machine with legacy BIOS then look elsewhere. On my VM it took about 13 minutes to install everything (including the gui programs) so I think that's really nice.

# HOW TO USE
after booting into your installation drive and connecting to the internet, execute these commands:
```
pacman -Sy git
git clone http://github.com/5h4d/arch.git
cd arch
chmod +x install.sh
./install.sh
```

then follow the instructions and you should be all good

After the system is installed and you boot into gnome, you can choose to install Discord, Steam, Wine, Lutris, Brave, qBitTorrent, GParted, java and some gnome extensions by running ./gui-programs.sh and following instructions. (Lutris will be configured for AMD)

You should also run ./snapper-config.sh to configure automatic snapshots


Thread for the discord recorder thing: https://www.reddit.com/r/discordapp/comments/f22vz6/guide_how_to_stream_audio_to_discord_on_linux/
