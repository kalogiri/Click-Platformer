//This is the class that has the properties of the character,
//so the hit detection from the player to the level, the missile
//and the player, etc.

class Char {

  int charWidth;
  int charHeight;
  PVector vel, pos, acc, mxVel, myVel;
  float diaX, diaY, botX, botY, leftY, rightX, rightY, topX, topY;
  boolean onGround;
  boolean onAir;
  boolean start;

  Char (float _x, float _y, int _w, int _h) {
    pos = new PVector (_x, _y);
    charWidth = _w;
    charHeight = _h;
    vel = new PVector();
    acc = new PVector();
    onGround = false;
    mxVel = new PVector (3, 0, 0);
    myVel = new PVector (0, -2, 0);
  }//the constructor

  //--------------------Drawing the character--------------------//

  void display() {
    fill(#798310);
    rect(pos.x, pos.y, charWidth, charHeight);
  }//display function

  //--------------------Implementing the gravity function and the hit detection--------------------//

  void update() {
    //setting the gravity of the game
    acc.set(0, 0.06, 0);//gravity
    vel.add(acc);
    pos.add(vel);

    //calling the hit detection functions
    stay();
    blockStay();

    //calling the reappear function
    reappear();
  }//update funtion

  //--------------------Function for making the character appear from the sides of the screen--------------------//

  void reappear () {//makes it so that when the character goes off screen from one side it appears from the other
    if (pos.x > width) {
      pos.x = -16;
    }//if statement
    if (pos.x < -16) {
      pos.x = width-16;
    }//if statement
  }//reapear function

  //--------------------Character Movements--------------------//

  void move() {
    if ( right ) {
      acc.set (2, 0, 0);
      vel.add(acc);
      if (vel.x > 2) {
        vel.set(2, 0, 0);
      }//the air movement
    }//if right statement
    else if ( left ) {
      acc.set (-2, 0, 0);
      vel.add(acc);
      if (vel.x < -2) {
        vel.set(-2, 0, 0);
      }//the air movement
    }//else left statement

    if ( up ) {
      if (onGround) {
        acc.set(0, -2, 0);
        vel.set(acc);
        jump.trigger();
      }//if statement
      else {
        onGround = false;
      }//else statement
    }//up method
  }//Move function


  //--------------------Hit Detection from the player to the screen floor--------------------//

  void stay () {// collision detect
    if (pos.y + charHeight >  height) {// floor detect
      acc.set(0, 0, 0);
      vel.set(0, 0, 0);
      pos.y = height - charHeight;
      onGround = true;
    }//if statement for the floor detect
    else {
      onGround = false;// makes it so that character doesnt jump when it's on not on the ground.
    }//else statement
  }//stay function

  //--------------------Hit Detection from the player to the platforms that are created with the mouse click--------------------//

  void blockStay() {
    for (int i = 0; i < lvl.gridHeight; i++) {
      for (int j = 0; j < lvl.gridWidth; j++) {
        if (lvl.lvl[i][j] == 1)//if a block is placed
          //The line of code below sees weather the char is
          //on top of the block that was placed.
          stayInBlock(j*16, i*16, 16, 16);//calling the stay in block function which is the main hit detection method when the player jumps on the platform


        //---------Checks to see if the grid is being drawn properly-|
        //          noFill();                                        |
        //          stroke(0);                                       |
        //          rect(j*16, i*16, 16, 16);                        |
        //-----------------------------------------------------------|
        
      }//for loop for j
    }//for loop for i
  }//block stay class

  //--------------------Main Hit Detection with the player and the platform(s)--------------------//  

  void stayInBlock (int platHitDetectXPos, int platHitDetectYpos, int platHitDetectWidth, int platHitDetectHeight) {// collision detect
    if (pos.y + charHeight > platHitDetectYpos && pos.y < platHitDetectYpos + charHeight  && pos.x < platHitDetectXPos + platHitDetectWidth && pos.x + charWidth > platHitDetectXPos) {// floor detect
      pos.y = platHitDetectYpos - charHeight;
      acc.set(0, 0, 0);
      vel.set(acc);
      onGround = true;
    }//if statement for the floor detect

    //--------------------Fixes the character movement problem of it floating even when the arrow keys are pressed--------------------//

    //but this is only applicable when a block is placed
    if (pos.x + charWidth > platHitDetectXPos || pos.x < platHitDetectXPos + platHitDetectWidth) {
      vel.x = 0;
    }//if function
  }//stay function
}//class end

