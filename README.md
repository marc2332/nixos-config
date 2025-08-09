NixOS:
```
sudo nixos-rebuild switch --flake .#<vm | laptop-hp>

# or nh

nh os switch --hostname vm ./flake.nix
```

Home Manager:
```
home-manager switch --flake .#marc@<vm | laptop-hp>

# or nh

nh home switch ./flake.nix
```

Update packages:
```
sudo nix-channel --update
```

Repair:
```
sudo nix-store --verify --check-contents --repair
```

Clean:
```
sudo nix-collect-garbage -d
```

Formatting:
```
treefmt .
```