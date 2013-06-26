/*
  Gate-keeper based on the exemple : Web client
 
 This sketch connects to a server
 using an Arduino Wiznet Ethernet shield. 
 
 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13
 
 created 26 Juin 2013
 modified 
 by Hervé LAUNAY
 
 */

#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; // TODO !!
IPAddress server(192,168,0,20); // TODO !!

// Initialize the Ethernet client library
// with the IP address and port of the server 
// that you want to connect to (port 80 is default for HTTP):
EthernetClient client;

void setup() {
 // Open serial communications and wait for port to open:
  Serial.begin(9600);
   while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // start the Ethernet connection:
  if (Ethernet.begin(mac) == 0) {
    Serial.println("Failed to configure Ethernet using DHCP");
    
    // no point in carrying on, so do nothing forevermore:
    for(;;)
      ;
  }
  // give the Ethernet shield a second to initialize:
  delay(1000);
}

void loop()
{
  Serial.println("connecting...");

  // if you get a connection, report back via serial:
  if (client.connect(server, 80)) {
    Serial.println("connected");
    
    // Make a HTTP request:
    client.println("GET /members/1 HTTP/1.0");
    client.println();
    
    // if there are incoming bytes available 
    // from the server, read them and print them:
    while (client.available()) {
      char c = client.read();
      Serial.print(c);
      // TODO keep read bytes
    }
    
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
    
    // TODO process read bytes

  } 
  else {
    // kf you didn't get a connection to the server:
    Serial.println("connection failed");
  }
 
  delay(1000);
}

