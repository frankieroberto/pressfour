/*
  repeat the pattern
 
 little game. press buttons in correct order
 */

int ledPins[] = {
  2,3,4,5};
int leds = 4;
int button1 = 9;
int button2 = 10;
int button3 = 11;
int button4 = 12;

int length = 3;

// level-counter
const int segmentA  = B00000001;
const int segmentB  = B00000010;
const int segmentC  = B00000100;
const int segmentD  = B00001000;
const int segmentE  = B00010000;
const int segmentF  = B00100000;
const int segmentG  = B01000000;
const int segmentDP = B10000000;

const int digit0 = segmentA|segmentB|segmentC|segmentD|segmentE|segmentF;
const int digit1 = segmentB|segmentC;
const int digit2 = segmentA|segmentB|segmentG|segmentE|segmentD;
const int digit3 = segmentA|segmentB|segmentG|segmentC|segmentD;
const int digit4 = segmentF|segmentG|segmentB|segmentC;
const int digit5 = segmentA|segmentF|segmentG|segmentC|segmentD;
const int digit6 = segmentA|segmentF|segmentG|segmentE|segmentD|segmentC;
const int digit7 = segmentA|segmentB|segmentC;
const int digit8 = segmentA|segmentB|segmentC|segmentD|segmentE|segmentF|segmentG;
const int digit9 = segmentA|segmentB|segmentC|segmentF|segmentG;

int data = 6; 
int clock = 7;
int latch = 8;

void setup() {
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(13, OUTPUT);
  pinMode(button1, INPUT);
  pinMode(button2, INPUT);
  pinMode(button3, INPUT);
  pinMode(button4, INPUT);
  for (int i=0; i<leds; i++) {
    pinMode(ledPins[i], OUTPUT); 
  }
  Serial.begin(9600);
  
  randomSeed(analogRead(0));
  
  // level-counter
  pinMode(data, OUTPUT);
  pinMode(clock, OUTPUT);  
  pinMode(latch, OUTPUT);  
  
  lightNumber(0);

}

void win() {
  for (int i=0; i<3; i++) {
    for (int ledPin=0; ledPin<leds; ledPin++) {
      digitalWrite(ledPins[ledPin], HIGH);
    }
    delay(200);
    for (int ledPin=0; ledPin<leds; ledPin++) {
      digitalWrite(ledPins[ledPin], LOW);
    }
    delay(200);
  }
}
void lose() {
  for (int ledPin=0; ledPin<leds; ledPin++) {
    digitalWrite(ledPins[ledPin], HIGH);
  }
  delay(1000);
  for (int ledPin=0; ledPin<leds; ledPin++) {
    digitalWrite(ledPins[ledPin], LOW);
  }
}

boolean press(int button) {
  if (digitalRead(button) == HIGH) {
    return false;
  } else { // button pressed - wait till released
    while (digitalRead(button) != HIGH) {
      true;
    }
    return true;
  }
}

void printArr(int arr[], int length) {
  for (int i=0; i < length; i++){
    Serial.print(arr[i]);
  }
  Serial.println();
}

void loop() {
  boolean pressed = false;
  int counter = 0;
  int key[length];
  int answer[length];

  // pattern
  for (int i=0; i<length; i++) {
    int rand = random(leds);
    key[i] = rand;
    digitalWrite(ledPins[rand], HIGH);
    delay(400);
    digitalWrite(ledPins[rand], LOW);
    delay(200);
  }
  while (counter<length) {
    delay(10);
    if (press(button1)) {
      answer[counter] = 0;
      counter++;
    }
    if (press(button2)) {
      answer[counter] = 1;
      counter++;
    }
    if (press(button3)) {
      answer[counter] = 2;
      counter++;
    }
    if (press(button4)) {
      answer[counter] = 3;
      counter++;
    }
  }

  // check answer
  boolean correct = true; 
  for (int i=0; i<length; i++) {
    if (key[i] != answer[i]) {
      correct = false;
    }
  }
  if (correct) {
    win();
    length++;
    lightNumber(length-3);
  }
  else {
    lose();
    length = 3;
   }
  delay(1000);
}

/*
 * updateLEDs() - sends the LED states set in ledStates to the 74HC595
 * sequence
 */
void updateLEDs(int value, int value2){
  digitalWrite(latch, LOW);     //Pulls the chips latch low
  shiftOut(data, clock, MSBFIRST, ~value); //Shifts out the 8 bits to the shift register
  shiftOut(data, clock, MSBFIRST, ~value2); //Shifts out the 8 bits to the shift register
  digitalWrite(latch, HIGH);   //Pulls the latch high displaying the data
}

void lightNumber(int number) {
  updateLEDs(getDigit(number / 10), getDigit(number % 10));
}

int getDigit(int number) {
  switch(number) {
   case 0 :
      return(digit0);
      break;
    case 1 :
      return(digit1);
      break;
   case 2 :
      return(digit2);
      break;
   case 3 :
      return(digit3);
      break;
   case 4 :
      return(digit4);
      break;
   case 5 :
      return(digit5);
      break;
   case 6 :
      return(digit6);
      break;
   case 7 :
      return(digit7);
      break;
   case 8 :
      return(digit8);
      break;
   case 9 :
      return(digit9);
      break;
  }
}

