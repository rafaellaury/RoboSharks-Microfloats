EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "modified DIYBMS cell monitoring module"
Date "2021-04-13"
Rev ""
Comp "VIP Aquabots"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_ATtiny:ATtiny841-SSU ATTINY841
U 1 1 5BC63D51
P 2055 3310
F 0 "ATTINY841" H 1525 3356 50  0000 R CNN
F 1 "ATtiny841-SSU" H 1525 3265 50  0000 R CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 2055 3310 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8495-8-bit-AVR-Microcontrollers-ATtiny441-ATtiny841_Datasheet.pdf" H 2055 3310 50  0001 C CNN
F 4 "C219103" H 2055 3310 50  0001 C CNN "LCSCStockCode"
	1    2055 3310
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0101
U 1 1 5D1EAAC3
P 5325 5895
F 0 "#PWR0101" H 5325 5745 50  0001 C CNN
F 1 "VCC" H 5325 5795 50  0000 C CNN
F 2 "" H 5325 5895 50  0001 C CNN
F 3 "" H 5325 5895 50  0001 C CNN
	1    5325 5895
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5D1EAB19
P 5675 5285
F 0 "#PWR0102" H 5675 5035 50  0001 C CNN
F 1 "GND" H 5680 5112 50  0000 C CNN
F 2 "" H 5675 5285 50  0001 C CNN
F 3 "" H 5675 5285 50  0001 C CNN
	1    5675 5285
	1    0    0    -1  
$EndComp
Wire Wire Line
	2055 4210 2055 4230
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5D1EAC37
P 4925 5125
F 0 "#FLG0101" H 4925 5200 50  0001 C CNN
F 1 "PWR_FLAG" H 4925 5299 50  0000 C CNN
F 2 "" H 4925 5125 50  0001 C CNN
F 3 "~" H 4925 5125 50  0001 C CNN
	1    4925 5125
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5D1EAC7F
P 5615 5895
F 0 "#FLG0102" H 5615 5970 50  0001 C CNN
F 1 "PWR_FLAG" H 5615 6069 50  0000 C CNN
F 2 "" H 5615 5895 50  0001 C CNN
F 3 "~" H 5615 5895 50  0001 C CNN
	1    5615 5895
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5D1EAD64
P 1355 2520
F 0 "C1" H 1241 2566 50  0000 R CNN
F 1 "100nF" H 1241 2475 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 1393 2370 50  0001 C CNN
F 3 "" H 1355 2520 50  0001 C CNN
F 4 "C49678" H 1355 2520 50  0001 C CNN "LCSCStockCode"
F 5 "CC0805KRX7R9BB104" H 1355 2520 50  0001 C CNN "PartNumber"
	1    1355 2520
	1    0    0    -1  
$EndComp
Wire Wire Line
	2055 2250 1355 2250
Wire Wire Line
	1355 2250 1355 2370
Wire Wire Line
	1355 4230 2055 4230
$Comp
L Connector:Conn_01x02_Male POWER1
U 1 1 5D1EB9F6
P 4325 5535
F 0 "POWER1" H 4431 5713 50  0000 C CNN
F 1 "Battery" H 4431 5622 50  0000 C CNN
F 2 "Connector_JST:JST_PH_S2B-PH-K_1x02_P2.00mm_Horizontal" H 4325 5535 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/JST-Sales-America-S2B-PH-K-S-LF-SN_C173752.pdf" H 4325 5535 50  0001 C CNN
F 4 "C265016" H 4325 5535 50  0001 C CNN "LCSCStockCode"
F 5 "S2B-PH-K(LF)(SN)" H 4325 5535 50  0001 C CNN "PartNumber"
	1    4325 5535
	1    0    0    -1  
$EndComp
Wire Wire Line
	2055 2250 2055 2410
Wire Wire Line
	4925 5285 4925 5125
$Comp
L Device:R R1
U 1 1 5D1EC483
P 2965 4375
F 0 "R1" V 2758 4375 50  0000 C CNN
F 1 "10KOHMS" V 2849 4375 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 2895 4375 50  0001 C CNN
F 3 "" H 2965 4375 50  0001 C CNN
F 4 "C17414" V 2965 4375 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F1002T5E" V 2965 4375 50  0001 C CNN "PartNumber"
	1    2965 4375
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5D1EC6B4
P 3215 4375
F 0 "#PWR01" H 3215 4225 50  0001 C CNN
F 1 "VCC" H 3232 4548 50  0000 C CNN
F 2 "" H 3215 4375 50  0001 C CNN
F 3 "" H 3215 4375 50  0001 C CNN
	1    3215 4375
	1    0    0    -1  
$EndComp
Wire Wire Line
	3115 4375 3215 4375
Wire Wire Line
	3455 3310 2655 3310
$Comp
L power:GND #PWR0105
U 1 1 5D1F0262
P 2195 4230
F 0 "#PWR0105" H 2195 3980 50  0001 C CNN
F 1 "GND" H 2200 4057 50  0000 C CNN
F 2 "" H 2195 4230 50  0001 C CNN
F 3 "" H 2195 4230 50  0001 C CNN
	1    2195 4230
	1    0    0    -1  
$EndComp
Wire Wire Line
	4625 5285 4625 5535
