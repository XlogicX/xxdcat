xxdcat
======

This is another one of my "solutions" to an obscure problem.

Sometimes I'm forced to use windows. It appalls me that there's no baked in tool like xxd (hex dump tool on most Linux distributions). This is for the situation where you're on windows, you don't have a hex viewer, you don't want to (or can't) install a 3rd party one, and for some reason you do actually have a windows implementation of perl (Active-state or Strawberry, etc...), in my case, strawberry.

This is a simple perl script that reads a file and outputs a hex dump. 16 bytes at a time, in the format of
Address   HEX   ASCII

The syntax of the command is:
perl xxdcat.pl BinaryFileToDump.exe

If anyone wants to see more features, let me know. Otherwise, it makes sense to keep this simple, otherwise, it would feel more like just another 3rd party app, when it is supposed to just be a stupid perl hack.

Of course, if there are bugs, let me know, bugs always suck
