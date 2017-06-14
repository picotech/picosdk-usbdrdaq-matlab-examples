%% USB DrDAQ Block Data Capture Example
% This is a MATLAB script that demonstrates how to use the usbdrdaq shared
% library API functions to capture a block of data from a USB DrDAQ data
% logger using the following approach:
%       
% * Loading the shared library
% * Open a unit 
% * Display unit information 
% * Set up an input channel
% * Specify the sampling interval
% * Setup a trigger
% * Output a signal from the signal generator
% * Collect a block of data
% * Retrieve the data values and convert to millivolts
% * Plot data
% * Close the unit
% * Unload the shared library
%  
% To run the script, type the name of the file,
% USBDrDAQ_example, at the MATLAB command prompt.
% 
% The file, USBDrDAQExample.m must be on your MATLAB PATH. For additional
% information on setting your MATLAB PATH, type 'help addpath' at the
% MATLAB command prompt.
%
% Description:
% Demonstrates how to call simple functions in order to use setup a
% USB DrDAQ data logger and capture some data.
%
% Copyright: � 2014-2017 Pico Technology Ltd. See LICENSE file for
% terms.

%% Clear Command Line and Close Any Figures

clc;
close all;

%% Load Configuration Information

USBDrDAQConfig;

%% Load the Shared Library
loadlibrary('usbdrdaq.dll', @usbdrdaqMFile);

%% Open the Device

pHandle = libpointer('int16Ptr', 0);

[status.openUnit] = calllib('usbdrdaq','UsbDrDaqOpenUnit', pHandle);

handle = pHandle.Value;

if (status ~= PicoStatus.PICO_OK)
    
    unloadlibrary('usbdrdaq');
    fprintf('Cannot open unit \n Error Code: %d\n', status);
    return;
end

%% Display Unit Information

infoStr = blanks(100);
requiredSize = length(infoStr);

disp('Unit Information:');

for i = 0:6
    
    [status.getUnitInfo(i), infoStr1, requiredsize] = calllib('usbdrdaq','UsbDrDaqGetUnitInfo',...
        handle, infoStr, length(infoStr), requiredSize, i);
    
    disp(infoStr1);
    
end

%% Set the sampling interval

pMicrosecondsForBlock = 1000;
idealNumberOfSamples = 5000;
channels = [usbDrDaqEnuminfo.enUsbDrDaqInputs.USB_DRDAQ_CHANNEL_SCOPE];
numberOfChannels = length(channels);



%% Set trigger


%% Start signal generator

offsetVoltage   = 0;        % volts
peakToPeak      = 3000000   % �1.5 V
frequency       = 2000;     % 1 kHz
waveType        = usbDrDaqEnuminfo.enUsbDrDaqWave.USB_DRDAQ_SINE;

status.setSigGenBuiltIn = calllib('usbdrdaq','UsbDrDaqGetUnitInfo', handle, infoStr, length(infoStr), requiredSize, i);

%% Start data collection



%% Retrieve data values
 

%% Process data


%% Stop the device

%% Close Unit

[status.closeUnit] = calllib('usbdrdaq','UsbDrDaqCloseUnit', handle);

%% Unload Shared Library

unloadlibrary('usbdrdaq');