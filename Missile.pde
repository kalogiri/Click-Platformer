//this class has the missile code in it (:D) and it has the code that 
//gives the missiles it's properties such as it's flocking ability meaning
//the direction the missiles face and how it tracks the location of the player;
//the velocity, the acceleration, the shape of the missile.

class Missile {
  float sizeOfMissile = 8;//the size of the missiles
  float closingRad = 5 * sizeOfMissile;
  float rebound = 0.75;//the speed of rebound of the edges
  float nomMaxSpeed = 3;//The normal max speed of the missiles
  float nomMaxAcc = 0.3;// The normal max acceleration of the missile
  float nomAccRate = 0.10;// How much faster it gets as it approached the target
  float var = 0.20; // the variance

  PVector origin, pos, vel, acc, facing;
  float maxSpeed, maxAcc, accRate;
  float targetLockDistance;
  color clr, clrR;

  Missile (float x, float y, float oX, float oY) {
    origin = new PVector (oX, oY);//the starting positions of the missiles
    pos = origin.get();//this gets the origin point of the missiles
    vel = new PVector(oX, oY);//the velocity vector
    acc = new PVector (0, 0);//the acceleration vector initially set to 0
    facing = new PVector (1, 0);
    maxSpeed = nomMaxSpeed * random(1 - var, 1+ var);
    maxAcc = nomMaxAcc * random(1 - var, 1+ var);
    accRate = nomAccRate * random(1 - var, 1+ var); 
    clrR = color (0, random(128), random(255));//nice Soft colors
    clr = color (0);
  }//Constructor

  //--------------------Tracks where the player is and behaves accordingly--------------------//
  void track (PVector mssl) {//missile
    PVector msslDir = PVector.sub(mssl, pos);//knows which direction to face because the 2 vector positions are SUBTRACTED from each other
    msslDir.normalize();//makes the vector magnitude 1 by dividing it by it self
    targetLockDistance = PVector.dist(mssl, pos);//calculates the pistance between 2 positions
    float targetAngle = PVector.angleBetween(vel, acc); //this makes it possible for the missile to look look for the player

    float facingAngle = heading(msslDir) - heading(facing);//this makes it possible for the missile to look at the player
    rotateVector(facing, facingAngle);
    acc = msslDir.get();
    acc.mult(maxAcc);

    //checking how fast the missile is moving
    if ((targetLockDistance < closingRad) || (abs(targetAngle) > PI/2)) {
      PVector accel = vel.get();
      accel.normalize();
      accel.mult(-accRate * vel.mag());
      acc.add(accel);
    }//if function
  }//track function

  //----------------------------------------------------------------------------------------//

  //--------------------Movement of the Missiles--------------------//

  void move() {
    vel.add(acc); //change vel
    vel.limit(maxSpeed);//limit the max speed of vel
    //if the missile gets to the target the stop
    if ((targetLockDistance < 2* sizeOfMissile) && (vel.mag() < 2 * maxSpeed)) {//as the missile aproaches the target it speeds up
      //pos.set(origin);//Sets the missiles back to origin when it hits the player
      clrR = color (255);
      clr = color (255);
      endState();
    }//if statement
    pos.add(vel);
    edge();
  }//move function
  //----------------------------------------------------------------//

  //--------------------Detects if the missile is hitting the side of the screen and rebounds if it is--------------------//

  void edge() {//Rebound
    if ((pos.x < 0 ) || (pos.x > width)) {
      vel.x *= -rebound;
    }//if statement for x rebound
    if ((pos.y < 0 ) || (pos.y > height)) {
      vel.y *= -rebound;
    }//if statement for y rebound
  }//edge function

  //--------------------Draws the missile--------------------//
  void display() {
    fill(clr);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(heading(facing));
    stroke(clrR);
    triangle(sizeOfMissile, 0, 0, sizeOfMissile / 4, 0, -sizeOfMissile/4);//the missile
    popMatrix();
  }//Display function

  //---------------------------------------------------------//

  //--------------------Rotation of the missile--------------------//

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /*These function are here for the fact that there is no .heading() or .rotate function for the PVector in processing*/
  //Reference from Daniel Shiffman (http://www.shiffman.net/2011/02/03/rotate-a-vector-processing-js/)
  float heading(PVector vector) {
    return atan2(vector.y, vector.x);
  }//heading function

  // function to accomplish PVector.rotate()
  void rotateVector(PVector vector, float ang) {
    float oldAng = heading(vector);
    float newAng = oldAng + ang;
    float r = vector.mag();
    float x = r * cos(newAng);
    float y = r * sin(newAng);
    vector.set(x, y, 0);
  }//rotateVector function
}//Class

