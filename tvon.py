#!/usr/bin/env python
from gpiozero import Button
from gpiozero import LED
from subprocess import check_call
from signal import pause
import time
relay = LED(27)
relay.on()
