
/////////////////////////////////////////////////////////////////////////////////////////////
//Lone Survivor//
////////////////////////////////////////////////////////////////////////////////////////////
//sound library
import processing.sound.*;

SoundFile backgroundSound;
SoundFile jumpSound;

//declaring vars

//score timer vars
int intervl = 1000;
int playerTime = 0;
color scoreColor = color(255);
int playerScoreX = 950;
int playerScoreY = 75;
int playerScore;
int beginTime = millis()/1000;
int finalTime = millis()/1000;

// state vars
//States s1;
int state = 0;

///////////////////////////////////////////////////////////////////////////////////////////////
//Background Image
PImage graveyardImage;

///////////////////////////////////////////////////////////////////////////////////////////////
//Player Images

PImage[] playerImages = new PImage[2];

Animation playerAnimation;

Player p1;

///////////////////////////////////////////////////////////////////////////////////////////////
//Platforms
Platform plat1;
Platform plat2;
Platform plat3;
Platform plat4;
Platform plat5;


////////////////////////////////////////////////////////////////////////////////////////////////////
//ghost images
Ghost g1;

PImage[] ghostImages = new PImage[2];

Animation ghostAnimation;

//platform arraylist
ArrayList<Platform> platformList;

//ghost arraylist
ArrayList<Ghost> ghostList;


//timer vars
int startTime = millis();
int endTime = millis();
int interval = 2500;

void setup() {
  size(1920, 576);
  //load graveyard image
  graveyardImage = loadImage("Graveyard.png");
  // graveyardImage.resize(1200, 800);

  //backgroundsound 
  backgroundSound = new SoundFile(this, "background.mp3");
  backgroundSound.amp(0.2);

  //jumpingsound
  jumpSound = new SoundFile(this, "jump.mp3");
  jumpSound.amp(0.15);
  jumpSound.rate(1.35);

  //fill array of player images
  for (int i = 0; i<playerImages.length; i++) {
    playerImages[i] = loadImage("Player"+i+".png");
  }

  //initialize vars
  playerAnimation = new Animation(playerImages, 0.2, 3);

  p1 = new Player(width/2, height, 24, 64, playerAnimation);

  //platform array
  plat1 = new Platform(width/2 + 400, 250);
  plat2 = new Platform(width/2 - 300, 400);
  plat3 = new Platform(width/3 + 600, 450);
  plat4 = new Platform(width/4 - 200, 350);
  plat5 = new Platform(width/4 + 300, 205);


  platformList = new ArrayList<Platform>();

  platformList.add(plat1);
  platformList.add(plat2);
  platformList.add(plat3);
  platformList.add(plat4);
  platformList.add(plat5);


  //ghost arraylist
  ghostList = new ArrayList<Ghost>();

  //fill array of ghost images
  for (int i = 0; i<ghostImages.length; i++) {
    ghostImages[i] = loadImage("Ghost"+i+".png");
  }

  //initialize ghost object
  ghostAnimation = new Animation(ghostImages, 0.06, 1.5);
}


void draw() {
  background(42);
  //background image

  imageMode(CENTER);
  image(graveyardImage, width/2, height/2);
  //updates the timer every frame
  endTime = millis();
  //timer if statement for ghosts
  if (endTime - startTime > interval) {
    ghostList.add(new Ghost(width, random(0, height), 24, 32, ghostAnimation)); 


    startTime = millis();
    println("timer triggered");
  }

  //////// //timer if statement for player time
  finalTime = millis();
  if (finalTime - beginTime > intervl) {
    playerTime += 1; 


    beginTime = playerScore;
  }

  switch (state) {
  case 0 :
    startScreen();
    break;
  case 1:
    //player class function's
    p1.render();
    p1.move();
    p1.jumping();
    p1.falling();
    p1.topOfJump();
    p1.land();
    p1.fallOffPlatform(platformList);
    //p1.playerCollision();
    p1.drawLives(p1.playerLives, p1.playerLivesX, p1.playerLivesY, p1.playerColor);

    //score function
    drawScore();

    //for loop to go through all platforms
    for (Platform aPlatform : platformList) {
      aPlatform.render();
      aPlatform.collision(p1);
    }

    if (backgroundSound.isPlaying() == false) { //loops background music
      backgroundSound.play();
    }

    //ghost arraylist for loop
    for (Ghost aGhost : ghostList) {
      aGhost.render();
      aGhost.move();
      aGhost.reset();
      aGhost.ghostCollision(p1);
    }
    playerScore = finalTime;
    break;

  case 2:
    endScreen();
    break;
  }
}

void keyPressed() {
  if (key == 'a') {
    p1.isMovingLeft = true;
    p1.animation.isAnimating = true;
  }

  if (key == 'd') {
    p1.isMovingRight = true;
    p1.animation.isAnimating = true;
  }

  if (key == 'w' && p1.isJumping ==false && p1.isFalling == false) {
    p1.isJumping = true; //starts a new jump
    p1.highestY = p1.y - p1.jumpHeight; //keeps player jumping the same height
    jumpSound.play(); //plays jump sound
    p1.animation.isAnimating = true;
  }
  if (key == ' ') {
    state += 1;
    p1.playerLives=3;
    beginTime = 0;
    ghostList = new ArrayList<Ghost>();
    p1 = new Player(width/2, height, 24, 64, playerAnimation);
  }
  if (state > 2) {
    state = 0;
  }
}
void keyReleased() {
  if (key == 'a') {
    p1.isMovingLeft = false;
  }

  if (key == 'd') {
    p1.isMovingRight = false;
  }
}

void drawScore() {
  fill(scoreColor);
  textSize(70);
  text(playerTime, playerScoreX - 270, playerScoreY);
  text("Seconds Alive", playerScoreX - 550, playerScoreY);
}

void startScreen() {
  textAlign(CENTER);
  fill(255);
  textSize(80);
  text("Press 'Space' to start", width/2, height - 85);
  text("LONE SURVIVOR", width / 2, height / 2);
  playerTime = 0;
}

void endScreen() {
  textAlign(CENTER);

  textSize(80);
  if (p1.playerLives<=0) {
    state = 2;
    fill(255, 0, 0);
    text("YOU DIED", width/2, height/2 + 30);
    fill(255);
    text("Press 'Space' to restart", width /2, height - 85 );
    text(playerScore/1000, width/2 + 100, height / 4 - 20);
    text("Survived:", width/2 - 130, height / 4 - 20);
  }
}
