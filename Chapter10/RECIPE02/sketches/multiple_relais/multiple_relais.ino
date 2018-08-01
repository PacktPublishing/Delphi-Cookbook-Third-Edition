int relay_pin_1 = 8;
int relay_pin_2 = 9;
int led_pin_1 = 13;
int led_pin_2 = 12;

String command;
char receivedChar;


// read from serial and concat it to command
void readFromSerial() {

  while (Serial.available() > 0) {
    receivedChar = Serial.read();
    command.concat(receivedChar);
    delay(10);
  }

}


void setup() {
  // put your setup code here, to run once:
  pinMode(relay_pin_1, OUTPUT);
  pinMode(relay_pin_2, OUTPUT);
  pinMode(led_pin_1, OUTPUT);
  pinMode(led_pin_2, OUTPUT);
  digitalWrite(led_pin_1, HIGH);
  digitalWrite(led_pin_2, HIGH);

  digitalWrite(relay_pin_1, HIGH);
  digitalWrite(relay_pin_2, HIGH);

  // initialize Serial to a data rate
  Serial.begin(9600);     // Port serial 9600 baud.
}

void doCommand() {
  if (command.equals("RED_ON") == true) {
    digitalWrite(relay_pin_1, LOW);
    return;
  }
  if (command.equals("RED_OFF") == true) {
    digitalWrite(relay_pin_1, HIGH);
    return;
  }

  if (command.equals("GREEN_ON") == true) {
    digitalWrite(relay_pin_2, LOW);
    return;
  }
  if (command.equals("GREEN_OFF") == true) {
    digitalWrite(relay_pin_2, HIGH);
    return;
  }

}

void loop() {
  // put your main code here, to run repeatedly:  
  readFromSerial();
  doCommand();
  delay(200); // wait for a second

  // Clean the command to receive the next
  command = "";

}
