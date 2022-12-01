class Player {
  //variables

  float x;
  float y;

  float w;
  float h;

  boolean isMovingLeft;
  boolean isMovingRight;

  boolean isJumping;
  boolean isFalling;

  boolean hitGhost = false;

  float speed;

  float jumpHeight; //distance that you can jump upwards
  float highestY; //y value of the top of the jump

  float left;
  float right;
  float top;
  float bottom;
  
  int playerLives = 3;
  int playerLivesX = 1850;
  int playerLivesY = 75;
  color playerColor = color(255);

  Animation animation;

  //constructor
  Player(float startingX, float startingY, float startingW, float startingH, Animation startingAnimation) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    animation = startingAnimation;

    isMovingLeft = false;
    isMovingRight = false;

    isJumping = false;
    isFalling = false;

    speed = 10;

    jumpHeight = 250;
    highestY = y - jumpHeight;

    left = x - w/2;
    right = x + w;
    top = y - h/2;
    bottom = y + h/2;
  }

  //functions
  void render() {

    imageMode(CENTER);
    animation.display(x+50, y+20);
     rectMode(CENTER);
   // rect(x,y,w,h);
  }

  void move() {
    if (isMovingLeft == true) {
      x -= speed;
    }

    if (isMovingRight == true) {
      x += speed;
    }

    //updates the boundaries of the player
    left = x - w/2;
    fill(255);
  //  circle(x+w/2, y, 3);
    
    right = x + w/2;
    fill(0,0,255);
   // circle(x, y-h/2,3);
    
    top = y - h/2;
    fill(0,255,0);
   // circle(x,y-h/2,3);
    
    bottom = y + h/2;
    fill(0);
  //  circle(x,y+h/2,3);
  }

  void jumping() {
    if (isJumping == true) {
      y -= speed; //can make a different speed variable for jumping
    }
  }

  void falling() {
    if (isFalling == true) {
      y += speed;
    }
  }

  void topOfJump() {
    if (y <= highestY) {
      isJumping = false; //stop jumping upward
      isFalling = true;
    }
  }

  void land() {
    if (y >= height - h/2) {
      isFalling = false; //stop falling
    }
  }

  //checks to see if player is colliding with any platform.
  //if not, then the player will start falling
  void fallOffPlatform(ArrayList<Platform> aPlatformList) {

    //check that the player isnt in the middle of a jump and not on the ground
    if (isJumping == false && y < height - h/2) {

      boolean onPlatform = false;

      for (Platform aPlatform : aPlatformList) {
        //if a player is colliding with a platform
        if (top <= aPlatform.bottom &&
          bottom >= aPlatform.top &&
          left <= aPlatform.right &&
          right >= aPlatform.left) {
          onPlatform = true; //make on platform true
        }
      }

      //if not on platform, start falling
      if (onPlatform == false) {
        isFalling = true;
      }
    }
  }

  void playerCollision() {
    for (Ghost aGhost : ghostList){
      if ( top<= aGhost.bottom &&
        bottom>= aGhost.top &&
        left <= aGhost.right &&
        right >= aGhost.left) {
          println("hit");
          playerLives -= 1;
         
      }
      if(playerLives <= 0){
       state = 2; 
      }

    }
  }
  
  void drawLives(int playerLives, int playerLivesX, int playerLivesY, color playerColor){
    fill (playerColor);
    textSize(70);
    text(playerLives, playerLivesX, playerLivesY);
    text("Lives", 1720, 75);
  }
  
}
