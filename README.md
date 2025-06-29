# NixOS-Config
Configuration for NixOS

## Update flake inputs and dependencies
```bash
nix-flake-update
```
Should be run before [updating packages](#update-packages)

## Update packages
```bash
nixos-rebuild switch --sudo --upgrade --flake ./hosts#{host}
```
If there is nom just add
```
|& sudo nom 
```
at the end. 

## Note of what to do when boot drive is full
This may happens occasionally when you forget to remove the older generations. This errors may occurs when you Grub try to update but does not have enough disk space. In this case, run the following commands to clean up your computer:

1. List to see the current list of generations
```bash
sudo nix-env --list-generations -p /nix/var/nix/profiles/system
```
or 
```bash
nixos-rebuild list-generations
```

2. Remove older generations, remember to `--dryrun -v` first:
```bash
sudo nix-env --delete-generations +5 -p /nix/var/nix/profiles/system --dry-run -v
```
After confirming that everything is okay, run:
```bash
sudo nix-env --delete-generations +5 -p /nix/var/nix/profiles/system -v
```

3. Collect garbage:
```bash
nix-store --gc
```
or
```bash
nix-collect-garbage --delete-older-than 30d
```

4. Optimize nix store
```bash
nix-store --optimize
```

5. If step 4 did not complete the task then you will need to go to `/boot/kernals` folder and start removing the oldest files. Retry `nixos-rebuild {switch|build}` after every `rm`, the system should auto clean up the remaining old kernal files after everything is done.  