$Comp
L power:VCC #PWR0106
U 1 1 5D1F1B1C
P 2055 2250
F 0 "#PWR0106" H 2055 2100 50  0001 C CNN
F 1 "VCC" H 2072 2423 50  0000 C CNN
F 2 "" H 2055 2250 50  0001 C CNN
F 3 "" H 2055 2250 50  0001 C CNN
	1    2055 2250
	1    0    0    -1  
$EndComp
Connection ~ 2055 2250
Wire Wire Line
	2815 4375 2655 4375
Connection ~ 2055 4230
Wire Wire Line
	2195 4230 2055 4230
$Comp
L Reference_Voltage:LM385Z-ADJ D1
U 1 1 5D1FB1C3
P 3765 2400
F 0 "D1" V 3811 2312 50  0000 R CNN
F 1 "AZ432ANTR-E1" V 3660 2360 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3765 2200 50  0001 C CIN
F 3 "https://datasheet.lcsc.com/szlcsc/Diodes-Incorporated-AZ432ANTR-E1_C84139.pdf" H 3765 2400 50  0001 C CIN
F 4 "C84139" V 3765 2400 50  0001 C CNN "LCSCStockCode"
F 5 "AZ432ANTR-E1" V 3765 2400 50  0001 C CNN "PartNumber"
	1    3765 2400
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R2
U 1 1 5D1FB25D
P 3765 1950
F 0 "R2" H 3835 1996 50  0000 L CNN
F 1 "1KOHMS" H 3835 1905 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3695 1950 50  0001 C CNN
F 3 "" H 3765 1950 50  0001 C CNN
F 4 "C17513" V 2965 4050 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F1001T5E" V 2965 4050 50  0001 C CNN "PartNumber"
	1    3765 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3765 2250 3765 2220
Connection ~ 3765 2220
Wire Wire Line
	3765 2220 3765 2100
Wire Wire Line
	3765 2550 3905 2550
$Comp
L power:GND #PWR0107
U 1 1 5D1FCDB1
P 3905 2550
F 0 "#PWR0107" H 3905 2300 50  0001 C CNN
F 1 "GND" H 3910 2377 50  0000 C CNN
F 2 "" H 3905 2550 50  0001 C CNN
F 3 "" H 3905 2550 50  0001 C CNN
	1    3905 2550
	1    0    0    -1  
$EndComp
Text GLabel 2825 3410 2    50   Input ~ 0
ENABLE
Text GLabel 3765 1650 2    50   Input ~ 0
ENABLE
Wire Wire Line
	3765 1650 3765 1800
Text GLabel 4850 2590 2    50   Input ~ 0
ENABLE
Wire Wire Line
	4850 2670 4850 2590
Wire Wire Line
	2655 3410 2835 3410
Text GLabel 2905 2810 2    50   Input ~ 0
TXD0
Wire Wire Line
	2655 2810 2905 2810
Text GLabel 2905 2910 2    50   Input ~ 0
RXD0
Wire Wire Line
	2655 2910 2905 2910
Text Notes 1325 1890 0    50   ~ 0
PA7 has a higher current output than other pins
$Comp
L Isolator:PC817 U1
U 1 1 5BF1DCDE
P 9640 4960
F 0 "U1" H 9640 5285 50  0000 C CNN
F 1 "EL3H7(B)(TA)-G" H 9640 5194 50  0000 C CNN
F 2 "Package_SO:SOP-4_4.4x2.6mm_P1.27mm" H 9440 4760 50  0001 L CIN
F 3 "https://datasheet.lcsc.com/szlcsc/Everlight-Elec-EL3H7-B-TA-G_C32565.pdf" H 9640 4960 50  0001 L CNN
F 4 "C32565" H 9640 4960 50  0001 C CNN "LCSCStockCode"
F 5 "EL3H7(B)(TA)-G" H 9640 4960 50  0001 C CNN "PartNumber"
F 6 "90" H 9640 4960 50  0001 C CNN "JLCPCBRotation"
	1    9640 4960
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male TX1
U 1 1 5BF1DEA4
P 10390 5000
F 0 "TX1" H 10363 4880 50  0000 R CNN
F 1 "TX Connector" H 10363 4971 50  0000 R CNN
F 2 "Connector_JST:JST_PH_S2B-PH-K_1x02_P2.00mm_Horizontal" H 10390 5000 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/JST-Sales-America-S2B-PH-K-S-LF-SN_C173752.pdf" H 10390 5000 50  0001 C CNN
F 4 "C265016" H 10390 5000 50  0001 C CNN "LCSCStockCode"
F 5 "S2B-PH-K(LF)(SN)" H 10390 5000 50  0001 C CNN "PartNumber"
	1    10390 5000
	-1   0    0    1   
$EndComp
$Comp
L Device:R R5
U 1 1 5BF1E307
P 9080 4860
F 0 "R5" V 8873 4860 50  0000 C CNN
F 1 "220OHMS" V 8964 4860 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9010 4860 50  0001 C CNN
F 3 "" H 9080 4860 50  0001 C CNN
F 4 "C17557" V 3570 5040 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F2200T5E" V 3570 5040 50  0001 C CNN "PartNumber"
	1    9080 4860
	0    1    1    0   
$EndComp
Wire Wire Line
	10190 4860 10190 4900
Wire Wire Line
	10190 5060 10190 5000
Wire Wire Line
	9230 4860 9340 4860
