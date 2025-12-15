#!/bin/bash

cd ..
# Links the configs to /home/.config directory, in case of conflict, try --adopt to override
stow -S config -t $HOME/.config -v

