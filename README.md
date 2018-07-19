<p align="center">
  <a href="#requirements">Requirements</a> |
  <a href="#documentation">Documentation</a> |
  <a href="#usage">Usage</a> |
  <a href="#known Issues">Communication</a> |
</p>

# FlexSensor
<br />
This repository is a working project developed for different purposes


## Requirements

### Software

- Python 3.6+
- tkinter
- pyserial

- Matlab 16+

### Hardware

- 2 IMU sensors
- Lily with 6 flexSens


## Documentation

LpVCPConversionTool:

https://bitbucket.org/lpresearch/openmat/downloads/LpVCPConversionTool-1.0.0-Setup.exe

IMU Drivers:

https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers


## Usage

- From Motive, configure and start getting data
- From Anaconda Spyder launch FlexSensor/Arduino/serialLily/GUIgetSensorsData.py
- Click "Start" button to get flexSens data on GUI, a counter will appear
- From Matlab Run getIMUdata.m to get IMU data, this will take a moment for synchronization
- When test is done, press any key to stop Matlab
- Click pause and then Stop from python GUI
- Stop getting data from Motive



## known Issues
- If Matlab throws an error, save workspace manually by running lines 88 to 97
- Serial Interrupt routine blocks main processing thread when transferring at data rate > 100Hz 
- 16bit data parsing is not yet implemented


