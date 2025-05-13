#!/usr/bin/bash

VSIX_PATH=$PWD/vsix
cd $1 && npx @vscode/vsce package --allow-missing-repository --skip-license -o "$VSIX_PATH/$1.vsix"