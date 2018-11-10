from tkinter import *

import time
import datetime
import serial
import sys

running = False     # Global flag

def scanning():
    if running:  # Only do this if the Stop button has not been clicked
        print('Running')
    root.after(100, scanning)

def start():
    global running
    # changing variable to True
    running = True
    Instruction.config(text='Reading')

def stop():
    global running
    running = False
    print('\nStop')
    Instruction.config(text='Ready')

root = Tk()
root.title("Get serial port data")
root.geometry("200x70")

app = Frame(root)
app.grid()

start = Button(app, text="Start", width=10, command=start)
stop = Button(app, text="Stop", width=10, command=stop)

message = 'Ready'
Instruction = Label(app, text=message, font='size, 10')

start.grid(row=0, column=0)
stop.grid(row=0, column=1)
Instruction.grid(row=1, column=1)

root.after(100, scanning)
root.mainloop()
