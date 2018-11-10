from tkinter import *

import time
import datetime
import serial
import sys

running = False     # Global flag
nCount = 1          # Counter
filename = None     # fileName changing each time
fileA = None
fileB = None

try:
    serA = serial.Serial('COM14', 115200)
    serB = serial.Serial('COM11', 115200)
except:
    serA.close()
    serB.close()
    sys.exit('review the serial port')

def scanning():
    global nCount, readA, readB, fileA, fileB
    if running:  # Only do this if the Stop button has not been clicked
        try:
            readA = serA.readline().decode('utf-8').strip()
            readB = serB.readline().decode('utf-8').strip()
            if nCount > 10:
                fileA.write(str(nCount-10) + ',' + str(datetime.datetime.now().time()) + ',' + str(readA) + '\n')
                fileB.write(str(nCount-10) + ',' + str(datetime.datetime.now().time()) + ',' + str(readB) + '\n')
                print('\rSample: {}'.format(nCount), sep='\n', end='', flush=True)
            nCount += 1
        except UnicodeDecodeError:
            pass
    root.after(1, scanning)

def start():
    global running, filename, fileA, fileB, serA, serB
    # open ports
    filename = time.strftime("%Y%m%d-%H%M%S")
    print('Creating: {}'.format(filename))
    # open files
    fileA = open((filename + 'A.txt'), mode = 'w')
    fileB = open((filename + 'B.txt'), mode = 'w')
    if not serA.isOpen():
        serA.open()
        serB.open()
    serA.inWaiting()
    serB.inWaiting()
    # changing variable to True
    running = True
    statusLabel.config(text='Reading')

def stop():
    global running, nCount
    running = False
    nCount = 1
    serA.close()
    serB.close()
    fileA.close()
    fileB.close()
    print('\nStop')
    statusLabel.config(text='Ready')

root = Tk()
root.title("Get serial port data")
root.geometry("200x70")

app = Frame(root)
app.grid()

start = Button(app, text="Start", width=10, command=start)
stop = Button(app, text="Stop", width=10, command=stop)

message = 'Ready'
statusLabel = Label(app, text=message, font='size, 10')

start.grid(row=0, column=0)
stop.grid(row=0, column=1)
statusLabel.grid(row=1, column=1)

root.after(1, scanning)
root.mainloop()
