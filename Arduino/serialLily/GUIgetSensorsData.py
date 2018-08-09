# -*- coding: utf-8 -*-
"""
Created on Tue Jul 17 15:16:46 2018

@author: disam
"""
# read and measure the transmission speed of serial (Lily) data using GUI

import tkinter as tk
import time
import datetime
import serial
import sys

filename = time.strftime("%Y%m%d-%H%M%S")
filename = ('lateral_' + filename)          # change here the kind of movement
startFlag = False
nCount = 0

try:
    ser = serial.Serial('COM11', 115200)
    file = open((filename + '.txt'), mode = 'w')
except:
    sys.exit('review the serial port')

def readSensors():
    global nCount
    if not startFlag:
        return
    ser.flush()
    print('\rCount: {} Sensors: {}'.format(nCount, ser.readline().strip()), sep='\n', end='', flush=True)
    file.write(str(nCount) + ',' + str(datetime.datetime.now().time()) + ',' + str(ser.readline().strip()) + '\n')
    nCount += 1
    window.after(0, readSensors)

def stop():
    global startFlag
    startFlag = False
    ser.close()
    file.close()
    label.config(text='Ready')
    window.destroy

def start():
    global startFlag
    label.config(text='Reading ...')
    startFlag = True
    readSensors()

window = tk.Tk()
window.title("Getting sensor data")
window.geometry("300x100")

label = tk.Label(window, fg="green")
label.pack()
label.config(text='Ready')

strButton = tk.Button(window, text='Start', width=50, command=start)
strButton.pack()

stpButton = tk.Button(window, text='Stop', width=50, command=stop)
stpButton.pack()

exButton = tk.Button(window, text='Exit', width=50, command=window.destroy)
exButton.pack()

window.mainloop()
