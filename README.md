NixOS

```
sudo nixos-rebuild switch --flake .#<vm | laptop-hp>
```

Home Manager
```
home-manager switch --flake .#marc@<vm | laptop-hp>
```

Repair:
```
sudo nix-store --verify --check-contents --repair
```

Formatting:
```
treefmt .
```