#!/bin/bash
cd ~/DotFiles/misc/anime
(mpv `python3 getLink.py` & ) && exit
