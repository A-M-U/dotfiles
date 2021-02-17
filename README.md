Clone this repo to ~/dotfiles otherwise the created symlinks will not work.

# Font
Powerline10K theme requires a Nerd Font to repesent all characters. Powerline10K recommands "MesloLGS NF"
https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
 
# WSL

### Multiple instances of the same distro
Distros installed from the MS Store can only be installed once. To install multiple instances of the same distro use export/import feature of wsl.

1. Install distro from store.
2. Create `/etc/wsl.conf`
3. Export the bare distro to a location (e.g. C:/wsl/images/distroname-bare). This way every imported distro has the same user.
4. (optional) Install used tools and export the distro again. (e.g. C:/wsl/images/distroname-minimal)
5. Unregister the installed distro from the ms store. This way it is possible to install the distro anytime again.
6. Import a distro from the created images and change the deault user.

### WSL config setting for distro
In /etc/wsl.conf
```
[user]
default=username

[automount]
enabled = true
```
# Docker
Run this config in a docker container and bind pwd to /code. This command is available as alias `docker-dev-env`.
```docker
docker run -it --mount type=bind,source="$(pwd)",target=/code alexmu/dev-env
```
