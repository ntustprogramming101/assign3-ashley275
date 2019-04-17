
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
      for( int x=0; x<8; x++ ){
        for( int y=0; y<24; y++ ){
          /// --Soil
          int type = y/4;
          PImage img = soil[type];
          image( img, 80*x, 80*y+160 ); 

          /// --Stone
          switch(type){
            case 0:
            case 1:
              if( x == y ) image( stone1, 80*x, 80*y+160 );
            break;
            case 2:
            case 3:
              if( (y-x)%4 == 2 || (x+y)%4 == 1 ){  
                image( stone1, 80*x, 80*y+160 );
              }  
            break;
            default:
              if( (x+y)%3 != 1 ) image( stone1,80*x, 80*y+160 );
              if( (x+y)%3 == 0 ) image( stone2, 80*x, 80*y+160 );
            break;
      } } } }

 
