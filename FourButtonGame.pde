/*
The Four Button Game
 */

// constants won't change. They're used here to 
// set pin numbers:
const int button1Pin = 5;     // the number of the pushbutton pin
const int button2Pin = 6;     // the number of the pushbutton pin
const int button3Pin = 7;     // the number of the pushbutton pin
const int button4Pin = 8;     // the number of the pushbutton pin
const int led1Pin =  10;      // the number of the LED pin
const int led2Pin =  11;      // the number of the LED pin
const int led3Pin =  12;      // the number of the LED pin
const int led4Pin =  13;      // the number of the LED pin

// variables will change:
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

int data = 2; 
int clock = 3;
int latch = 4;

//Used for single LED manipulation
int ledState = 0;
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
  
  pinMode(data, OUTPUT);
  pinMode(clock, OUTPUT);  
  pinMode(latch, OUTPUT);  
  
  
}


void loop(){
  
  checkWin();
  lightNumber(level);
  
  // read the state of the pushbutton value:
  button1State = digitalRead(button1Pin);
  button2State = digitalRead(button2Pin);
  button3State = digitalRead(button3Pin);
  button4State = digitalRead(button4Pin);  


  if (button1State != lastButton1State) {
    
    // check if the pushbutton is pressed.
    // if it is, the buttonState is HIGH:
    if (button1State == HIGH) {     
      // turn LED on:    
      led1State = 1 - led1State;
      //led1State = 1; 
    } 
    else {

    }
  }

  if (button2State != lastButton2State) {
    
    // check if the pushbutton is pressed.
    // if it is, the buttonState is HIGH:
    if (button2State == HIGH) {     
      // turn LED on:    
      led2State = 1 - led2State;
      //led2State = 1; 
    } 
    else {

      // turn LED off:

    }
  }  

  if (button3State != lastButton3State) {
    
    // check if the pushbutton is pressed.
    // if it is, the buttonState is HIGH:
    if (button3State == HIGH) {     
      // turn LED on:    
      led3State = 1 - led3State;
      //led3State = 1; 
    } 
    else {

      //  led3State = 0;
      // turn LED off:

    }
  }  

  if (button4State != lastButton4State) {
    
    // check if the pushbutton is pressed.
    // if it is, the buttonState is HIGH:
    if (button4State == HIGH) {     
      // turn LED on:    
      led4State = 1 - led4State;
     /// led4State = 1; 
    } 
    else {

      // turn LED off:

    }
  } 

  displayLights();

  
  lastButton1State = button1State;
  lastButton2State = button2State;
  lastButton3State = button3State;
  lastButton4State = button4State; 
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

