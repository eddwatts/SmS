#!/usr/bin/env python
from gpiozero import Button
from gpiozero import LED
from subprocess import check_call
from signal import pause
import time
relay = LED(27)
relay.on()
check_call(['sudo', 'echo on 0 | cec-client -s -d 1'])
check_call(['sudo', 'tvservice -p'])
check_call(['sudo', 'fbset -accel true'])
