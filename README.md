# systems-dotfiles

A collection of dotfiles and setup scripts for Arch Linux, optimized for i3 and Hyprland environments.

## Repository Structure

- `arch/`: Core configuration files for various applications (i3, Hyprland, Neovim, Kitty, Picom, Polybar, Rofi, Dunst, Spicetify, i3lock).
- `pkglist/`: 
    - `pacman.txt`: Official Arch Linux packages.
    - `aur.txt`: AUR packages managed by `yay`.
- `scripts/`: Implementation scripts for system setup.

## Setup Instructions

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/Zakariya-Zahid/systems-dotfiles
    cd systems-dotfiles
    ```

2.  **Run the setup script**:
    ```bash
    chmod +x scripts/arch-setup-i3.sh
    ./scripts/arch-setup-i3.sh
    ```

## Recommendations for Maintenance

- **Adding new configs**: Place them in `arch/[folder]` and update the `CONFIG_FOLDERS` array in `scripts/arch-setup-i3.sh`.
- **Updating packages**: Keep `pkglist/pacman.txt` and `pkglist/aur.txt` updated with your latest changes.
- **Portability**: For managing more complex or multi-OS environments, consider migrating to `GNU Stow` or `chezmoi`.

