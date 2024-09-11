#!/bin/bash

wallpaper_root="/home/flying_hawk/Downloads/wallpaper"  # Folder containing wallpapers

# Find all wallpapers in the directory with specified file types
wallpapers=($(find "$wallpaper_root" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.pnm" -o -name "*.tga" -o -name "*.tiff" -o -name "*.webp" -o -name "*.bmp" -o -name "*.farbfeld" \)))

# Check if wallpapers were found
if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "No wallpapers found."
    exit 1
fi

# Extract just the filenames and add "Exit" option
filenames=()
for wallpaper in "${wallpapers[@]}"; do
    filenames+=("$(basename "$wallpaper")")
done
filenames+=("Exit")

# Display the wallpapers using wofi for selection
selected=$(printf "%s\n" "${filenames[@]}" | wofi --dmenu --prompt "Select Wallpaper: ")

# If the user selects "Exit", exit the script
if [ "$selected" = "Exit" ]; then
    exit
fi

# Find the full path of the selected wallpaper and set it using swww
selected_path=$(find "$wallpaper_root" -type f -name "$selected")
swww img "$selected_path"
