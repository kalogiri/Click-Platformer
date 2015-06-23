//This class contains the code for specifying the level details,
//such as the dimensions of the platform created and how the level
//is placed onto the world. 


class Level {
  int gridWidth = 30;
  int gridHeight = 23;
  int [][] lvl = new int[gridHeight][gridWidth];
  PVector pos;
  Level() {
    //nothing to declare
  }//Level Constructor
  void draw() {
    pos = new PVector();
    fill(129, 139, 133);
    noStroke();
    for (int ix = 0; ix < gridWidth; ix++) {
      for (int iy = 0; iy < gridHeight; iy++) { 
        switch(lvl [iy][ix]) {
        case 1: 
          rect(ix*16, iy*16, 16, 16);
        }//Switch
      }//for loop (iy)
    }//for loop(ix)
  }//draw

  boolean emptySpace (int xNull, int yNull) {
    xNull = int(xNull/16);
    yNull = int (yNull/16);
    if (xNull > -1 && xNull < lvl[0].length && yNull > -1 && yNull < lvl.length) {
      if (lvl[yNull][xNull] == 0) {
        return true;
      }//if level[yN][xN] == 0 statement
    }//if xN > -1 && xN < lvl[0].length && yN > -1 && yN < level.length statement
    return false;
  }//emptySpace Function
  void mouse() {//creating and deleting the blocks
    if (mouseButton == LEFT) {

      //      this checks if the block is within the array
      //      and if it is then it places a block item down
      //      and if that placed block is placed again then 
      //      that block is removed.

      lvl[int(mouseY/16)][int(mouseX/16)] ^= 1;
    }//if statement to place the blocks
  }//mouse function
}//level class

