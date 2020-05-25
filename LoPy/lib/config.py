import struct
import ubinascii

DEBUG = 1

# TTN
# These you need to replace!
DEV_ADDR = struct.unpack(">l", ubinascii.unhexlify('26011F0F'))[0]
NWK_SWKEY = ubinascii.unhexlify('77D1B5A45BDDDF8193F1714DA5D01057')
APP_SWKEY = ubinascii.unhexlify('CFDC84B9C9AD8D9C8962462F1F8B44C3')

DEV_EUI = ubinascii.unhexlify('AABBCCDDEEFF7778')  
APP_EUI = ubinascii.unhexlify('70B3D57EF0003BFD') 
APP_KEY = ubinascii.unhexlify('36AB7625FE77776881683B495300FFD6') 


# GPS UART connection
TX = "P3"
RX = "P4"
BAUDRATE = 9600
