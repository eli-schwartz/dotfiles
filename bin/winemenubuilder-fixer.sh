#!/bin/sh

# Fix already existing wineprefixes.
for wineprefix in ~/.wine ~/.local/share/wineprefixes/*/; do
    sed -i 's/winemenubuilder.exe -a -r/winemenubuilder.exe -r/g' $wineprefix/system.reg
done
# Set the default system.reg
sudo sed -i 's/winemenubuilder.exe -a -r/winemenubuilder.exe -r/g' /usr/share/wine/wine.inf
