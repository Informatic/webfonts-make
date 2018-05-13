webfonts-make
=============

Quick and simple webfonts builder for Linux based on GNU Make.

Requirements
------------

    apt install fontforge-nox eot-utils woff-tools

Usage
-----

    make INPUT=somefont.ttf OUTPUT=optionaloutput

`${OUTPUT}/somefont.*` files will be created (including `somefont.css` with
proper `@font-family` definition) - copy these to some public HTTP directory
and enojoy.

`make clean INPUT=...` removes `somefont.*` files from output directory.
