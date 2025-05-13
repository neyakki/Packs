#!/usr/bin/env python3
from pathlib import Path
import json

ext_file = Path.home() / Path(".vscode/extensions/extensions.json")

with ext_file.open("r") as ext:
    ext = json.load(ext)

    for e in ext:
        print(f"{e["identifier"]["id"]}: v{e["version"]}")
