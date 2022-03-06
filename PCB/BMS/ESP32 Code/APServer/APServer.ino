#include <WiFi.h>
#include <WiFiClient.h>
#include <WebServer.h>
#include <ESPmDNS.h>
#include <Update.h>
#include <FS.h>
#include <LittleFS.h> // SPIFFS is being depricated in favor of LittleFS
#include <stdlib.h>

bool efficiencyMode = false; // Determines if the BMS is on the surface charging or if it should prioritize low power draw while in use

// DIP Switch pins
const int DIP[3] = {46, 45, 44};

// Voltage readings (When we do this for real we will probably write to a file on the sd card or something)
float voltage_readings[500];
int voltage_index = 0;
String readings_to_string(float* readings, int size);


// Wifi network information. This is only used for simple testing and will not work when we move to using the actual board on the GT campus due to difficulties with connecting remote devices to eduroam. 
// At that point we will switch to having the ESP32 broadcast a wifi network that redirects you to a captive portal instead.
// Another possibility would be to get a router for the lab, that way we could network all of the batteries together and have a single monitoring webpage or something for them
const char* host = "esp32";
const char* ssid = "SSID Goes Here";
const char* password = "Password Goes Here";

WebServer server(80);

/* setup function */
void setup(void) {

  // (not working on devboard, may have external pulldown or something)
  //pinMode(DIP[0], INPUT_PULLUP);

  // efficiencyMode is true if the dip switch is pulled down to ground
  //efficiencyMode = (digitalRead(DIP[0]) == LOW);
  efficiencyMode=false;

  // Mount the LittleFS filesystem, passing true tells it to reformat the partition if it fails to mount
  if(!LittleFS.begin(true)){
    Serial.println("An Error has occurred while mounting LittleFS");
  }

  // Generate the data folder if it doesn't already exist
  if (!LittleFS.exists("/data")) {
    LittleFS.mkdir("/data");
  }

  // DIP0 is set to efficiency mode
  if (efficiencyMode) {
    // Disable the wifi radio to save power
    WiFi.mode(WIFI_OFF);

  // DIP0 is not set to efficiency mode, enable wifi and other testing services
  } else {
    Serial.begin(115200);


    // Connect to WiFi network
    WiFi.begin(ssid, password);
    Serial.println("");
  
    // Wait for connection
    while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
    }
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(ssid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
  
    /*use mdns for host name resolution*/
    // If we have multiple of these we may need to start giving them id numbers or something
    if (!MDNS.begin("bms")) { //http://bms.local
      Serial.println("Error setting up MDNS responder!");
    } else {
      Serial.println("mDNS responder started");
    }
    

    // Serve the index.html file and force the browser to not cache the page
    server.serveStatic("/", LittleFS, "/data/index.html", "no-cache, no-store");
    
    // Handle updating firmware file
    server.on("/update", HTTP_POST, []() {
      server.sendHeader("Connection", "close");
      server.send(200, "text/plain", (Update.hasError()) ? "FAIL" : "OK");
      delay(10); // Give the response time to be sent
      ESP.restart();
    }, []() {
      HTTPUpload& upload = server.upload();
      if (upload.status == UPLOAD_FILE_START) {
        Serial.printf("Update: %s\n", upload.filename.c_str());
        if (!Update.begin(UPDATE_SIZE_UNKNOWN)) { //start with max available size
          Update.printError(Serial);
        }
      } else if (upload.status == UPLOAD_FILE_WRITE) {
        /* flashing firmware to ESP*/
        if (Update.write(upload.buf, upload.currentSize) != upload.currentSize) {
          Update.printError(Serial);
        }
      } else if (upload.status == UPLOAD_FILE_END) {
        if (Update.end(true)) { //true to set the size to the current progress
          Serial.printf("Update Successful: %u\nRebooting...\n", upload.totalSize);
        } else {
          Update.printError(Serial);
        }
      }
    });

    // Handle uploading LittleFS files
    server.on("/upload", HTTP_POST, []() {
      // We could add javascript to the sending form to prevent it from getting
      // redirected every time you upload a file but this is fine for now
      server.sendHeader("Connection", "close");  
      server.send(200, "text/plain", (false) ? "FAIL" : "OK");
    }, []() {
      HTTPUpload& upload = server.upload();

      // This function gets called multiple times so the file does not stay open the whole time
      // It must be appended to then closed after each set of bytes uploaded
      File file;
      String filePath = upload.name + "/" + upload.filename;
      if (upload.status == UPLOAD_FILE_START) {
        // Create the file or erase the existing version
        file = LittleFS.open(filePath, FILE_WRITE, true);
        file.close();
      } else if (upload.status == UPLOAD_FILE_WRITE) {
        // Append the uploaded bytes to the file
        file = LittleFS.open(filePath, FILE_APPEND);
        file.write(upload.buf, upload.currentSize);
        file.close();
      } else if (upload.status == UPLOAD_FILE_END) {
        file = LittleFS.open(filePath, FILE_READ);
      }
    });

    // Handle creating new folders
    server.on("/mkdir", HTTP_POST, []() {
      bool result = false;
      // Just in case the partition gets messed up
      if (server.arg(0) == "FormatDevicePartition") {
        result = LittleFS.format();
        LittleFS.mkdir("/data");
      } else {
        String filePath = server.arg(1) + "/" + server.arg(0);
        result = LittleFS.mkdir(filePath);
      }

      server.sendHeader("Connection", "close");  
      server.send(200, "text/plain", (result) ? "OK" : "FAIL");
    });


    // Handle displaying folders and downloading files
    server.onNotFound([](){
      File file = LittleFS.open(server.uri(), FILE_READ);

      if(file.isDirectory()) {
        // If its a directory then display the contents and forms for uploading files and creating new folders
        String html = "<div style='overflow:auto;'>\n";

        // Do not allow uploading files to the root '/' directory, highly recommend adding files only to '/data' and its subfolders
        if (server.uri() != "/") {
          // Add the file upload form
          html += "<form method='POST' action='/upload' enctype='multipart/form-data' style='padding:4;padding-bottom:10;padding-right:40;float:left'><input type='file' name='";
          html += server.uri();
          html += "'><input type='submit' value='Upload File'></form>\n";  
        } else {
          // Add instructions for how to set up the index.html file
          html += "<h1 style='color:red;'>Unable to find '/data/index.html' Add the file and restart the ESP32. If the page is still blank, also add '/data/chart.min.js'</h1><br><br>";  
        }
        
        // Add the new folder form
        html += "<div title='Make a new folder named FormatDevicePartition to completely erase all files by formatting the partition'>\n";
        html += "<form method='POST' action='/mkdir' name='New Folder' style='padding:4;padding-right:40;float:left'><input type='text' name='Folder Name'><input type='hidden' name='path' value='";
        html += server.uri();
        html += "'><input type='submit' value='New Folder'></form>\n</div>\n";

        // Add link back to main page
        html += "<form action='/' style='padding:4;'><input type='submit' value='View Homepage'></form>\n";

        html += "</div>\n";

        // Add Data used indicator
        html += "Used ";
        html += LittleFS.usedBytes()/1000.0;
        html += "KB / ";
        html += LittleFS.totalBytes()/1000.0;
        html += "KB<br><br>\n";

        // Add path to current folder
        html += server.uri();
        html += "/:<br>\n";

        // Loop through the files/directories in the folder and add them to the html response
        File subfile = file.openNextFile();
        while(subfile) {
          bool dir = subfile.isDirectory();
          
          html += "<a style='margin-left:20' href='";
          html += subfile.path();

          // Link to the folder if its a directory or add add a download link if its a file
          html += dir ? "'>" : "' download>";
          
          html += subfile.name();
          html += dir ? "/" : "";
          html += "</a><br>\n";

          subfile = file.openNextFile();
      }

      server.sendHeader("Connection", "close");
      server.send(200, "text/html", html);
      } else {
        // If its a file then download it
        server.streamFile(file, "");
      }
    });

    /*handle returning voltage readings*/
    server.on("/voltages", HTTP_GET, []() {
      server.sendHeader("Connection", "close");
      server.send(200, "text/plain", readings_to_string(voltage_readings, voltage_index));
    });
    server.begin();
  }
}

void loop(void) {

  // DIP0 is set to high efficiency mode
  if (efficiencyMode) {
    // We don't have efficiency code yet
    
  // DIP0 is set to testing mode, run wifi and other testing services
  } else {
    server.handleClient();
    delay(1);

    // Generate sinusoid stand-in voltage readings from 0V to 16V (one time only)
    if (voltage_index < 500) {
      voltage_readings[voltage_index] = 8.0 - 8.0*cos(((float) voltage_index)/10.0);
      voltage_index++;
    }
  }
}

// This whole function will need to be rewritten to be actually reliable
// Switching the data over to json might be easiest
String readings_to_string(float* readings, int size) {
  String rtn = "";
  char buff[10];
  for (int i = 0; i < size; i++) {
    dtostrf(readings[i], 4, 6, buff);
    rtn += i;
    rtn += ", ";
    rtn += buff;

    // we don't want to add a newline after the last value
    if (i < size - 1) {
      rtn += "\n";
    }
  }

  String why = rtn; // Arduino String has serious problems, this line is necessary
  return rtn;
}
