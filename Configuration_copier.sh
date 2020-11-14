#!/bin/bash
set -e
#### Copying all the settings from a Zip into the .config  folders
USERID=devk
unzip -o ConfigurationFiles.zip -d /home/$USERID/.config

