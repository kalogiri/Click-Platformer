 //--------------------Audio Declaration--------------------//
import ddf.minim.*;
Minim minim;
AudioSample jump;
AudioSample move;
AudioSample placed;

//--------------------Font Declaration--------------------//

PFont font;

//--------------------Declaration of missile properties--------------------//

int numMissiles = 5;//Increase or decrease the number of missiles
boolean launched = false;
boolean trace = true;//this allows the missiles to "look" at the character
PVector missileLock;

//--------------------Declaration of the different screen states--------------------//

boolean startScreen = true;
boolean endScreen = false;

//--------------------Keyboard functionality declaration--------------------//

boolean right = false, left = false, up = false;

Char ch;
Level lvl;
Missile [] missiles; //the array to hold the number of missiles to be launched

//--------------------Setup Method--------------------//

void setup () {
  size(480, 368);
  font = loadFont("FranklinGothic-Medium-48.vlw"); //Loads the font from the data folder
  textAlign(CENTER); //Aligns text to the center
  textFont(font, height/25); //Sets the text font

  //--------------------Sound initialisation--------------------//

  minim = new Minim(this);
  jump = minim.loadSample("Jump.wav", 512);
  //move = minim.loadSample("Move.mp3", 512);
  placed = minim.loadSample("blockPlaced.mp3", 512);


  //--------------------Placing the missile in the screen--------------------//

  missiles = new Missile[numMissiles];
  for (int i = 0; i < numMissiles; i++) {
    missiles[i] = new Missile(random(width), random(height), -5, -5);
  }//for loop

  //--------------------Giving the rest of the elements of the game it's property--------------------//
  ch = new Char (50, height/2, 16, 16);
  lvl = new Level();

  //--------------------Calling the game over state--------------------//

  endState();
}//Setup Function

//--------------------Draw Method--------------------//
void draw() {
  background(205, 205, 193);
  noStroke();
  if (startScreen) {
    text("Left Mouse button to place down the blocks", width/2, height/2);
    text("Press Space to launch the missiles", width/2, height/6);
  }

  //--------------------Calling all the functions--------------------//  
  ch.display();
  ch.update();
  ch.move();
  lvl.draw();



  //--------------------Giving the missile it's property when its launched and when its not launched and displaying the missile--------------------//

  missileLock = new PVector (ch.pos.x, ch.pos.y);
  for (int i = 0; i < numMissiles; i++) {
    if (!trace) {
      missileLock = missiles[i].origin;
    }//if space = false (!space) statement
    missiles[i].track(missileLock);
    if (launched == true) {
      missiles[i].move();
    }//launch = true if statement
    missiles[i].display();
  }//for loop
}//draw function

//--------------------Key pressed and released functionalities--------------------//

void keyPressed() {
  startScreen = false;
  switch(keyCode) {
  case RIGHT: 
    right = true; 
    //move.trigger();
    break;
  case LEFT: 
    left = true; 
    //move.trigger();
    break;
  case UP: 
    up = true; 
    break;
  }//switch
  //use the space key instead of the left mouse click to set the missile off
  if (key == ' ') {
    startScreen = false;
    if (launched) {
      launched = false;
    }//launched if statement
    else {
      launched = true;
    }//launched else statement
  } //space key pressed if statement

  //here if the r key is pressed the game is reset to the original starting state.
  if (key == 'r' || key == 'R') {
    launched = false;
    endScreen = false;
    newGame();
  }//Rreset key if statement
}//void key pressed for arrow keys

void keyReleased() {
  startScreen = false;
  switch(keyCode) {
  case RIGHT: 
    right = false; 
    //move.stop();
    break;
  case LEFT: 
    left = false; 
    //move.stop();
    break;
  case UP: 
    up = false; 
    break;
  }//switch
}//keyReleased Function

//--------------------The function for placing the level--------------------//

void mousePressed() {
  startScreen = false;
  lvl.mouse();
  placed.trigger();
}//mousePressed Function

void newGame() {

  missiles = new Missile[numMissiles];
  for (int i = 0; i < numMissiles; i++) {
    missiles[i] = new Missile(random(width), random(height), -5, -5);
  }//for loop
  ch = new Char (width/2, height/2, 16, 16);
  lvl = new Level();
  noStroke();
  ch.display();
  ch.update();
  ch.move();
  lvl.draw();
}//newGame


//-----------------Screens-------------------//

void endState () {
  fill(255, 0, 30); //Fills the screen with red background
  noStroke(); //Cancels the stroke
  rect(0, 0, width, height); //Cover the screen with a transluscent red
  fill(0); //Colors white
  text("Game Over", width/2, 150);
  text("Press 'R' To Restart", width/2, 200);
}//endState function

