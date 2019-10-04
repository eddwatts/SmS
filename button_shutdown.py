#!/usr/bin/env python
from gpiozero import Button
from gpiozero import LED
from subprocess import check_call
from signal import pause
import time

held_for=0.0
relay = LED(27)
relay.on()

def rls():
        global held_for
        print("released!")
        print("released after", held_for, "seconds.")
        # example code showing what to do with this time
        if (held_for > 15.0):
                check_call(['sudo', 'poweroff'])
        if (held_for > 10.0):
                check_call(['sudo', 'reboot'])
        elif (held_for > 5.0):
                if not relay.is_lit:
                        check_call(['sudo', 'echo on 0 | cec-client -s -d 1'])
                        relay.on()
                        check_call(['sudo', 'tvservice -p'])
                        check_call(['sudo', 'fbset -accel true'])
                else:
                        check_call(['sudo', 'echo standby 0 | cec-client -s -d 1'])
                        relay.off()
                        check_call(['sudo', 'fbset -accel false'])
                        check_call(['sudo', 'tvservice -o'])
        elif (held_for > 1.0):
                if not relay.is_lit:
                        check_call(['sudo', 'echo on 0 | cec-client -s -d 1'])
                        relay.on()
                        check_call(['sudo', 'tvservice -p'])
                        check_call(['sudo', 'fbset -accel true'])
                        time.sleep(60)
                        check_call(['sudo', 'echo standby 0 | cec-client -s -d 1'])
                        relay.off()
                        check_call(['sudo', 'fbset -accel true'])
                        check_call(['sudo', 'tvservice -o'])                        
        else:
                print("I'm not going to do anything now ...")
                held_for = 0.0

def hld():
        # callback for when button is held
        #  is called every hold_time seconds
        global held_for
        # need to use max() as held_time resets to zero on last callback
        held_for = max(held_for, button.held_time + button.hold_time)
        print("held for", held_for, "seconds.")

button=Button(17, hold_time=1.0, hold_repeat=True)
button.when_held = hld
button.when_released = rls

pause()
