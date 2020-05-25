from micropyGPS import MicropyGPS
import bme280,ssd1306
from machine import UART
from machine import I2C
from network import LoRa
import time
import socket
import config
import tools

# Inicia bus I2C
i2c = I2C(0, I2C.MASTER, baudrate=100000)

# Inicia bme280
bme = bme280.BME280(i2c=i2c,address=0x76)

# Inicia ssd1306
oled = ssd1306.SSD1306_I2C(128, 64, i2c)

# Inicia GPS
com = UART(1,pins=(config.TX, config.RX),  baudrate=config.BAUDRATE)
my_gps = MicropyGPS()


DEBUG = config.DEBUG



# Initialize LoRa in LORAWAN mode.
lora = LoRa(mode=LoRa.LORAWAN, region=LoRa.EU868)

# create an ABP authentication params
dev_addr = config.DEV_ADDR
nwk_swkey = config.NWK_SWKEY
app_swkey = config.APP_SWKEY

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


while True:
    if com.any():
        my_sentence = com.readline()
        for x in my_sentence:
            my_gps.update(chr(x))

        if  DEBUG == 1:
            oled.fill(0)
            oled.show()
            temp,pa,hum = bme.values
            print('Longitude', my_gps.longitude);
            print('Latitude', my_gps.latitude);
            print('UTC Timestamp:', my_gps.timestamp);
            print('Fix Status:', my_gps.fix_stat);
            print('Altitude:', my_gps.altitude);
            print('Horizontal Dilution of Precision:', my_gps.hdop)
            print('Satellites in Use by Receiver:', my_gps.satellites_in_use)
            oled.text("Lat: " + str(my_gps.latitude[0] + (my_gps.latitude[1] / 60)),0,0)
            oled.text("Lon: " + str(my_gps.longitude[0] + (my_gps.longitude[1] / 60)),0,10)
            oled.text("Temp: " + temp,0,20)
            oled.show()


        if (my_gps.fix_stat > 0 and my_gps.latitude[0] > 0):
            temp,pa,hum = bme.values
            t=float(temp[:-1])
            gps_array = tools.convert_latlon(my_gps.latitude[0] + (my_gps.latitude[1] / 60), my_gps.longitude[0] + (my_gps.longitude[1] / 60), my_gps.altitude, my_gps.hdop,t)
            print(gps_array)
            s.send(gps_array)
            s.settimeout(3.0) # configure a timeout value of 3 seconds
            
        time.sleep(180)