$Comp
L power:GND #PWR0109
U 1 1 5BF23EBD
P 9240 5060
F 0 "#PWR0109" H 9240 4810 50  0001 C CNN
F 1 "GND" H 9245 4887 50  0000 C CNN
F 2 "" H 9240 5060 50  0001 C CNN
F 3 "" H 9240 5060 50  0001 C CNN
	1    9240 5060
	1    0    0    -1  
$EndComp
Wire Wire Line
	9240 5060 9340 5060
Text GLabel 8630 4860 3    50   Input ~ 0
TXD0
Wire Wire Line
	8930 4860 8630 4860
$Comp
L Device:Q_NMOS_GSD Q1
U 1 1 5BF2E627
P 10315 3405
F 0 "Q1" V 10565 3405 50  0000 C CNN
F 1 "AO3400A" V 10656 3405 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 10515 3505 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Alpha-Omega-Semicon-AOS-AO3400A_C20917.pdf" H 10315 3405 50  0001 C CNN
F 4 "C20917" V 10315 3405 50  0001 C CNN "LCSCStockCode"
F 5 "AO3400A" H 10315 3405 50  0001 C CNN "PartNumber"
	1    10315 3405
	0    1    1    0   
$EndComp
$Comp
L Device:R R15
U 1 1 5BF2E6E2
P 9765 3355
F 0 "R15" H 9835 3401 50  0000 L CNN
F 1 "10KOHMS" H 9835 3315 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9695 3355 50  0001 C CNN
F 3 "" H 9765 3355 50  0001 C CNN
F 4 "C17414" H 9765 3355 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F1002T5E" H 9765 3355 50  0001 C CNN "PartNumber"
	1    9765 3355
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5BF33395
P 9765 3675
F 0 "#PWR0110" H 9765 3425 50  0001 C CNN
F 1 "GND" H 9770 3502 50  0000 C CNN
F 2 "" H 9765 3675 50  0001 C CNN
F 3 "" H 9765 3675 50  0001 C CNN
	1    9765 3675
	1    0    0    -1  
$EndComp
Wire Wire Line
	9765 3505 9765 3675
Wire Wire Line
	10115 3505 9765 3505
Connection ~ 9765 3505
Wire Wire Line
	10315 3205 9765 3205
$Comp
L power:VCC #PWR0111
U 1 1 5BF41634
P 8710 1545
F 0 "#PWR0111" H 8710 1395 50  0001 C CNN
F 1 "VCC" H 8727 1718 50  0000 C CNN
F 2 "" H 8710 1545 50  0001 C CNN
F 3 "" H 8710 1545 50  0001 C CNN
	1    8710 1545
	1    0    0    -1  
$EndComp
Text Notes 10215 3185 0    50   ~ 0
gate
Text Notes 9975 3625 0    50   ~ 0
source
Text Notes 10465 3635 0    50   ~ 0
drain
Text GLabel 2655 3810 2    50   Input ~ 0
DUMP_LOAD_ENABLE
Text GLabel 8765 3375 0    50   Input ~ 0
DUMP_LOAD_ENABLE
Wire Wire Line
	9345 3205 9065 3375
Connection ~ 9765 3205
$Comp
L Connector:Conn_01x02_Male RX1
U 1 1 5BF5891C
P 10240 5720
F 0 "RX1" H 10213 5600 50  0000 R CNN
F 1 "RX Connector" H 10213 5691 50  0000 R CNN
F 2 "Connector_JST:JST_PH_S2B-PH-K_1x02_P2.00mm_Horizontal" H 10240 5720 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/JST-Sales-America-S2B-PH-K-S-LF-SN_C173752.pdf" H 10240 5720 50  0001 C CNN
F 4 "C265016" H 10240 5720 50  0001 C CNN "LCSCStockCode"
F 5 "S2B-PH-K(LF)(SN)" H 10240 5720 50  0001 C CNN "PartNumber"
	1    10240 5720
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR0112
U 1 1 5BF58ABE
P 9670 5540
F 0 "#PWR0112" H 9670 5390 50  0001 C CNN
F 1 "VCC" H 9687 5713 50  0000 C CNN
F 2 "" H 9670 5540 50  0001 C CNN
F 3 "" H 9670 5540 50  0001 C CNN
	1    9670 5540
	1    0    0    -1  
$EndComp
Wire Wire Line
	9670 5620 9670 5540
$Comp
L power:GND #PWR0113
U 1 1 5BF5A4D9
P 9600 6130
F 0 "#PWR0113" H 9600 5880 50  0001 C CNN
F 1 "GND" H 9605 5957 50  0000 C CNN
F 2 "" H 9600 6130 50  0001 C CNN
F 3 "" H 9600 6130 50  0001 C CNN
	1    9600 6130
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 5BF5A518
P 9600 5870
F 0 "R16" V 9690 5920 50  0000 C CNN
F 1 "4.7KOHMS" V 9465 6030 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9530 5870 50  0001 C CNN
F 3 "" H 9600 5870 50  0001 C CNN
F 4 "C17673" V 3570 5040 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F4701T5E" V 3570 5040 50  0001 C CNN "PartNumber"
F 6 "0" V 9600 5870 50  0001 C CNN "JLCPCBRotation"
	1    9600 5870
	-1   0    0    1   
$EndComp
Wire Wire Line
	9600 6020 9600 6130
Text GLabel 9330 5720 3    50   Input ~ 0
RXD0
Wire Wire Line
	9330 5720 9600 5720
