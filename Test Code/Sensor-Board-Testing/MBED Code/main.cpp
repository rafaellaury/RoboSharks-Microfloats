#include "mbed.h"

Serial in(p28, p27); // tx, rx
DigitalOut led(LED1); // onboard LED 1

// Simple RS-232 Sensor Simulator
int main() {
     in.baud(9600); // initializes baud rate
     while(1) {
        in.putc(42); // puts 42 on the serial line
        led = !led; // blinks an LED to show the progress
        wait(3); // wait how ever long you want between sends
    }
}





//Serial pc(USBTX, USBRX);
//I2C out(p9, p10);
//const int address = 0x90;
/*
// OLD TESTING CODE --- IGNORE
int main() {
    double var[] = {0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0};
    int value = 1;
    char data[] ={};
    data[0] = 0x00; //Supposed internal register for data
    //out.write(address, data, 1);
    while(1){
    //Input over Serial bus to Sensor Input
    int i = 0;
    pc.printf("before\n");
    pc.printf("write: %d", (int) in.writeable());
    in.putc(value);
    pc.printf("after\n");
    /*
    while(i < 13) {
        //in.printf("Input: %f/n", var(i));
        in.putc(*(var+i));
        i++;
    
    //Read the Output from the I2C Bus
        out.read(address, data, 1);
        //pc.printf("Register Address: %c\n", data[0]);
        pc.printf("Output: %c\n", data[1]);
    
    //Wait 5 seconds between inputs
        wait(5); 
    pc.printf("before\n");
    pc.printf("Read: %d", (int) in.readable());
    pc.printf("Value: %d", in.getc());
    pc.printf("Afer\n");
    }
}
// OLD CODE --- IGNORE
*/
