class Platform{
 
  //variables
  int x;
  int y;
  int w;
  int h;
  
  int left;
  int right;
  int top;
  int bottom;
  
  //constructor
  Platform(int startingX, int startingY){
    rectMode(CENTER);
    
    x = startingX;
    y = startingY;
    w = 150;
    h = 10;
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }
  
  void render(){
   rect(x,y,w,h); 
  }
  
  void collision(Player aPlayer){
    if (left < aPlayer.right &&
    right > aPlayer.left &&
    top < aPlayer.bottom &&
    bottom > aPlayer.top){
     
      aPlayer.isFalling = false; //stop falling
      aPlayer.y = y - h/2 - aPlayer.h/2;
    }
  }
}
