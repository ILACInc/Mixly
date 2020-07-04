void setup(){
  pinMode(5, OUTPUT);
}

void loop(){
  for (int i = 1; i <= 10; i = i + (1)) {
    digitalWrite(5,HIGH);
    delay(1000);
    digitalWrite(5,LOW);
    delay(1000);
  }

}