#include "DHT.h"
#include <SPI.h>
#include <Ethernet.h>
#include <SoftwareSerial.h>

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; 

SoftwareSerial bluetooth(2, 3);

char Incoming_value = 0;    
unsigned long tempo = 0;    

float humidityData;
float temperatureData;

/*
  ZMIENNE KONFIGURACYJNE !!!!!!!!!!!!!!!!!!!!!
*/

int arduino_id = 88;
int temp = 1; 

/*
  ZMIENNE KONFIGURACYJNE !!!!!!!!!!!!!!!!!!!!!
*/

#define DHTPIN 7
#define DHTTYPE DHT11

#define intervallo 2000  

DHT dht(DHTPIN,DHTTYPE);

char server[] = "192.168.100.20";
IPAddress ip(192,168,100,24); 
EthernetClient client; 

void setup() {
  Serial.begin(9600);
  dht.begin();
  if (Ethernet.begin(mac) == 0) {
  Serial.println("Failed to configure Ethernet using DHCP");
  Ethernet.begin(mac, ip);
  }

  bluetooth.begin(9600);

  pinMode(5, OUTPUT); //Dioda czerwona
  pinMode(9, OUTPUT); //Dioda żółta
  pinMode(8, OUTPUT); //Dioda zielona
  digitalWrite(5, LOW); 
  digitalWrite(9, LOW);
  digitalWrite(8, LOW);

  delay(1000);
}
//------------------------------------------------------------------------------


/* Infinite Loop */
void loop(){
  if ((millis()-tempo)>intervallo)
  {
  temperatureData = dht.readTemperature();
  bluetooth.print(temperatureData); 
  Serial.print("temperatura: ");
  Serial.print(temperatureData);

  bluetooth.print("-");   
  
  humidityData = dht.readHumidity();
  bluetooth.print(humidityData); 
  Serial.print(" - umidità: ");
  Serial.println(humidityData);

  bluetooth.print("");

  tempo = millis();
  }

if(bluetooth.available() > 0)  
  {
    Incoming_value = bluetooth.read();      
    bluetooth.print("\n");        

    if (Incoming_value == '0') {
    digitalWrite(5, LOW);
    digitalWrite(9, LOW);
    digitalWrite(8, HIGH);
  }
  else if (Incoming_value == '1') {
    digitalWrite(5, HIGH);
    digitalWrite(9, LOW);
    digitalWrite(8, LOW);
  }
  else if (Incoming_value == '2') {
    digitalWrite(5, LOW);
    digitalWrite(9, HIGH);
    digitalWrite(8, LOW);
  }
  else if (Incoming_value == '3') {
    digitalWrite(5, LOW);
    digitalWrite(9, LOW);
    digitalWrite(8, HIGH);
  }
  } 

  Sending_To_phpmyadmindatabase();

  delay(1000);
}

void Sending_To_phpmyadmindatabase() 
 {
   if (client.connect(server, 80)) {
    Serial.println("connected");
    // Make a HTTP request:
    Serial.print("GET /dht.php?humidity=");
    client.print("GET /dht.php?humidity=");     
    Serial.println(humidityData);
    client.print(humidityData);
    client.print("&temperature=");
    Serial.println("&temperature=");
    client.print(temperatureData);
    Serial.println(temperatureData);
    client.print("&arduino_id=");
    Serial.println("&arduino_id=");
    client.print(arduino_id);
    Serial.println(arduino_id);
    client.print("&temp=");
    Serial.println("&temp=");
    client.print(temp);
    Serial.println(temp);
    client.print(" ");  
    client.print("HTTP/1.1");
    client.println();
    client.println("Host: 192.168.100.20");
    client.println("Connection: close");
    client.println();
  } else {
    Serial.println("connection failed");
  }
 }
