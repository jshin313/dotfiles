#!/usr/bin/python3

# Taken from https://ericchapdelaine.com/articles/how-i-take-notes

import subprocess
import sys
import os

if __name__ == "__main__":
    classname = sys.argv[1]
    filename = sys.argv[2]

    scriptpath = os.path.expanduser('~/.vim/scripts/ink.sh')
    subprocess.run([scriptpath, classname, filename], capture_output=True)

    output = f"""<div style='width: 100%' class='ui rounded images'>
<img class='ui image' src='/{classname}/{filename}.svg'>
</div>
"""

    print(output)
