#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from pwn import *

address = "8.8.8.8"
port = 1337

{bindings}

context.binary = {bin_name}
context.terminal = ["tmux", "splitw", "-h"]

# Many built-in settings can be controlled on the command-line and show up
# in "args".  For example, to dump all data sent/received, and disable ASLR
# for all created processes...
# ./exploit.py DEBUG NOASLR

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.REMOTE:
        return remote(address, port)
    else:
        conn = process({proc_args})
        if args.GDB:
            gdb.attach(conn, gdbscript=gdbscript)
        return conn

# Specify your GDB script here for debugging
# GDB will be launched if the exploit is run via e.g.
# ./exploit.py GDB
gdbscript = '''
continue
'''.format(**locals())

#===========================================================
#                    EXPLOIT GOES HERE
#===========================================================

p = start()

p.interactive()
