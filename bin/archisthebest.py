#!/usr/bin/python

from __future__ import print_function

import signal
import sys

if sys.version_info[0] == 3:
    raw_input = input
prompt = "Arch is the best!\nDo you agree? (y/n): "
# This is an enum in Python 3 only
sigmap = dict((k, v) for v, k in reversed(sorted(signal.__dict__.items()))
             if v.startswith('SIG') and not v.startswith('SIG_'))
catchable_sigs = set(sigmap.keys()) - {signal.SIGKILL, signal.SIGSTOP}

def signal_handler(signal, frame):
    print("\n\033[31mYou are not allowed to escape the question!\033[0m\n")
    print(prompt, end='')

def arch_is_the_best():
    ans = ''
    while ans != 'y' :
        ans = raw_input(prompt).lower()
        if ans == 'n' :
            print("Maybe you should reconsider your opinion.\n")
        elif ans != 'y' :
            print("There are only two possible answers and this is none of them.\n")


# Trap *all* the signals...
for sig in catchable_sigs:
    signal.signal(sig, signal_handler)

arch_is_the_best()
print("Glad you agree!")
