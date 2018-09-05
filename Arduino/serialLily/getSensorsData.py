# -*- coding: utf-8 -*-
"""
Created on Tue Jul 17 11:04:25 2018

@author: disam
"""

# read and measure the transmission speed of serial (Lily) data
import time
import datetime
import serial
import sys

filename = time.strftime("%Y%m%d-%H%M%S")

try:
    ser = serial.Serial('/dev/tty.usbserial-FT9028B4', 115200)
except:
    sys.exit('review the serial port')

rawdata = []

def getData():
    file = open((filename + '.txt'), mode = 'w')
    nCount = 1
    tic = time.time()
    actual = 0;
    ser.inWaiting()
    while(nCount<=1000):
        ser.flush()
        try:
            read = ser.readline().decode('utf-8').strip()
            elapsed = int(time.time() - tic)
            if actual != elapsed:
                actual = elapsed
                print('\rElapsed Time: {}'.format(elapsed), sep='\n', end='', flush=True)
            rawdata.append(read)
            if nCount > 10:
                file.write(str(nCount-10) + ',' + str(datetime.datetime.now().time()) + ',' + str(read) + '\n')
            nCount += 1
        except UnicodeDecodeError:
            pass
    toc = time.time()
    ser.close()
    file.close()
    print('\nFrequency: {} Hz'.format(nCount/(toc - tic)))

if __name__ == "__main__":
    getData()
