class Ghost {

  //variables
  float x;
  float y;
  float w;
  float h;

  float left;
  float right;
  float top;
  float bottom;

  float xSpeed;

  color fillC;

  boolean spawn = true;

  boolean isMovingLeft;
  boolean isMovingRight;
  boolean isMovingUp;
  boolean isMovingDown;

  boolean hitPlayer = false;

  Animation animation;

  //constructor
  Ghost(float startingX, float startingY, float startingW, float startingH, Animation startingAnimation) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    animation = startingAnimation;

    xSpeed = random(2, 10);

    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;

    fillC = color(255);

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }

  void render() {
    fill(fillC);
    // rectMode(CENTER);
    imageMode(CENTER);
    animation.display(x+22, y+20);
    animation.isAnimating=true;
    rectMode(CENTER);
//    rect(x, y, w, h);
  }

  void move() {
    x -= xSpeed; 

    left = x - w/2;
    fill(255);
    //circle(x+w/2, y, 3);

    right = x + w/2;
    fill(0, 0, 255);
   // circle(x, y-h/2, 3);

    top = y - h/2;
    fill(0, 255, 0);
   // circle(x, y-h/2, 3);

    bottom = y + h/2;
    fill(0);
   // circle(x, y+h/2, 3);
  }

  void reset() {
    if (x<=0) {
      x = width;
      y = random(0, height-100);
    }
  }


  void ghostCollision(Player aPlayer) {
    if (left <= aPlayer.right &&
      right >= aPlayer.left &&
      top <= aPlayer.bottom &&
      bottom >= aPlayer.top) {
      println("hit");
      x = width;
      y = random(0, width);

      aPlayer.playerLives -= 1;


      if (aPlayer.playerLives <= 0) {
        state = 2;
      }
    }
    //if(hitPlayer == true){
    // println("hit");
  }
}