Connection ~ 9600 5720
$Comp
L Device:Thermistor R19
U 1 1 5BF374BB
P 7065 5335
F 0 "R19" H 7135 5381 50  0000 L CNN
F 1 "CMFB103F3950FANT" H 7135 5275 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6995 5335 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Guangdong-Fenghua-Advanced-Tech-CMFB103F3950FANT_C51597.pdf" H 7065 5335 50  0001 C CNN
F 4 "C51597" V 6885 3155 50  0001 C CNN "LCSCStockCode"
F 5 "CMFB103F3950FANT" V 6885 3155 50  0001 C CNN "PartNumber"
	1    7065 5335
	1    0    0    -1  
$EndComp
$Comp
L Device:R R20
U 1 1 5BF374C1
P 7065 5725
F 0 "R20" H 7135 5771 50  0000 L CNN
F 1 "10KOHMS" H 7135 5680 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6995 5725 50  0001 C CNN
F 3 "" H 7065 5725 50  0001 C CNN
F 4 "C17414" V 6885 3155 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F1002T5E" V 6885 3155 50  0001 C CNN "PartNumber"
	1    7065 5725
	1    0    0    -1  
$EndComp
Wire Wire Line
	7065 5185 7065 5135
$Comp
L power:GND #PWR0115
U 1 1 5BF374CA
P 7065 6015
F 0 "#PWR0115" H 7065 5765 50  0001 C CNN
F 1 "GND" H 7070 5842 50  0000 C CNN
F 2 "" H 7065 6015 50  0001 C CNN
F 3 "" H 7065 6015 50  0001 C CNN
	1    7065 6015
	1    0    0    -1  
$EndComp
Wire Wire Line
	7065 6015 7065 5875
Connection ~ 7065 5135
Wire Wire Line
	7065 5135 7065 5105
Wire Wire Line
	7065 5485 7065 5535
Wire Wire Line
	7065 5535 6815 5535
Connection ~ 7065 5535
Wire Wire Line
	7065 5535 7065 5575
Text GLabel 3425 2280 0    50   Input ~ 0
VREF
Text Notes 8890 4570 0    50   ~ 0
4 PIN ULTRA SMALL SSOP\nPHOTOTRANSISTOR PHOTOCOUPLER EL3H7-G Series\n
Wire Wire Line
	2655 2710 3425 2710
Wire Wire Line
	5325 5895 5615 5895
$Comp
L Device:R R14
U 1 1 5CB1F559
P 8915 3375
F 0 "R14" H 8985 3421 50  0000 L CNN
F 1 "510OHMS" H 8985 3315 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 8845 3375 50  0001 C CNN
F 3 "" H 8915 3375 50  0001 C CNN
F 4 "C17734" V 4095 4915 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F5100T5E" V 4095 4915 50  0001 C CNN "PartNumber"
	1    8915 3375
	0    1    1    0   
$EndComp
Wire Wire Line
	1355 2670 1355 2785
Wire Wire Line
	9940 4860 10190 4860
Wire Wire Line
	9940 5060 10190 5060
Wire Wire Line
	9670 5620 10040 5620
Wire Wire Line
	9600 5720 10040 5720
Wire Wire Line
	4525 5535 4625 5535
Text Notes 9955 4130 0    50   ~ 0
MOSFET N TRENCH 30V 5.7A \n1.5V @ 250UA \n26.5 @ 5.7A\n10V SOT-23-3L ROHS
$Comp
L Device:R R30
U 1 1 5E15FED3
P 8420 2375
F 0 "R30" H 8490 2421 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 8490 2330 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8350 2375 50  0001 C CNN
F 3 "" H 8420 2375 50  0001 C CNN
F 4 "C270971" V 2730 4795 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 2730 4795 50  0001 C CNN "PartNumber"
F 6 "" H 8420 2375 50  0001 C CNN "JLCPCBRotation"
	1    8420 2375
	1    0    0    -1  
$EndComp
$Comp
L Device:R R26
U 1 1 5E15FEBB
P 8420 2035
F 0 "R26" H 8490 2081 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 8490 1990 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8350 2035 50  0001 C CNN
F 3 "" H 8420 2035 50  0001 C CNN
F 4 "C270971" V 3430 4455 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 3430 4455 50  0001 C CNN "PartNumber"
F 6 "" H 8420 2035 50  0001 C CNN "JLCPCBRotation"
	1    8420 2035
	1    0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 5E15FEAF
P 8420 1695
F 0 "R24" H 8490 1741 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 8170 1975 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8350 1695 50  0001 C CNN
F 3 "" H 8420 1695 50  0001 C CNN
F 4 "C270971" V 3770 4115 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 3770 4115 50  0001 C CNN "PartNumber"
F 6 "" H 8420 1695 50  0001 C CNN "JLCPCBRotation"
	1    8420 1695
	1    0    0    -1  
$EndComp
Wire Wire Line
	8710 1845 8710 1885
$Comp
L Device:R R29
U 1 1 5E15609A
P 8710 2375
F 0 "R29" H 8780 2421 50  0000 L CNN
F 1 "3.3OHM 3/4W" V 8780 2330 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8640 2375 50  0001 C CNN
F 3 "" H 8710 2375 50  0001 C CNN
F 4 "C270971" V 3020 4795 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 3020 4795 50  0001 C CNN "PartNumber"
F 6 "" H 8710 2375 50  0001 C CNN "JLCPCBRotation"
	1    8710 2375
	1    0    0    -1  
