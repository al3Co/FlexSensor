
# read and measure the transmission speed of serial (Lily) data
import time
import serial
import sys

try:
    ser = serial.Serial('/dev/tty.usbserial-FT9028B4', 115200)
except:
    sys.exit('review the serial port')

rawdata = []
nCount = 0

tic = time.time()
while(nCount<100):
    ser.flush()
    print('\rCount: {} Sensors: {}'.format(nCount, ser.readline().decode('utf-8').strip()),
        sep='\n', end='', flush=True)
    rawdata.append(ser.readline().decode('utf-8').strip())
    nCount += 1

toc = time.time()
print('\nFrequency: {} Hz'.format(nCount/(toc - tic)))
ser.close()
