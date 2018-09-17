try:
    from tkinter import *
except ImportError:
    from Tkinter import *

import time
import datetime
import serial
import sys

class getSerialData(Frame):
    """ Implements a stop watch frame widget. """
    def __init__(self, parent=None, **kw):
        Frame.__init__(self, parent, kw)
        self._start = 0.0
        self._elapsedtime = 0.0
        self._running = 0
        self.timestr = StringVar()
        self.makeWidgets()
        self.nCount = 1
        self.fileName = time.strftime("%Y%m%d-%H%M%S")
        self.ser = serial.Serial()
        self.ser.baudrate = 115200
        self.ser.port = '/dev/tty.usbserial-FTG4DJZ7'
        self.file = None

    def makeWidgets(self):
        """ Make the time label. """
        l = Label(self, textvariable=self.timestr)
        self._setTime(self._elapsedtime)
        l.pack(fill=X, expand=NO, pady=2, padx=2)

    def _update(self):
        """ Update the label with elapsed time. """
        try:
            self._elapsedtime = time.time() - self._start
            self.file.write(str(self.nCount) + ',' + str(datetime.datetime.now().time()) + ',' + str(self.ser.readline().decode('utf-8').strip()) + '\n')
            self._setTime(self._elapsedtime)
            self.nCount += 1
        except UnicodeDecodeError:
            pass
        self._timer = self.after(1, self._update)

    def _setTime(self, elap):
        """ Set the time string to Minutes:Seconds:Hundreths """
        minutes = int(elap/60)
        seconds = int(elap - minutes*60.0)
        hseconds = int((elap - minutes*60.0 - seconds)*100)
        self.timestr.set('%02d:%02d:%02d' % (minutes, seconds, hseconds))

    def Start(self):
        """ Start the stopwatch, ignore if running. """
        if not self._running:
            try:
                self.ser.open()
            except:
                sys.exit('--Review the serial port--')
            self.file = open((self.fileName + '.txt'), mode = 'w')
            self._start = time.time() - self._elapsedtime
            self._update()
            self._running = 1

    def Stop(self):
        """ Stop the stopwatch, ignore if stopped. """
        if self._running:
            self.after_cancel(self._timer)
            self._elapsedtime = time.time() - self._start
            self._setTime(self._elapsedtime)
            self._running = 0
            self.file.close()

    def Reset(self):
        """ Reset the stopwatch. """
        self._start = time.time()
        self._elapsedtime = 0.0
        self._setTime(self._elapsedtime)
        self.nCount = 1
        if self.ser.is_open:
            self.ser.close()
        self.file.close()
        self.fileName = time.strftime("%Y%m%d-%H%M%S")

def main():
    root = Tk()
    sw = getSerialData(root)
    sw.pack(side=TOP)

    Button(root, text='Start', command=sw.Start).pack(side=LEFT)
    Button(root, text='Stop', command=sw.Stop).pack(side=LEFT)
    Button(root, text='Reset', command=sw.Reset).pack(side=LEFT)
    Button(root, text='Quit', command=root.quit).pack(side=LEFT)

    root.mainloop()

if __name__ == '__main__':
    main()