$EndComp
$Comp
L Device:R R22
U 1 1 5E156076
P 8710 1695
F 0 "R22" H 8780 1741 50  0000 L CNN
F 1 "3.3OHM 3/4W" V 8780 1650 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8640 1695 50  0001 C CNN
F 3 "" H 8710 1695 50  0001 C CNN
F 4 "C270971" V 4060 4115 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 4060 4115 50  0001 C CNN "PartNumber"
F 6 "" H 8710 1695 50  0001 C CNN "JLCPCBRotation"
	1    8710 1695
	1    0    0    -1  
$EndComp
Wire Wire Line
	8980 1845 8980 1885
$Comp
L Device:R R12
U 1 1 5BF29ADC
P 8980 2375
F 0 "R12" H 9030 2425 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 9070 2320 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8910 2375 50  0001 C CNN
F 3 "" H 8980 2375 50  0001 C CNN
F 4 "C270971" V 3290 4795 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 3290 4795 50  0001 C CNN "PartNumber"
F 6 "" H 8980 2375 50  0001 C CNN "JLCPCBRotation"
	1    8980 2375
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5BF29A02
P 8980 2035
F 0 "R8" H 9050 2081 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 9075 1995 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8910 2035 50  0001 C CNN
F 3 "" H 8980 2035 50  0001 C CNN
F 4 "C270971" V 3990 4455 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 3990 4455 50  0001 C CNN "PartNumber"
F 6 "" H 8980 2035 50  0001 C CNN "JLCPCBRotation"
	1    8980 2035
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5BF274CC
P 8980 1695
F 0 "R6" H 9050 1741 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 8260 2245 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8910 1695 50  0001 C CNN
F 3 "" H 8980 1695 50  0001 C CNN
F 4 "C270971" V 4330 4115 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 4330 4115 50  0001 C CNN "PartNumber"
F 6 "" H 8980 1695 50  0001 C CNN "JLCPCBRotation"
	1    8980 1695
	1    0    0    -1  
$EndComp
Wire Wire Line
	8420 1845 8420 1885
Text Notes 3985 2380 0    39   ~ 0
Diodes Incorporated\nVOLTAGE REFERENCES 1.25V ??0.5% \n20PPM/??C
Wire Wire Line
	3565 2400 3565 2280
Wire Wire Line
	3565 2220 3765 2220
Wire Wire Line
	3565 2280 3425 2280
Connection ~ 3565 2280
Wire Wire Line
	3565 2280 3565 2220
Wire Wire Line
	3425 2280 3425 2710
$Comp
L Device:Polyfuse_Small F1
U 1 1 5E2313BD
P 5045 5895
F 0 "F1" V 4840 5895 50  0000 C CNN
F 1 "mSMD150" V 4965 5805 50  0000 C CNN
F 2 "Fuse:Fuse_1812_4532Metric" H 5095 5695 50  0001 L CNN
F 3 "https://datasheet.lcsc.com/szlcsc/TECHFUSE-mSMD150_C70121.pdf" H 5045 5895 50  0001 C CNN
F 4 "C70121" V 5045 5895 50  0001 C CNN "LCSCStockCode"
F 5 "mSMD150" H 5045 5895 50  0001 C CNN "PartNumber"
	1    5045 5895
	0    1    1    0   
$EndComp
Wire Wire Line
	4525 5635 4655 5635
Wire Wire Line
	4655 5635 4655 5895
Wire Wire Line
	4655 5895 4945 5895
Wire Wire Line
	5145 5895 5225 5895
Connection ~ 5325 5895
Text Notes 4400 6125 0    39   ~ 0
mSMD150, 8V MAX, FUSE HOLD @ 1.5AMP, TRIP 3A
Wire Wire Line
	8710 1545 8420 1545
$Comp
L Device:R R25
U 1 1 5E156082
P 8710 2035
F 0 "R25" H 8780 2081 50  0000 L CNN
F 1 "3.3OHM 3/4W" V 8875 475 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 8640 2035 50  0001 C CNN
F 3 "" H 8710 2035 50  0001 C CNN
F 4 "C270971" V 3720 4455 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 3720 4455 50  0001 C CNN "PartNumber"
F 6 "" H 8710 2035 50  0001 C CNN "JLCPCBRotation"
	1    8710 2035
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5E5CCCD1
P 3930 4630
F 0 "#PWR02" H 3930 4380 50  0001 C CNN
F 1 "GND" H 3935 4457 50  0000 C CNN
F 2 "" H 3930 4630 50  0001 C CNN
F 3 "" H 3930 4630 50  0001 C CNN
	1    3930 4630
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5E5CDAE4
P 4055 4430
F 0 "C4" H 4285 4485 50  0000 R CNN
F 1 "22pF" H 4355 4380 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4093 4280 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Samsung-Electro-Mechanics-CL10C220JB8NNNC_C1653.pdf" H 4055 4430 50  0001 C CNN
F 4 "C1804" H 4055 4430 50  0001 C CNN "LCSCStockCode"
F 5 "CL21C220JBANNNC" H 4055 4430 50  0001 C CNN "PartNumber"
	1    4055 4430
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5E5CEDD4
P 3795 4425
F 0 "C5" H 3681 4471 50  0000 R CNN
F 1 "22pF" H 3681 4380 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3833 4275 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Samsung-Electro-Mechanics-CL10C220JB8NNNC_C1653.pdf" H 3795 4425 50  0001 C CNN
F 4 "C1804" H 3795 4425 50  0001 C CNN "LCSCStockCode"
F 5 "CL21C220JBANNNC" H 3795 4425 50  0001 C CNN "PartNumber"
F 6 "0" H 3795 4425 50  0001 C CNN "JLCPCBRotation"
	1    3795 4425
	1    0    0    -1  
