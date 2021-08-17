# FAST #
**F**ilter and **A**ggregate **S**ynchrosqueezed **T**ransform

An update to the traditional Wavelet synchrosqueezed transform, for use when component separation is hard. FAST is optimized to separate individual components that may show distortions or beating patterns upon transformation to the frequency domain due to transient proximity of components of the signal.
This code is written for Matlab 2021A.

Article link will be updated here soon

<b>Prerequisites:</b> 
1. Matlab 2021A or higher (this should work with earlier versions as well, but is untested)
2. Wavelet Toolbox

<b>Directions for use:</b> 
1. Download the file fil_agg_v2.m
2. Navigate to the folder where this file exists
3. Run using command : code([FAST, f] = fil_agg_v2(signal, bands, fs, order))

_Meaning of the terms:_
* signal - The signal you want to analyse. It must be 1 dimensional, ie, an array with shape 1xN or Nx1
* bands - The frequency bands for analysis. Typically using 1:1:fs/2 is recommended. This filters and analyzes the signal in bands of 1Hz each from 1Hz to half of the Sampling Frequency.
* fs - The sampling Frequency
* order - Order of the filter to be used. Higher order will reduce magnitude of the filtered signal. An order of 2 is recommended.

### Examples ###
Examples from the article may be replicated using the functions in the 'example generators' folder

These examples are as follows:
* **test_wave_1.m** - Synthetic test example from Figure 1 of the article. It consists of a signal that is composed of multiple sinusoids which transiently switch off. The presence or absence of these components causes different types of beating and other distortions, which are well separated by FAST.
* **step_signal.m** - Synthetic signal which makes a single abrupt change in frequency.

Some Results:
_Results will be posted here soon_
