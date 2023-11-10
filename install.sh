#!/bin/bash

# Change to the directory where the script is located
cd "$(dirname "$0")"

# Define colors
COLOR_RESET="\e[0m"
COLOR_INFO="\e[47;30m"
COLOR_ERROR="\e[47;31m"

# Check if running as root
if [ "$(id -u)" -eq "0" ]; then
    echo -e "${COLOR_ERROR}Do not run this as root${COLOR_RESET}"
    exit
fi

# Install git and base-devel
echo -e "${COLOR_INFO}Installing git and base-devel${COLOR_RESET}"
sudo pacman -S git base-devel || { echo "${COLOR_ERROR}Failed to install git and base-devel${COLOR_RESET}"; exit 1; }

# Install yay
echo -e "${COLOR_INFO}Installing yay...${COLOR_RESET}"
git clone https://aur.archlinux.org/yay-git.git
cd yay-git/
makepkg -si || { echo "${COLOR_ERROR}Failed to install yay${COLOR_RESET}"; exit 1; }
cd ..

# Install required packages
echo -e "${COLOR_INFO}Installing required packages...${COLOR_RESET}"
yay -S hyprland kitty cava neofetch uwufetch ly waybar-hyprland hyprpaper swaylock-effects swayidle wofi wlogout mako thunar thunar-archive-plugin ttf-jetbrains-mono-nerd noto-fonts-emoji polkit-gnome python-requests starship swappy grim slurp pamixer gvfs bluez bluez-utils lxappearance xfce4-settings nwg-look-bin xdg-desktop-portal-hyprland noto-fonts-cjk noto-fonts-emoji noto-fonts wl-clipboard nano inotify-tools hyprpicker xdg-user-dirs flatpak || { echo "${COLOR_ERROR}Failed to install required packages${COLOR_RESET}"; exit 1; }

# Enable Flathub
echo -e "${COLOR_INFO}Enabling Flathub${COLOR_RESET}"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || { echo "${COLOR_ERROR}Failed to enable Flathub${COLOR_RESET}"; exit 1; }

# Enable ly
echo -e "${COLOR_INFO}Enabling ly...${COLOR_RESET}"
sudo systemctl enable ly || { echo "${COLOR_ERROR}Failed to enable ly${COLOR_RESET}"; exit 1; }

# Copy config files and bashrc
echo -e "${COLOR_INFO}Copying config files and bashrc...${COLOR_RESET}"
cp -f -r config/* ~/.config/ || { echo "${COLOR_ERROR}Failed to copy config files${COLOR_RESET}"; exit 1; }
cp -f bashrc ~/.bashrc || { echo "${COLOR_ERROR}Failed to copy bashrc${COLOR_RESET}"; exit 1; }

# Final message
echo -e "${COLOR_INFO}You can now restart your computer or manually start Hyprland via \"Hyprland\"${COLOR_RESET}"
echo -e "${COLOR_INFO}Enjoy your new system $USER!${COLOR_RESET}"