$EndComp
Wire Wire Line
	3995 4160 4055 4160
Connection ~ 4055 4160
Wire Wire Line
	2655 3710 3795 3710
Wire Wire Line
	3795 3710 3795 4160
Wire Wire Line
	2655 3610 4055 3610
Wire Wire Line
	4055 3610 4055 4160
Wire Wire Line
	4055 4580 4055 4630
Wire Wire Line
	4055 4160 4055 4280
Text Notes 7340 5330 0    39   ~ 0
NTC THERMISTORS 10KOHMS\n ??1% 3950K 0805 ROHS
Wire Wire Line
	9345 3205 9765 3205
Wire Wire Line
	4425 3310 4425 3450
Wire Wire Line
	4135 3310 4425 3310
$Comp
L power:GND #PWR0114
U 1 1 5BF6AC33
P 4425 3450
F 0 "#PWR0114" H 4425 3200 50  0001 C CNN
F 1 "GND" H 4430 3277 50  0000 C CNN
F 2 "" H 4425 3450 50  0001 C CNN
F 3 "" H 4425 3450 50  0001 C CNN
	1    4425 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R18
U 1 1 5BF67C7F
P 3985 3310
F 0 "R18" V 3905 3240 50  0000 L CNN
F 1 "2.2KOHMS" V 4075 3190 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3915 3310 50  0001 C CNN
F 3 "" H 3985 3310 50  0001 C CNN
F 4 "C17520" V 1855 4350 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F2201T5E" V 1855 4350 50  0001 C CNN "PartNumber"
F 6 "0" V 3985 3310 50  0001 C CNN "JLCPCBRotation"
	1    3985 3310
	0    1    1    0   
$EndComp
Text Notes 5035 3130 0    50   ~ 0
ADC3=Output voltage 1.25V \n       for input of 4.398V (max)
Wire Wire Line
	4850 3010 4850 2970
Connection ~ 4850 3010
Wire Wire Line
	4850 3490 4850 3360
$Comp
L power:GND #PWR0108
U 1 1 5D20309D
P 4850 3490
F 0 "#PWR0108" H 4850 3240 50  0001 C CNN
F 1 "GND" H 4855 3317 50  0000 C CNN
F 2 "" H 4850 3490 50  0001 C CNN
F 3 "" H 4850 3490 50  0001 C CNN
	1    4850 3490
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5D200A38
P 4850 2820
F 0 "R3" H 4920 2866 50  0000 L CNN
F 1 "6.8K" H 4920 2775 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4780 2820 50  0001 C CNN
F 3 "" H 4850 2820 50  0001 C CNN
F 4 "C17772" V 3130 3250 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F6801T5E" V 3130 3250 50  0001 C CNN "PartNumber"
	1    4850 2820
	1    0    0    -1  
$EndComp
Wire Wire Line
	2655 3010 4850 3010
Wire Wire Line
	2655 3910 2655 4375
Wire Wire Line
	3795 4160 3795 4275
Connection ~ 3795 4160
$Comp
L Device:Crystal_Small Y1
U 1 1 5E5E68B4
P 3895 4160
F 0 "Y1" H 3915 4340 50  0000 C CNN
F 1 "8MHZ Ceramic Resonator" H 4585 4255 50  0000 C CNN
F 2 "Crystal:Crystal_SMD_5032-2Pin_5.0x3.2mm" H 3895 4160 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/1903061615_Yangxing-Tech-X50328MSB2GI_C115962.pdf" H 3895 4160 50  0001 C CNN
F 4 "C115962" H 3895 4160 50  0001 C CNN "LCSCStockCode"
F 5 "X50328MSB2GI" H 3895 4160 50  0001 C CNN "PartNumber"
	1    3895 4160
	1    0    0    -1  
$EndComp
Text Notes 4435 4455 0    50   ~ 0
8Mhz used in CKDIV8 mode to \npower on at 1Mhz,\ncode then swaps to \n2Mhz using clock prescaler
Text Notes 620  1330 0    79   ~ 16
Modified DIYBMS v4 CELL MONITORING MODULE\n\nVERSION 4.40\n\nFOR LITHIUM VOLTAGE RANGES (18650 etc.) 0 - 4.2V
Wire Wire Line
	3795 4630 3930 4630
Wire Wire Line
	3795 4630 3795 4575
Connection ~ 3930 4630
Wire Wire Line
	3930 4630 4055 4630
$Comp
L Device:C C2
U 1 1 601A4C70
P 890 2520
F 0 "C2" H 776 2566 50  0000 R CNN
F 1 "1uF" H 776 2475 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 928 2370 50  0001 C CNN
F 3 "" H 890 2520 50  0001 C CNN
F 4 "C28323" H 890 2520 50  0001 C CNN "LCSCStockCode"
F 5 "CL21B105KBFNNNE" H 890 2520 50  0001 C CNN "PartNumber"
	1    890  2520
	1    0    0    -1  
$EndComp
Wire Wire Line
	890  2370 890  2250
Wire Wire Line
	890  2250 1355 2250
