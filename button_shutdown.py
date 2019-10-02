from gpiozero import Button
from subprocess import check_call
from signal import pause
import time

def shutdown():
    check_call(['sudo', 'poweroff'])

def screenon();
    check_call(['sudo', 'echo on 0 | cec-client -s -d 1'])
    time.sleep(60)
    check_call(['sudo', 'echo standby 0 | cec-client -s -d 1'])
    
shutdown_btn = Button(17, hold_time=10)
shutdown_btn.when_held = shutdown

screenon_btn = Button(17, hold_time=2)
screenon_btn.when_held = screenon

pause()
