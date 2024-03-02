#include <WiFi.h>
#include <WiFiUdp.h>
#include <Servo.h>

WiFiUDP udp;
Servo myservo;

char packetBuffer[255];
const char * ssid = "UDP_TEST";
unsigned int localPort = 4210;

void receivedPacket(int size);
void motors(int speed);

//Motors pins for NodeMcu v2
const int pwmMotorA = 5;
const int pwmMotorB = 4;
const int dirMotorA = 0;
const int dirMotorB = 2;
const int servoPin = 14;

unsigned long long lastMessTime = 0;
unsigned long long currentTime = 0;
int speed = 0;
int rotation = 0;
int direction = 0;

void setup() {
    Serial.begin(115200);

    // Begin as Acces Point
    WiFi.softAP(ssid);
    udp.begin(localPort);

    myservo.attach(servoPin);
    myservo.write(90);
    pinMode(pwmMotorA, OUTPUT);
    pinMode(pwmMotorB, OUTPUT);
    pinMode(dirMotorA, OUTPUT);
    pinMode(dirMotorB, OUTPUT);
}

void loop() {
    //Check for incoming packages
    receivedPacket(udp.parsePacket());

    //If no package for 500ms powerdown motors and servo
    currentTime = millis();
    if (currentTime - lastMessTime >= 500){
        motors(0);
        myservo.write(90);
    } else {
        motors(speed);
        myservo.write(rotation);
    }
}

//handle package
void receivedPacket(int size){
    if (size) {
        udp.read(packetBuffer, size);
        packetBuffer[size] = '\0';
        char *token = strtok(packetBuffer, ";");
        speed = atoi(token);
        token = strtok(NULL, ";");
        rotation = atoi(token);

        Serial.print("Speed: ");
        Serial.println(speed);
        Serial.print("Rotation: ");
        Serial.println(rotation);

        udp.beginPacket(udp.remoteIP(), udp.remotePort());
        udp.printf("UDP packet was received OK\r\n");
        udp.endPacket();

        lastMessTime = millis();
    }
}

//handle motors
void motors(int speed){
    if (speed >= 0){
        analogWrite(pwmMotorA, speed);
        digitalWrite(dirMotorA, LOW);
        analogWrite(pwmMotorB, speed);
        digitalWrite(dirMotorB, HIGH);
    }
    else {
        analogWrite(pwmMotorA, abs(speed));
        digitalWrite(dirMotorA, HIGH);
        analogWrite(pwmMotorB, abs(speed));
        digitalWrite(dirMotorB, LOW);
    }
}