Connection ~ 1355 2250
Wire Wire Line
	890  2670 890  2785
Wire Wire Line
	890  2785 1355 2785
Connection ~ 1355 2785
Wire Wire Line
	1355 2785 1355 4230
Wire Notes Line
	8440 4325 8440 6445
Wire Notes Line
	8315 6435 11010 6435
Wire Notes Line
	11010 6435 11010 4280
Wire Notes Line
	11135 4290 8440 4290
Wire Notes Line
	8250 6410 8250 4670
Text GLabel 6815 5535 0    50   Input ~ 0
SCK
Text Notes 6850 4990 0    50   ~ 0
Internal temp sensor
Wire Notes Line
	8225 4720 6560 4720
Wire Notes Line
	6560 4720 6560 6430
Wire Notes Line
	6560 6430 8255 6430
Text GLabel 7065 5105 2    50   Input ~ 0
VREF
$Comp
L Device:D D2
U 1 1 60168E2F
P 5225 5525
F 0 "D2" V 5179 5605 50  0000 L CNN
F 1 "SMBJ5.0A" V 5270 5605 50  0000 L CNN
F 2 "Diode_SMD:D_SMB" H 5225 5525 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/1912111437_AnBon-SMBJ5-0A_C440263.pdf" H 5225 5525 50  0001 C CNN
F 4 "C440263" V 5225 5525 50  0001 C CNN "LCSCStockCode"
F 5 "0" V 5225 5525 50  0001 C CNN "JLCPCBRotation"
	1    5225 5525
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5225 5675 5225 5895
Connection ~ 5225 5895
Wire Wire Line
	5225 5895 5325 5895
Wire Wire Line
	5225 5375 5225 5285
Wire Wire Line
	5225 5285 4925 5285
Connection ~ 4925 5285
Text Notes 5290 5660 0    39   ~ 0
UNIDIRECTIONAL 5V TVS 
Wire Wire Line
	5225 5285 5675 5285
Wire Wire Line
	4625 5285 4925 5285
Connection ~ 5225 5285
Text Notes 7300 1600 0    47   ~ 0
CHIP RESISTOR - SURFACE MOUNT 3.3OHMS ??1% 3/4W 2010 ROHS, \n3 in series with 3 in parallel gives 3.30 Ohm equivalent resistance\n\n18 resistors provide 2*9*0.75W=13.5W of power disipation.\n\nBalance current (at 3.3ohm) (these calculations only use 9 resistors):\n1.27A at 4.2V and 5.35W power\n1.21A at 4.0V and 4.84W power\n1.13A at 3.75V and 4.26W power\n\n\n
Wire Wire Line
	4850 3060 4850 3010
$Comp
L Device:R R4
U 1 1 5D200BDC
P 4850 3210
F 0 "R4" H 4920 3256 50  0000 L CNN
F 1 "2.7K" H 4920 3165 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4780 3210 50  0001 C CNN
F 3 "" H 4850 3210 50  0001 C CNN
F 4 "C17530" V 3130 3250 50  0001 C CNN "LCSCStockCode"
F 5 "0805W8F2701T5E" V 3130 3250 50  0001 C CNN "PartNumber"
	1    4850 3210
	1    0    0    -1  
$EndComp
Wire Wire Line
	10515 2525 10515 3505
Wire Wire Line
	2655 3210 2885 3210
Text GLabel 2885 3210 2    50   Input ~ 0
MISO
Text GLabel 2875 3110 2    50   Input ~ 0
SCK
Wire Wire Line
	2655 3110 2875 3110
Wire Wire Line
	3755 3310 3835 3310
$Comp
L Device:LED D4
U 1 1 5BF67C78
P 3605 3310
F 0 "D4" H 3745 3410 50  0000 C CNN
F 1 "Blue" H 3565 3400 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 3605 3310 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Hubei-KENTO-Elec-Green-0805-Iv-207-249-mcd-atIF-20mA_C2297.pdf" H 3605 3310 50  0001 C CNN
F 4 "C2293" H 3605 3310 50  0001 C CNN "LCSCStockCode"
F 5 "Blue LED" H 3605 3310 50  0001 C CNN "PartNumber"
	1    3605 3310
	-1   0    0    1   
$EndComp
Connection ~ 8710 2525
Wire Wire Line
	8710 2525 8420 2525
$Comp
L power:VCC #PWR0103
U 1 1 6098E5F5
P 9830 1545
F 0 "#PWR0103" H 9830 1395 50  0001 C CNN
F 1 "VCC" H 9847 1718 50  0000 C CNN
F 2 "" H 9830 1545 50  0001 C CNN
F 3 "" H 9830 1545 50  0001 C CNN
	1    9830 1545
	1    0    0    -1  
$EndComp
$Comp
L Device:R R37
U 1 1 6098E5FF
P 9540 2375
F 0 "R37" H 9610 2421 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 9610 2330 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 9470 2375 50  0001 C CNN
F 3 "" H 9540 2375 50  0001 C CNN
F 4 "C270971" V 3850 4795 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 3850 4795 50  0001 C CNN "PartNumber"
F 6 "" H 9540 2375 50  0001 C CNN "JLCPCBRotation"
	1    9540 2375
	1    0    0    -1  
