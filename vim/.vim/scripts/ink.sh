#!/bin/bash

# Taken from https://ericchapdelaine.com/articles/how-i-take-notes

# $1 - the class name
# $2 - the image name

# Get where the image is going to be
IMAGEPATH=~/Projects/site/static/$1/$2

# Copy the template file into the correct directory
cp ~/.config/inkscape-shortcut-manager/template.svg $IMAGEPATH.svg

# Run Castel's inkscape-shortcut-manager and save its process ID
python3 ~/.config/inkscape-shortcut-manager/main.py & echo "$!" > /tmp/ink.pid

# Run inkscape
inkscape $IMAGEPATH.svg

# Wait until inkscape is closed
while pgrep -u $UID -x inkscape >/dev/null; do sleep 1; done
killall xclip

# Convert the created svg file to a png
# inkscape --export-png=$IMAGEPATH.png --export-dpi=1000 $IMAGEPATH.svg 

# Replace all the black lines with white and vice versa
# https://stackoverflow.com/a/26568996/9512643
# ~~ used as a temp character
sed -e "s/#000000/~~/g; s/#ffffff/#000000/g; s/~~/#ffffff/g; s/white/~~/g; s/black/white/g; s/~~/black/g" $IMAGEPATH.svg > ${IMAGEPATH}_dark.svg

# Kill inkscape-shortcut-manager
kill -9 $(cat /tmp/ink.pid) > /dev/null

# Remove temporary file used to hold process ID
rm /tmp/ink.pid
