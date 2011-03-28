/*
The Four Button Game
 */

// constants won't change. They're used here to 
// set pin numbers:
const int button1Pin = 5;     // the number of the pushbutton pin
const int button2Pin = 6;     // the number of the pushbutton pin
const int button3Pin = 7;     // the number of the pushbutton pin
const int button4Pin = 8;     // the number of the pushbutton pin
// LED pins: (TODO: should this be a const?)
int ledPins[] = {
  10,11,12,13};
const int data = 2; // Data pin for Shift Register
const int clock = 3; // Clock pin for Shift Register
const int latch = 4;  // Latch pin for Shift Register 

const int ON = HIGH;
const int OFF = LOW;
                        
                        
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

  

// variables will change:

int length = 3;   // Initial length of the sequence
int leds = 4;   // The number of LEDs (not sure what this is used for)


int button1State = 0;         // variable for reading the pushbutton status
int button2State = 0;         // variable for reading the pushbutton status
int button3State = 0;         // variable for reading the pushbutton status
int button4State = 0;         // variable for reading the pushbutton status

int lastButton1State = 0;         // variable for reading the pushbutton status
int lastButton2State = 0;         // variable for reading the pushbutton status
int lastButton3State = 0;         // variable for reading the pushbutton status
int lastButton4State = 0;         // variable for reading the pushbutton status

int level = 1;

int led1State = 0;         // variable for the LED
int led2State = 0;         // variable for the LED
int led3State = 0;         // variable for the LED
int led4State = 0;         // variable for the LED



//Used for single LED manipulation
int ledState = 0;



void setup() {
  // initialize the LED pin as an output:
  pinMode(led1Pin, OUTPUT);      
  pinMode(led2Pin, OUTPUT);      
  pinMode(led3Pin, OUTPUT);      
  pinMode(led4Pin, OUTPUT);        
  // initialize the pushbutton pin as an input:
  pinMode(button1Pin, INPUT);     
  pinMode(button2Pin, INPUT);     
  pinMode(button3Pin, INPUT);     
  pinMode(button4Pin, INPUT);     
  
  // initialise the pins connected to the Shift Register
  pinMode(data, OUTPUT);
  pinMode(clock, OUTPUT);  
  pinMode(latch, OUTPUT);  

  // Not sure what this does:  
  randomSeed(analogRead(0));

  // Light up '0' on the display
  lightNumber(0);
  
}


void loop(){
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



void displayLights() {
 
  if (led1State == 1) {
    digitalWrite(led1Pin, HIGH);         
  } else {
    digitalWrite(led1Pin, LOW);     
  }  
  
  if (led2State == 1) {
    digitalWrite(led2Pin, HIGH);         
  } else {
    digitalWrite(led2Pin, LOW);     
  }  

  if (led3State == 1) {
    digitalWrite(led3Pin, HIGH);         
  } else {
    digitalWrite(led3Pin, LOW);     
  }  

  if (led4State == 1) {
    digitalWrite(led4Pin, HIGH);         
  } else {
    digitalWrite(led4Pin, LOW);     
  }  
  
}

void checkWin() {
 
 if (led1State == 1 && led2State == 1 && led3State == 1 && led4State == 1) {
  
   level++;
   led1State = 0;   
   led2State = 0;
   led3State = 0;
   led4State = 0;
   
 } 
  
}  

/*
* lightNumber() - sets the 7-segment-display to light up a given
* two-digit number.
*/
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


/*
 * lose() - Displays WIN sequence
 */
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


/*
 * lose() - Displays LOSE sequence
 */
void lose() {
  for (int ledPin=0; ledPin<leds; ledPin++) {
    digitalWrite(ledPins[ledPin], HIGH);
  }
  delay(1000);
  for (int ledPin=0; ledPin<leds; ledPin++) {
    digitalWrite(ledPins[ledPin], LOW);
  }
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

