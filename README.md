# Introduction

This is my personal dotfiles for arch linux - Goruda Hyprland.
I'm focused on web-development and software development.

# Installation

## Step 1: Clone the Repository

First, clone the repository into your project folder:

```bash
git clone https://github.com/imranhrafi/dotfiles.git
cd dotfiles
```

## Step 2: Make Scripts Executable

Make the `scripts/t` and `install.sh` files executable by running the following commands:

```bash
chmod +x install.sh scripts/t software.sh symlink.sh
```

## Step 3: Update Script Paths

Update the `scripts/t` file to point to the project's directory where all of the project files are located.

## Download the necessary software using the following command:

```bash
./software.sh
```

## Step 4: Run the Installation Script

Finally, execute the installation script:

```bash
./install.sh
```
