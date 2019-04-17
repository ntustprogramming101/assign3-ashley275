
PImage soil[] = new PImage[6];

PImage bg, life, cabbage, soldier, stone1, stone2;
PImage groundhog, groundhogDown, groundhogLeft, groundhogRight;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here
  
 
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");

  for( int n=0; n<soil.length; n++ ) soil[n] = loadImage("img/soil"+n+".png");
}

void draw() {


      // Ground
      int y=0;
      while (y<8){

          image( soil[2], 80*y, 0 ); 
       y++;
          
      } } 

 
