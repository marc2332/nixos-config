VM:

```
sudo nixos-rebuild switch --flake .#vm
```

HP Laptop:

```
sudo nixos-rebuild switch --flake .#laptop-hp
```

Repair:
```
sudo nix-store --verify --check-contents --repair
```
