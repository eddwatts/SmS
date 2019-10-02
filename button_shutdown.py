from gpiozero import Button
from gpiozero import LED
from subprocess import check_call
from signal import pause
import time

relay = LED(27)

def shutdown():
    check_call(['sudo', 'poweroff'])

def screenon();
    if not relay.is_lit:
        check_call(['sudo', 'echo on 0 | cec-client -s -d 1'])
        relay.on()
        time.sleep(60)
        check_call(['sudo', 'echo standby 0 | cec-client -s -d 1'])
        relay.off()

def screentog();
    relay.toggle()
    
shutdown_btn = Button(17, hold_time=15)
shutdown_btn.when_held = shutdown

screentog_btn = Button(17, hold_time=5)
screentog_btn.when_held = screentog

screenon_btn = Button(17, hold_time=2)
screenon_btn.when_held = screenon

pause()
