
# read and measure the transmission speed of serial (Lily) data
import time
import serial
import sys 

try:
    ser = serial.Serial('COM3', 115200)
except:
    sys.exit('review the serial port')

rawdata = []
nCount = 0

tic = time.clock()
while(nCount<100):
    ser.flush()
    print('\rCount: {} Sensors: {}'.format(nCount, ser.readline().strip()),
        sep='\n', end='', flush=True)
    rawdata.append(ser.readline().strip())
    nCount += 1

toc = time.clock()
print('\nFrequency: {} Hz'.format(nCount/(toc - tic)))
ser.close()
