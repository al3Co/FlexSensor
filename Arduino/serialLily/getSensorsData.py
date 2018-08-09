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
    ser = serial.Serial('COM3', 115200)
except:
    sys.exit('review the serial port')
 
rawdata = []

def getData():
    file = open((filename + '.txt'), mode = 'w')
    nCount = 1
    tic = time.time()
    ser.inWaiting()
    while(nCount<=10):
        ser.flush()
        print('\rCount: {} Sensors: {}'.format(nCount, ser.readline().strip()),
            sep='\n', end='', flush=True)
        rawdata.append((ser.readline().strip()))
        file.write(str(nCount) + ',' + str(datetime.datetime.now().time()) + ',' + str(ser.readline().strip()) + '\n')
        nCount += 1
    toc = time.time()
    ser.close()
    file.close()
    print('\nFrequency: {} Hz'.format(nCount/(toc - tic)))

if __name__ == "__main__":
    getData()
