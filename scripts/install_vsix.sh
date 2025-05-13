#!/usr/bin/bash

for i in $PWD/vsix/*; do code --install-extension $i; done