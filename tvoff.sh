#!/bin/bash
/home/pi/tvoff.py
echo standby 0 | cec-client -s -d 1
fbset -accel false
tvservice -o
