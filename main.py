from pathlib import Path
import json

ext_file = Path("/home/neyakki/.vscode/extensions/extensions.json")

with ext_file.open("r") as ext:
    ext = json.load(ext)

    for e in ext:
        print(e["relativeLocation"])
