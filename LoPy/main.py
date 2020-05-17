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

i2c = I2C(0, I2C.MASTER, baudrate=100000)

bme = bme280.BME280(i2c=i2c,address=0x76)
temp,pa,hum = bme.values
print(temp)
oled_width = 128
oled_height = 64
oled = ssd1306.SSD1306_I2C(oled_width, oled_height, i2c)
oled.text(temp,0,0)
oled.show()

# Initialize LoRa in LORAWAN mode.
lora = LoRa(mode=LoRa.LORAWAN, region=LoRa.EU868)

# create an ABP authentication params
dev_addr = struct.unpack(">l", ubinascii.unhexlify('26011398'))[0]
nwk_swkey = ubinascii.unhexlify('24A183425D2F3B3E41344E5C2776C4C2')
app_swkey = ubinascii.unhexlify('6E8CF83D7C62F2082FA022D8D9DA9FFA')

# join a network using ABP (Activation By Personalization)
lora.join(activation=LoRa.ABP, auth=(dev_addr, nwk_swkey, app_swkey))

# create a LoRa socket
s = socket.socket(socket.AF_LORA, socket.SOCK_RAW)

# set the LoRaWAN data rate
s.setsockopt(socket.SOL_LORA, socket.SO_DR, 5)


# make the socket blocking
# (waits for the data to be sent and for the 2 receive windows to expire)
s.setblocking(True)

s.send(bytes([0x01, 0x02, 0x03]))

s.setblocking(False)


# Initialize GPS
com = UART(1,pins=("P3", "P4"),  baudrate=9600)
my_gps = MicropyGPS()

def gg():
    if com.any():
        my_sentence = com.readline()
        for x in my_sentence:
            my_gps.update(chr(x))
        
        print('Longitude', my_gps.longitude)
        print('Latitude', my_gps.latitude)
        print('UTC Timestamp:', my_gps.timestamp)
        print('Fix Status:', my_gps.fix_stat)
        print('Altitude:', my_gps.altitude)
        print('Horizontal Dilution of Precision:', my_gps.hdop)
        print('Satellites in Use by Receiver:', my_gps.satellites_in_use)
       