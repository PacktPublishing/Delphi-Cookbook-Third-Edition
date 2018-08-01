int relay_pin_1 = 8;
int relay_pin_2 = 9;
int led_pin_1 = 13;
int led_pin_2 = 12;


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
  Serial.begin(115200);     // Port serial 9600 baud.
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(2000);
  // turn red LED on
  digitalWrite(relay_pin_1, LOW);
  Serial.print("R_ON");
  delay(5000);

 // turn red LED off
  digitalWrite(relay_pin_1, HIGH);
  Serial.print("R_OFF");
  delay(5000);

 // turn green LED on
  digitalWrite(relay_pin_2, LOW);
  Serial.print("G_ON");
  delay(5000);

 // turn green LED off
  digitalWrite(relay_pin_2, HIGH);
  Serial.print("G_OFF");
  delay(5000);

}
