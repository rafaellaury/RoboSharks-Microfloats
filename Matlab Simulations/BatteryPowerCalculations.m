%%Battery Life Estimations
clear
clc

%% Battery Values
Batt_V = 3.5*4; %Overall Voltage
Batt_Ah = 2.5*5; %Amp-Hours (assuming we use 85% of the battery capacity)
Batt_Wh = Batt_V*Batt_Ah; %Watt-Hours, not needed
Batt_Backup = 48E-3; %Amp-Hours for backup battery

%% Data Collection Mode
ESP_A = 30E-3; %Modem Sleep Mode (Amps)

Motor_A = 100/Batt_V; %Motor pump amp (RUR team)
Solenoid_A = 1.5; %Solenoid amps (RUR team)
%Motor_A = Motor*run_time;
% BMS_Sys = ESP_A + ;
CTD = 5E-3; %Max power consumption
ECO_FLNTU = 60E-3; 
PAR = 40E-6; %Estimate based off max 10000 umol vs sensitivy of 1000 umol with 4 uA
Transponder = 20E-3; %Based on external battery source
Altimeter = 150E-3;
Sensors = CTD + ECO_FLNTU + PAR + Transponder + Altimeter;
Total_Sys_A = (Motor_A/60) + ESP_A + (Solenoid_A/60) + Sensors; % + BMS_Sys; 
%Adjusted so motor only runs for one minute and sensors run for entire hour

%% Recovery Mode
beacon_A = (3/12)*6; %Requires 12 V
GPS_A = 31E-3; %GPS module current
LoRa_A = 7.5E-3; %Max value current
ESP_A = 8E-3; %Modem Sleep Mode (Amps)
Total_Rec_A = beacon_A + ESP_A + GPS_A + LoRa_A;

%% Low Power Mode
%Assuming we just transmit the saved GPS coordinates in the ESP
Total_Low_A = ESP_A + LoRa_A;

%% Estimated Battery Life
Data_Duration = (Batt_Ah*0.9)/(Total_Sys_A) %Duration during data collection assuimg 2 hours per day
Recovery_Duration = (Batt_Ah*0.1)/Total_Rec_A %Duration after recovery
Low_Power_Duration = Batt_Backup/Total_Low_A %Duration during low power mode (backup battery)

