# main.py -- put your code here!
from micropyGPS import MicropyGPS
from machine import UART
from machine import I2C
import bme280,ssd1306
import ubinascii
import struct
import time
from network import LoRa
import socket
import config
import tools
import pycom

i2c = I2C(0, I2C.MASTER, baudrate=100000)

bme = bme280.BME280(i2c=i2c,address=0x76)
temp,pa,hum = bme.values
print(temp)
"""oled_width = 128
oled_height = 64
oled = ssd1306.SSD1306_I2C(oled_width, oled_height, i2c)
oled.text(temp,0,0)
oled.show()
"""

DEBUG = config.DEBUG

speed = config.AUTO
update = config.UPDATE[speed] # seconds between update


# Initialize GPS
com = UART(1,pins=("P3", "P4"),  baudrate=9600)
my_gps = MicropyGPS()


# Initialize LoRa in LORAWAN mode.
lora = LoRa(mode=LoRa.LORAWAN, region=LoRa.EU868)

# create an ABP authentication params
dev_addr = struct.unpack(">l", ubinascii.unhexlify('26011A7E'))[0]
nwk_swkey = ubinascii.unhexlify('089BC619B84C990B7376100A95BE2FA1')
app_swkey = ubinascii.unhexlify('BF204BC9EDA83A370A8548345A68F0A0')

# join a network using ABP (Activation By Personalization)
lora.join(activation=LoRa.ABP, auth=(dev_addr, nwk_swkey, app_swkey))

# remove all the non-default channels
for i in range(3, 16):
    lora.remove_channel(i)

# set the 3 default channels to the same frequency
lora.add_channel(0, frequency=868100000, dr_min=0, dr_max=5)
lora.add_channel(1, frequency=868100000, dr_min=0, dr_max=5)
lora.add_channel(2, frequency=868100000, dr_min=0, dr_max=5)

# create a LoRa socket
s = socket.socket(socket.AF_LORA, socket.SOCK_RAW)

# set the LoRaWAN data rate
s.setsockopt(socket.SOL_LORA, socket.SO_DR, 5)

# make the socket blocking
s.setblocking(False)


# set the socket port
if DEBUG==1:
    s.bind(config.TTN_FPort_debug)
else:
    s.bing(config.TTN_FPort)

while True:
    if my_gps.fix_stat > 0 and my_gps.latitude[0] > 0:
        pass #pycom.rgbled(0x007f700) # green
    if com.any():
        my_sentence = com.readline()
        for x in my_sentence:
            my_gps.update(chr(x))

        if  DEBUG == 1:
            print('Longitude', my_gps.longitude);
            print('Latitude', my_gps.latitude);
            print('UTC Timestamp:', my_gps.timestamp);
            print('Fix Status:', my_gps.fix_stat);
            print('Altitude:', my_gps.altitude);
            print('Horizontal Dilution of Precision:', my_gps.hdop)
            print('Satellites in Use by Receiver:', my_gps.satellites_in_use)
            print('Speed in km/hour:', int(my_gps.speed[2]))

        if (my_gps.fix_stat > 0 and my_gps.latitude[0] > 0):
            temp,pa,hum = bme.values
            t=float(temp[:-1])
            gps_array = tools.convert_latlon(my_gps.latitude[0] + (my_gps.latitude[1] / 60), my_gps.longitude[0] + (my_gps.longitude[1] / 60), my_gps.altitude, my_gps.hdop,t)
            print(gps_array)
            s.send(gps_array)
            s.settimeout(3.0) # configure a timeout value of 3 seconds
            
        time.sleep(10)

