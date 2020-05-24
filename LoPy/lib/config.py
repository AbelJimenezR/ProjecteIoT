import struct
import ubinascii

DEBUG = 1

# TTN
# These you need to replace!
DEV_ADDR = struct.unpack(">l", ubinascii.unhexlify('26011A7E'))[0]
NWK_SWKEY = ubinascii.unhexlify('089BC619B84C990B7376100A95BE2FA1')
APP_SWKEY = ubinascii.unhexlify('BF204BC9EDA83A370A8548345A68F0A0')

DEV_EUI = ubinascii.unhexlify('AABBCCDDEEFF7778')  
APP_EUI = ubinascii.unhexlify('70B3D57EF0003BFD') 
APP_KEY = ubinascii.unhexlify('36AB7625FE77776881683B495300FFD6') 


# GPS UART connection
TX = "P3"
RX = "P4"
BAUDRATE = 9600
