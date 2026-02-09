# NixOS_Config

#### NixOS + Sway config for ThinkPad

#### Motives for using NixOS
1. Version control
2. Reproducibility of the system

### Structure
- `configuration.nix` — Main system configuration (Sway, SDDM, packages, services)
- `home.nix` — Home Manager user configuration (Git, cursor theme)

### TODO
- [x] Add Home Manager config
- [ ] Add flakes for system
