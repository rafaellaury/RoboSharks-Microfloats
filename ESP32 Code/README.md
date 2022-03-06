# This folder contains the current code to be run on the microfloat's onboard ESP32-S2

## CaptivePortal
The CaptivePortal code shows a very basic proof of concept to allow the ESP32 to broadcast its own wifi network that automatically redirects you to its webpage when upon connection. This will be necessary when testing without a convinient wifi network for the ESP to connect to but is inconvinient for development since you have to constantly switch wifi networks.

## APServer
The APServer code is where the majority of the funcioning code lives right now. It is much easier to develop code using the APServer version since it connects the ESP32 to a wifi network and allows you to access the gui like a website. Unfortunately it probably won't play nicely with gtwifi so we will need to copy the important parts back to the CaptivePortal version at some point.
