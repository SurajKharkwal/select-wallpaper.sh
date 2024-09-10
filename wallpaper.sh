#!/bin/bash

# Directory containing static wallpapers
static_wallpaper_dir="/home/flying_hawk/wallpaper/static"

# List static wallpapers in the directory
static_wallpapers=($(find "$static_wallpaper_dir" -type f \( -name "*.jpg" -o -name "*.png" \)))

# If there are no wallpapers, exit
if [ ${#static_wallpapers[@]} -eq 0 ]; then
    echo "No static wallpapers found."
    exit 1
fi

# Add "Exit" option
static_wallpapers+=("Exit")

# Show menu with wofi
selected=$(printf "%s\n" "${static_wallpapers[@]}" | wofi --dmenu --prompt "Select Static Wallpaper:")

# Handle selection
if [ "$selected" = "Exit" ]; then
    exit
fi

# Set the selected wallpaper
swww img "$selected"
