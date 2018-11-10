# read and save serial data from two ports

import time
import datetime
import serial
import sys

filename = time.strftime("%Y%m%d-%H%M%S")

rawdataA = []
rawdataB = []

def getData():
    # open ports
    print('Starting')
    try:
        serA = serial.Serial('COM14', 115200)
        serB = serial.Serial('COM11', 115200)
    except:
        sys.exit('review the serial port')
    # open files
    fileA = open((filename + 'A.txt'), mode = 'w')
    fileB = open((filename + 'B.txt'), mode = 'w')
    # variables
    nCount = 1
    tic = time.time()
    actual = 0;
    serA.inWaiting()
    serB.inWaiting()
    # reading
    while(nCount<=1000):
        serA.flush()
        serB.flush()
        try:
            readA = serA.readline().decode('utf-8').strip()
            readB = serB.readline().decode('utf-8').strip()
            elapsed = int(time.time() - tic)
            if actual != elapsed:
                actual = elapsed
                print('\rElapsed Time: {}'.format(elapsed), sep='\n', end='', flush=True)
            rawdataA.append(readA)
            rawdataB.append(readB)
            if nCount > 10:
                fileA.write(str(nCount-10) + ',' + str(datetime.datetime.now().time()) + ',' + str(readA) + '\n')
                fileB.write(str(nCount-10) + ',' + str(datetime.datetime.now().time()) + ',' + str(readB) + '\n')
                print('\rCount: {} Sensors: {}'.format(nCount, serA.readline().decode('utf-8').strip()),
        sep='\n', end='', flush=True)
            nCount += 1
        except UnicodeDecodeError:
            pass
    toc = time.time()
    serA.close()
    serB.close()
    fileA.close()
    fileB.close()
    print('\nFrequency: {} Hz'.format(nCount/(toc - tic)))


if __name__ == "__main__":
    getData()
