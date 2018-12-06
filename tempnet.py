#!/usr/bin/env python3

import os
import requests
import glob
import time

os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')

base_dir = '/sys/bus/w1/devices/'
try:
  device_folder = glob.glob(base_dir + '28*')[0]
  device_file = device_folder + '/w1_slave'
except:
  print("no temp sensor")
  
def read_temp_raw():
  f = open(device_file, 'r')
  lines = f.readlines()
  f.close()
  return lines

def read_temp():
  lines = read_temp_raw()
  while lines[0].strip()[-3:] != 'YES':
    time.sleep(0.2)
    lines = read_temp_raw()
  equals_pos = lines[1].find('t=')
  if equals_pos != -1:
    temp_string = lines[1][equals_pos+2:]
    temp_c = float(temp_string) / 1000.0
    return temp_c

def getmac():
  try:
    mac = open('/sys/class/net/eth0/address').readline()
  except:
    try:
      mac = open('/sys/class/net/wlan0/address').readline()
    except:
      mac = "00:00:00:00:00:00"
  return mac[0:17].replace(":","").upper() 

print(getmac())
#print(read_temp())
link ="https://www.smsportals.co.uk/newtemp.php?mac="+getmac()+"&tempc=20.1"
f = requests.get(link)
print(link)
print(f.text)