$EndComp
$Comp
L Device:R R38
U 1 1 6098E608
P 9540 2035
F 0 "R38" H 9610 2081 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 9610 1990 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 9470 2035 50  0001 C CNN
F 3 "" H 9540 2035 50  0001 C CNN
F 4 "C270971" V 4550 4455 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 4550 4455 50  0001 C CNN "PartNumber"
F 6 "" H 9540 2035 50  0001 C CNN "JLCPCBRotation"
	1    9540 2035
	1    0    0    -1  
$EndComp
$Comp
L Device:R R39
U 1 1 6098E611
P 9540 1695
F 0 "R39" H 9610 1741 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 9290 1975 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 9470 1695 50  0001 C CNN
F 3 "" H 9540 1695 50  0001 C CNN
F 4 "C270971" V 4890 4115 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 4890 4115 50  0001 C CNN "PartNumber"
F 6 "" H 9540 1695 50  0001 C CNN "JLCPCBRotation"
	1    9540 1695
	1    0    0    -1  
$EndComp
Wire Wire Line
	9830 1845 9830 1885
$Comp
L Device:R R34
U 1 1 6098E61B
P 9830 2375
F 0 "R34" H 9900 2421 50  0000 L CNN
F 1 "3.3OHM 3/4W" V 9900 2330 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 9760 2375 50  0001 C CNN
F 3 "" H 9830 2375 50  0001 C CNN
F 4 "C270971" V 4140 4795 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 4140 4795 50  0001 C CNN "PartNumber"
F 6 "" H 9830 2375 50  0001 C CNN "JLCPCBRotation"
	1    9830 2375
	1    0    0    -1  
$EndComp
$Comp
L Device:R R36
U 1 1 6098E624
P 9830 1695
F 0 "R36" H 9900 1741 50  0000 L CNN
F 1 "3.3OHM 3/4W" V 9900 1650 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 9760 1695 50  0001 C CNN
F 3 "" H 9830 1695 50  0001 C CNN
F 4 "C270971" V 5180 4115 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 5180 4115 50  0001 C CNN "PartNumber"
F 6 "" H 9830 1695 50  0001 C CNN "JLCPCBRotation"
	1    9830 1695
	1    0    0    -1  
$EndComp
$Comp
L Device:R R31
U 1 1 6098E62E
P 10100 2375
F 0 "R31" H 10150 2425 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 10190 2320 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 10030 2375 50  0001 C CNN
F 3 "" H 10100 2375 50  0001 C CNN
F 4 "C270971" V 4410 4795 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 4410 4795 50  0001 C CNN "PartNumber"
F 6 "" H 10100 2375 50  0001 C CNN "JLCPCBRotation"
	1    10100 2375
	1    0    0    -1  
$EndComp
$Comp
L Device:R R32
U 1 1 6098E637
P 10100 2035
F 0 "R32" H 10170 2081 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 10195 1995 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 10030 2035 50  0001 C CNN
F 3 "" H 10100 2035 50  0001 C CNN
F 4 "C270971" V 5110 4455 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 5110 4455 50  0001 C CNN "PartNumber"
F 6 "" H 10100 2035 50  0001 C CNN "JLCPCBRotation"
	1    10100 2035
	1    0    0    -1  
$EndComp
Wire Wire Line
	9540 1845 9540 1885
Wire Wire Line
	9830 1545 9540 1545
$Comp
L Device:R R35
U 1 1 6098E64F
P 9830 2035
F 0 "R35" H 9900 2081 50  0000 L CNN
F 1 "3.3OHM 3/4W" V 9995 475 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 9760 2035 50  0001 C CNN
F 3 "" H 9830 2035 50  0001 C CNN
F 4 "C270971" V 4840 4455 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 4840 4455 50  0001 C CNN "PartNumber"
F 6 "" H 9830 2035 50  0001 C CNN "JLCPCBRotation"
	1    9830 2035
	1    0    0    -1  
$EndComp
Wire Wire Line
	9540 2525 9830 2525
Connection ~ 9540 2525
$Comp
L Device:R R33
U 1 1 6098E640
P 10100 1695
F 0 "R33" H 10170 1741 50  0000 L CNN
F 1 "3.3OHM 3/4W" H 9380 2245 50  0001 L CNN
F 2 "Resistor_SMD:R_2010_5025Metric" V 10030 1695 50  0001 C CNN
F 3 "" H 10100 1695 50  0001 C CNN
F 4 "C270971" V 5450 4115 50  0001 C CNN "LCSCStockCode"
F 5 "201007F330KT4E" V 5450 4115 50  0001 C CNN "PartNumber"
F 6 "" H 10100 1695 50  0001 C CNN "JLCPCBRotation"
	1    10100 1695
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 2525 10515 2525
Wire Wire Line
	10100 2525 9830 2525
Connection ~ 10100 2525
Connection ~ 9830 2525
Connection ~ 8980 2525
Wire Wire Line
	8980 2525 9540 2525
Wire Wire Line
	8710 2525 8980 2525
Connection ~ 8710 1545
Wire Wire Line
	8980 1545 8710 1545
Connection ~ 9830 1545
Wire Wire Line
	9830 1545 10100 1545
Wire Wire Line
	10100 2225 10100 2185
Wire Wire Line
	10100 1885 10100 1845
Wire Wire Line
	9540 2225 9540 2185
Wire Wire Line
	9830 2225 9830 2185
Wire Wire Line
	8980 2225 8980 2185
Wire Wire Line
	8710 2225 8710 2185
Wire Wire Line
	8420 2225 8420 2185
$EndSCHEMATC
