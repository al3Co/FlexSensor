# -*- coding: utf-8 -*-
#!/usr/bin/python3

import threading
import time
import serial

exitFlag = 0

class threadsObj (threading.Thread):
    def __init__(self, threadID, name):
        super(threadsObj, self).__init__()
        threading.Thread.__init__(self)
        self._stop_event = threading.Event()
        self.threadID = threadID
        self.name = name

    def stop(self):
        self._stop_event.set()

    def stopped(self):
        return self._stop_event.is_set()

    def clear(self):
        self._stop_event.clear()

    def run(self):
        print ("Starting " + self.name)
        if self.threadID == 1:
            countFunc(self.name, 5)
        if self.threadID == 2:
            readFunc(self.name)
        print ("Exiting " + self.name)

def countFunc(threadName, max):
    counter = 0
    while not counterThread.stopped():
        print('\r{0}: {1}'.format(threadName, counter), sep='\n', end='', flush=True)
        time.sleep(1)
        counter += 1
    print('')

def readFunc(threadName):
    print('Reading serial port threadID: {}'.format(threadName))
    try:
        ser = serial.Serial('COM3', 115200)
        readSerialPort(ser)
    except:
        print('Serial COM problem')
        # stop counter thread
        if not counterThread.stopped():
            time.sleep(1)
            counterThread.stop()
        return

def readSerialPort(ser):
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
    ser.close()

# Create new threads
counterThread = threadsObj(1, "Counter")
readerThread = threadsObj(2, "Reader")

# Start new Threads
counterThread.start()
readerThread.start()

counterThread.join()
readerThread.join()

print ("Exiting Main Thread")
