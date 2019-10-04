#!/bin/bash
tvservice -p
fbset -accel true
echo on 0 | cec-client -s -d 1
/home/pi/tvon.py
