/*
  Gate-keeper based on the exemple : Web client
 
 This sketch connects to a web server and ask if a Mifare ID card
 can do somthing.
 
 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13
 * Adafruit NFC shield attached to pins 2, 3 (I2C)
 * Green LED attached to pins 9
 * Red LED attached to pins 9
 * Buzzer on digital pin 8 
 
 created 26 June 2013
 by Hervé LAUNAY
 modified 28 July 2013
 by Baptiste Gaultier
 
 */

#define IRQ   (2)
#define RESET (3)  // Not connected by default on the NFC Shield

Adafruit_NFCShield_I2C nfc(IRQ, RESET);


// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = { 
  0x90, 0xA2, 0xDA, 0x0D, 0x6F, 0x1E };
IPAddress ip(192,168,1,20);

// initialize the library instance:
EthernetClient client;

const unsigned long requestInterval = 1000;  // delay between requests

char serverName[] = "server.com"; //server URL

unsigned long lastAttemptTime = 0;            // last time you connected to the server, in milliseconds

String currentLine = "";            // string to hold the response from server
String response = "";                  // string to hold the response
boolean readingResponse = false;       // if you're currently reading the response

void setup() {
  // reserve space for the strings:
  currentLine.reserve(256);
  response.reserve(150);
  
  // Open Serial communications and wait for port to open:
  Serial.begin(9600);
  
  // declare pin 6 and 9 and as outputs:
  pinMode(6, OUTPUT);
  pinMode(9, OUTPUT);
  
  // attempt a DHCP connection:
  Serial.println(F("Attempting to get an IP address using DHCP:"));
  if (!Ethernet.begin(mac)) {
    // if DHCP fails, start with a hard-coded address:
    Serial.println(F("failed to get an IP address using DHCP, trying manually"));
    Ethernet.begin(mac, ip);
  }
  Serial.print(F("My address:"));
  Serial.println(Ethernet.localIP());
  
  nfc.begin();
  
  unsigned long versiondata = nfc.getFirmwareVersion();
  if (! versiondata) {
    Serial.print(F("Didn't find PN53x board"));
    while (1); // halt
  }
  
  // Got ok data, print it out!
  Serial.print(F("Found chip PN5")); Serial.println((versiondata>>24) & 0xFF, HEX); 
  Serial.print(F("Firmware ver. ")); Serial.print((versiondata>>16) & 0xFF, DEC); 
  Serial.print('.'); Serial.println((versiondata>>8) & 0xFF, DEC);
  
  // configure board to read RFID tags
  nfc.SAMConfig();
  
  Serial.println(F("Waiting for an ISO14443A Card ..."));
  // Enable 8 seconds watchdog
  wdt_enable(WDTO_8S);	

}



void loop() {
  //Reset the watchdog timer.
  wdt_reset();
  if (client.connected()) {
    if (client.available()) {
      // read incoming bytes:
      char inChar = client.read();
      //Serial.print(F(inChar);

      // add incoming byte to end of line:
      currentLine += inChar; 

      // if you get a newline, clear the line:
      if (inChar == '\n') {
        currentLine = "";
      } 
      // if the current line ends with <status>, it will
      // be followed by the response:
      if ( currentLine.endsWith("<status>")) {
        // response is beginning. Clear the response string:
        readingResponse = true; 
        response = "";
      }
      // if you're currently reading the bytes of a response,
      // add them to the response String:
      if (readingResponse) {
        if (inChar != '<') {
          response += inChar;
        } 
        else {
          // if you got a "<" character,
          // you've reached the end of the response:
          readingResponse = false; 
          // close the connection to the server:
          client.stop();
          if(response.compareTo(">success") == 0) {
            fade(9);
            tone(8, NOTE_G5,1000);
            delay(1300);
            noTone(8);
            Serial.println(F("User is present in the database"));
          }
          else {
            fade(6);
            // 
            tone(8, NOTE_G2,1000);
            delay(1300);
            noTone(8);
            Serial.println(F("User is not present in the database"));
          }
          
        }
      }
    }   
  }
  else if (millis() - lastAttemptTime > requestInterval) {
         byte success;
         byte uid[] = { 0, 0, 0, 0, 0, 0, 0 };  // Buffer to store the returned UID
         byte uidLength;                        // Length of the UID (4 or 7 bytes depending on ISO14443A card type)
         
         // Wait for an ISO14443A type cards (Mifare, etc.).  When one is found
         // 'uid' will be populated with the UID, and uidLength will indicate
         // if the uid is 4 bytes (Mifare Classic) or 7 bytes (Mifare Ultralight)
         success = nfc.readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, &uidLength);
         
         if (success) {
           // Display some basic information about the card
           Serial.println(F("Found an ISO14443A card"));
           Serial.print(F("  UID Length: "));
           Serial.print(uidLength, DEC);
           Serial.println(F(" bytes"));
           Serial.print(F("  UID Value: "));
           nfc.PrintHex(uid, uidLength);
           
           String uidString = "";
           
           for(byte i=0; i < 4; i++) {
             uidString += String(uid[i], HEX);
           }
           if(uidString.length() == 7)
             uidString += "0";
           uidString.toUpperCase();
           Serial.print(F(" uid string : "));
           Serial.println(uidString);
           
           // if you're not connected a new tag has been found
           httpRequest(uidString);
         }
       }
}

void httpRequest(String uidString) {
  // attempt to connect, and wait a millisecond:
  Serial.println(F("Connecting to server..."));
  if (client.connect(serverName, 80)) {
    Serial.println(F("Making HTTP request..."));
    // make HTTP GET request to twitter:
    Serial.print(F("GET /members/"));
    Serial.println(uidString);
    client.print("GET /members/"");
    client.print(uidString);
    client.println(" HTTP/1.1");
    client.println("HOST: server.com");
    client.println();
  }
  // note the time of this connect attempt:
  lastAttemptTime = millis();
}

void fade(byte pin) {
  for (int brightness = 0; brightness < 200; brightness++) {
    // set the brightness of pin 9:
    analogWrite(pin, brightness);
    delay(5);
  }
  for (int brightness = 200; brightness >= 0; brightness--) {
    // set the brightness of pin 9:
    analogWrite(pin, brightness);
    delay(5);
  }
  analogWrite(pin, 0);
  delay(1000);    
}

