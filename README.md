# Linux Setup Guide (Arch/CachyOS with i3wm)

## Initial System Setup

### Disable Mouse Acceleration
```bash
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo nano /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
```
Paste:
```conf
Section "InputClass"
    Identifier "My Mouse"
    MatchIsPointer "on"
    MatchDriver "libinput"
    Option "AccelProfile" "flat"
    Option "AccelSpeed" "0"
EndSection
```
Then reboot.

## Install & Use AUR Helper (`yay`)
```bash
which yay  # Check if yay is already installed

# If not installed:
sudo pacman -S --needed git base-devel
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Useful AUR Packages

- VS Code (Official Microsoft build)
  `yay -S visual-studio-code-bin`

- GOverlay (GUI for MangoHUD)
  `yay -S goverlay`

- EnvyControl (Switch GPU modes)
  `yay -S envycontrol`

## i3wm Configuration

### i3status (basic bar info)
```bash
mkdir -p ~/.config/i3status
cp /etc/i3status.conf ~/.config/i3status/config
code ~/.config/i3status/config
```

### Polybar (recommended)
```bash
sudo pacman -S polybar
```
Add to `~/.config/i3/config`:
```conf
bar {
    status_command polybar
}
```

## Performance & Power

- TLP (Power Management)
  ```bash
  sudo pacman -S tlp
  code /etc/tlp.conf
  ```

- Set Display Refresh Rate
  ```bash
  sudo pacman -S xorg-xrandr
  xrandr --output DP-2 --mode 1920x1080 --rate 144
  ```

  Make persistent:
  ```bash
  nano ~/.bash_profile
  # Add at end:
  xrandr --output DP-2 --mode 1920x1080 --rate 144
  ```

## GPU Switching
```bash
envycontrol --switch nvidia  # Switch to dGPU
envycontrol --switch hybrid  # Switch to iGPU
```

## Audio & Bluetooth

```bash
sudo pacman -S pavucontrol blueman
sudo systemctl start bluetooth
```

Launch GUI tools:
- Audio: `pavucontrol`
- Bluetooth: `blueman-manager`

## Wallpaper Setup
```bash
sudo pacman -S feh
feh --bg-scale /home/vishy/Pictures/wallpapers/your_wall.jpg
```

Add to i3 config:
```conf
exec --no-startup-id feh --bg-scale /home/vishy/Pictures/wallpapers/your_wall.jpg
```

## Compositor Setup (Picom)

```bash
mkdir -p ~/.config/picom
touch ~/.config/picom/picom.conf
```

Add shortcuts to `~/.config/i3/config`:
```conf
# Start Picom
bindsym $mod+Ctrl+p exec --no-startup-id picom --config ~/.config/picom/picom.conf -b

# Kill Picom
bindsym $mod+Shift+p exec --no-startup-id pkill -x picom
```

## Gaming Setup

- Steam
  ```bash
  sudo pacman -Sy steam
  sudo pacman -S nvidia-settings  # If using Nvidia GPU
  ```

- MangoHUD
  ```bash
  sudo pacman -S mangohud
  ```

- Launch options (CS2 example):
  ```bash
  mangohud __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1 __GL_THREADED_OPTIMIZATIONS=1 LD_PRELOAD="" %command%
  ```

## CPU Temperature Monitoring Script

```bash
mkdir -p ~/bin
nano ~/bin/tctl_temp.sh
```

Script:
```bash
#!/bin/bash
temp=$(sensors | awk '/k10temp-pci-00c3/{flag=1} flag && /Tctl/ {print $2; exit}')
if [ -n "$temp" ]; then
    echo "Tctl: $temp"
else
    echo "Tctl: N/A"
fi
```

Make executable:
```bash
chmod +x ~/bin/tctl_temp.sh
```

## Miscellaneous

- Enable multilib repo
  ```bash
  sudo nano /etc/pacman.conf
  ```
  → Uncomment `[multilib]` and its `Include` line.
