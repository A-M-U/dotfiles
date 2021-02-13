Clone this repo to ~/dotfiles otherwise the created symlinks will not work.

# Font
Powerline10K theme requires a Nerd Font to repesent all characters. Powerline10K recommands "MesloLGS NF"
https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
 
# WSL

### Multiple instances of the same distro
Distros installed from the MS Store can only be installed once. To install multiple instances of the same distro use export/import feature of wsl.

1. Install distro from store. Export the bare distro to a location (e.g. C:/wsl/images/distroname-bare). This way every imported distro has the same user.
2. (optional) Install used tools and export the distro again. (e.g. C:/wsl/images/distroname-minimal)
3. Unregister the installed distro from the ms store. This way it is possible to install the distro anytime again.
3. Import a distro from the created images and change the deault user.

### Set default user for distro
In /etc/wsl.conf
> [user]
> default=username
