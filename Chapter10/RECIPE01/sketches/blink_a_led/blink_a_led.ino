/*
  Blink Built-in LED

  Activate built-in LED blinking when a specific command arrive.

*/

String command;
char receivedChar;
boolean blinkMode;

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  // initialize Serial to max data rate
  Serial.begin(115200);     // Port serial 115200 baud.
}

// read from serial and concat it to command
void readFromSerial() {
  
  while (Serial.available() > 0) {    
    receivedChar = Serial.read();
    command.concat(receivedChar);
    delay(10);
  }  
  
}

// do the led blink
void doBlink() {
  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);                       // wait for a second
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                       // wait for a second
}

// the loop function runs over and over again forever
void loop() {

  readFromSerial();

  if (command.equals("BLINK_ON") == true) {
    blinkMode = true;
  } else if (command.equals("BLINK_OFF") == true) {
    blinkMode = false;
  }

  if (blinkMode) {
    doBlink();
  }

  // Clean the command to receive the next
  command = "";
}
