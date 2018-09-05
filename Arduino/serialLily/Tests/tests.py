# -*- coding: utf-8 -*-
"""
Created on Tue Jul 17 16:17:14 2018

@author: disam
"""

import tkinter

root = tkinter.Tk()
root.title('Timer')
root.state('zoomed')

sec = 0
doTick = True

def tick():
    global sec
    if not doTick:
        return
    sec += 0.1
    sec = round(sec,1)
    timeLabel.configure(text=sec)
    root.after(100, tick)

def stop():
    global doTick
    doTick = False

def start():
    global doTick
    doTick = True
    # Perhaps reset `sec` too?
    tick()

timeLabel = tkinter.Label(root, fg='green',font=('Helvetica',150))
timeLabel.pack()

startButton = tkinter.Button(root, text='Start', command=start)
startButton.pack()

stopButton = tkinter.Button(root, text='Stop', command=stop)
stopButton.pack()

root.mainloop()