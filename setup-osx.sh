#!/bin/bash
cd "$(dirname "$0")"
mkdir -p "$HOME/Library/KeyBindings/"
cp 'DefaultKeyBinding.dict' "$HOME/Library/KeyBindings/"
cp 'U.S. International - Modified.keylayout' "$HOME/Library/Keyboard Layouts"
