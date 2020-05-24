import array

def convert_latlon(latitude, longitude, altitude, hdop,temp):

    lat = int((latitude + 90)*10000)
    lon = int((longitude + 180)*10000)
    alt = int((altitude) * 10)
    lhdop = int((hdop) * 10)
    temp = int((temp) *10)

    coords = array.array('B', [0,0,0,0,0,0,0,0,0,0,0])
    coords[0] = lat
    coords[1] = (lat >> 8)
    coords[2] = (lat >> 16)

    coords[3] = lon
    coords[4] = (lon >> 8)
    coords[5] = (lon >> 16)

    coords[6] = alt
    coords[7] = (alt >> 8)
    coords[8] = lhdop

    coords[9] = temp
    coords[10] =(temp >> 8)

    return coords
    
    
