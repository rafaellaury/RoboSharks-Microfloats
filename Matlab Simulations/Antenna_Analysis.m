%Antenna Analysis for the MicroFloat Capstone Project.
%Want to get worst case scenario: consider deconstructive interferance at
%the receiver. Also want to vary the height of the MicroFloat for better
%analysis. MicroFloat is the transceiver and scientist is the receiver.
clear;
clc;

%% Set Receiver (MicroFloat) Height; Power to Reach One Mile Out

%Antenna Variables
P_T = 10^(29.21/10) * 10e-3; %Power of the transmitter (W max)
G_T = 10^((2.1-1)/10); %Gain of the transmitter (dBi)
G_R = 10^((11.1-1)/10); %Gain of the receiver (dBm?)
lambda = (2.998e8)/(913e6); %Wavelength of the signal (halfway point between range) (meters)
r = 1609.34; %Distance between the receiver and the transmitter (meters for 1 mile)
h_T = 0.6096; %Height of the transmitter wrt ocean level (meters)
h_R = 1.524; %Height of the receiver wrt ocean level (meters (5ft))
d = r; %Distance between receiver and transmitter in x-direction (assumed to be the same as r)

%Power Received at the Antenna
DestructInt = [(4*pi*h_T*h_R)/(lambda*d)]^2;
P_R = (P_T*G_T*G_R*lambda^2 * DestructInt)/(4*pi*r)^2   %(W)

%% Max Distance Based on Receiver Sensitivy
P_R_sens = 10^(-100/10) * 10e-2; %Receiver sensitivity of high (W)
r = sqrt((P_T*G_T*G_R*lambda^2 * DestructInt)/((4*pi)^2 * P_R_sens)); %(m)
r_miles = r/1609 %Miles

%% Variable Height using Sine Wave (Motion of Ocean); Power to Reach One Mile Out
%i = input("Wave Conditions? 1 (Smooth) to 5 (Very Rough): ");
i = 1;
    if i == 1      %Smooth Wave Scenario
        h_sea = 0.5; %Height of a sea wave (m)
        T = 11;     %Period of the wave (s)
    elseif i == 2  %Slight Wave Scenario
        h_sea = 1.25; %Height of a sea wave (m)
        T = 11;     %Period of the wave (s)
    elseif i == 3  %Moderate Wave Scenario
        h_sea = 2.5; %Height of a sea wave (m)
        T = 9;     %Period of the wave (s)
    elseif i == 4  %Rough Wave Scenario
        h_sea = 4; %Height of a sea wave (m)
        T = 9;     %Period of the wave (s)
    elseif i == 5  %Very Rough Wave Scenario
        h_sea = 6; %Height of a sea wave (m)
        T = 8;     %Period of the wave (s)
    end
    
    t = 0:1/T:3*T; %time (s)
    h_T_sine = @(t) 0.6096 + h_sea*sin((2*pi*t)/T); %New height changes with respect to an ocean wave
    DestructInt_wave = @(t) [(4*pi.*h_T_sine(t).*h_R)/(lambda*d)].^2;
    P_R_wave = @(t) (P_T*G_T*G_R*lambda^2 .* DestructInt_wave(t))/(4*pi*r)^2;
    max_P_R = max(P_R_wave(t));

    figure;
    %subplot(2,1,1)
    
%     if i == 1
%         sgtitle('\fontsize{16}Smooth Wave Conditions');
%     elseif i == 2
%         sgtitle('\fontsize{16}Slight Wave Conditions');
%     elseif i == 3
%         sgtitle('\fontsize{16}Moderate Wave Conditions');
%     elseif i == 4
%         sgtitle('\fontsize{16}Rough Wave Conditions');
%     elseif i == 5
%         sgtitle('\fontsize{16}Very Rough Wave Conditions');
%     end

    %plot(t, h_T_sine(t), 'b');
    %title("Height of MicroFloat Antenna with 0.5m Ocean Waves");
    %xlabel("Time (s)");
    %ylabel("Antenna Height (m)");

    %subplot(3,1,2)
    %plot(t, P_R_wave(t), 'r');
%     title("Power Received at the Receiver with MicroFloat Height Shifting");
%     xlabel("Time (s)");
%     ylabel("Power Received at Receiver (W)");
%     hold on
%     plot(t, P_R_sens*ones(length(t)), 'g');
%     hold off
%     legend('Power Received', 'Receiver Sensitivty');

    % Max Distance Based on Receiver Sensitivity with Ocean Waves
    r = @(t) sqrt((P_T*G_T*G_R*lambda^2 * DestructInt_wave(t))/((4*pi)^2 * P_R_sens));

    %subplot(2,1,2)
    plot(t, r(t)/1609, 'b'); 
    title('Antenna Range (Smooth Wave Conditions)');
    xlabel('Time (s)');
    ylabel('Distance (miles)');
 
    