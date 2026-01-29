# Risk of Rice
## Also known as Risky Rice
*A [Risk of Rain Returns](https://store.steampowered.com/app/1337520/Risk_of_Rain_Returns/)-themed rice!*

# Screenshots
![](https://github.com/user-attachments/assets/a519a129-13b4-477a-a976-11198f266f6b)
![](https://github.com/user-attachments/assets/8e72b925-cfff-497f-ade2-d9598aab9b92)
![](https://github.com/user-attachments/assets/9966e02f-8ea4-4e49-b5eb-6a42c991877f)
![](https://github.com/user-attachments/assets/cd40dc99-61de-44a7-b212-2f10201fd2a2)
(cant take screenshots while screen is locked sorry)

# [Demo Video](https://github.com/user-attachments/assets/cb87dac7-d57b-48d6-9fd5-ec2bb34f0dcf)

# Bar
- Made specifically for Hyprland
- Made with [Quickshell](https://quickshell.org/)
- Integration with Spotify (and all other music players via [playerctl](https://github.com/altdesktop/playerctl))
- Shows active workspace
  - Shows active window
- Semi-customizable clock
- Shows basic info
  - Battery percentage
  - Wifi info
  - Connected bluetooth devices
  - Sound status
- Power profiles
- Integration with my favourite TUI apps :)
  - [impala](https://github.com/pythops/impala) for Wifi
  - [bluetui](https://github.com/pythops/bluetui) for Bluetooth
  - [pulsemixer](https://github.com/GeorgeFilipkin/pulsemixer) for Sound settings
- Changing wallpapers


# Hyprland Ecosystem
- Custom [hyprtoolkit](https://wiki.hypr.land/Hypr-Ecosystem/hyprtoolkit/) theme (for [hyprlauncher](https://wiki.hypr.land/Hypr-Ecosystem/hyprlauncher/))
- [hypridle](https://wiki.hypr.land/Hypr-Ecosystem/hypridle/)
- [hyprlock](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/), with a custom config
- [hyprpaper](https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/), there are 11 wallpapers in the project by default, feel free to add more to `~/.local/share/Risk-Of-Rice/wallpapers`
- [hyprshot](https://github.com/Gustash/Hyprshot) for screenshots
- [hyprpicker](https://wiki.hypr.land/Hypr-Ecosystem/hyprpicker/) for color picker



# Command Line
- [Ghostty](https://ghostty.org/) as main terminal
- My favourite CLI apps :D
  - [pacsea](https://github.com/Firstp1ck/Pacsea) (this is literally the best arch package manager tui thing ever)
  - [fish](https://fishshell.com/), really cool shell, with a `config.fish` included
  - [starship](https://starship.rs/) for better shell prompts
  - [lazygit](https://github.com/jesseduffield/lazygit) for literally the only way i can ever use git now
  - [**yazi**](https://yazi-rs.github.io/) since its a filemanager and also since it sounds like the enby version of yuri
  - [helix](https://helix-editor.com/) as the default text editor (sorry vim cultists)


# Other Apps
- [Spotify](https://spotify.com/) with [Spicetify](https://spicetify.app/) (note: you'll have to run the Spicetify install script yourself)
- [Zen Browser](https://zen-browser.app/)


# Installation
> [!WARNING]
> PLEASE BACK UP YOUR FILES BEFORE RUNNING THE SCRIPT PLEEEEEEEEEEEEEEEEEASE


> [!WARNING]
> PLEEEEEEEEEEASE READ THE [INSTALL SCRIPT](install.sh) BEFORE RUNNING IT


> [!WARNING]
> THIS HAS ONLY BEEN TESTED ON A FRESH INSTALL OF ARCH IT MIGHT SERIOUSLY FUCK UP YOUR EXISTING SETUP

> [!INFO]
> You need to have a fresh install of Arch linux

1. Clone the repo
```sh
git clone https://github.com/Shuflduf/Risk-Of-Rice.git 
```
2. `cd` into the repo
```sh
cd Risk-Of-Rice
```
3. Make the script executable
```sh
chmod +x install.sh
```
3. Run the script and follow all the prompts to install! You will be asked to enter your `sudo` password a couple times
```sh
./install.sh
```
4. Reboot and enjoy your meal!
```sh
sudo reboot
```

# Credits
- I ripped [RZPix](rzpix.ttf) from the game files, its owned by Hopoo Games (or gearbox idc)
- I'm not affiliated with Risk of Rain Returns, or its developer, Hopoo Games (or gearbox idc)
