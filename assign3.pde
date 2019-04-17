/*
    Assign 3 : Explore Geology
    Update : 4.17.2019
*/


final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int SPACEING_NUM = 8;
final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int TOTAL_LIFE = 5;

boolean DIR = true;
boolean downPressed, rightPressed, leftPressed;
boolean movingDown, movingRight, movingLeft;

int spacing, C, R, T;
float SPD, playerX, playerY, realPlayerY;
float soldierX, soldierY, cabbageX, cabbageY;

PImage soil[] = new PImage[6];
PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, life, cabbage, soldier, stone1, stone2;
PImage groundhog, groundhogDown, groundhogLeft, groundhogRight;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here
  spacing = width/SPACEING_NUM;
  SPD = (float)spacing / 15;
  T = 0;
  C = 5;
  R = 0;
  playerX = spacing * (C-1);
  playerY = spacing * (R-1) + 160;
  realPlayerY = playerY;
  soldierX = -spacing;
  soldierY = spacing * floor(random(0,4)) + 160;
  cabbageX = spacing * floor(random(0,8));
  cabbageY = spacing * floor(random(0,4)) + 160;
  
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
 
  bg = loadImage("img/bg.jpg");
  life = loadImage("img/life.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  groundhog = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  for( int n=0; n<soil.length; n++ ) soil[n] = loadImage("img/soil"+n+".png");
}

void draw() {
    /* ------ Debug Function ------ 
      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.
    */
    if ( debugMode ) {
      pushMatrix();
      translate( 0, cameraOffsetY );
    }
    /* ------ End of Debug Function ------ */

    
  switch ( gameState ) {
    case GAME_START: // Start Screen
      image( title, 0, 0 );
      if( START_BUTTON_X+START_BUTTON_W > mouseX && START_BUTTON_X < mouseX
       && START_BUTTON_Y+START_BUTTON_H > mouseY && START_BUTTON_Y < mouseY ) {
	image( startHovered, START_BUTTON_X, START_BUTTON_Y );
	if( mousePressed ){
          gameState = GAME_RUN;
          mousePressed = false;
	}
      }else{
	image( startNormal, START_BUTTON_X, START_BUTTON_Y );
      }
    break;


    case GAME_RUN: // In-Game
      // Background
      image( bg, 0, 0 );

      // Sun
      stroke( 255, 255, 0 );
      strokeWeight( 5 );
      fill( 253, 184, 19 );
      ellipse( 590, 50, 120, 120 );

      // Rolling
      pushMatrix();
      translate( 0, cameraOffsetY );

      // Grass
      fill( 124, 204, 25 );
      noStroke();
      rect( 0, 160-GRASS_HEIGHT, width, GRASS_HEIGHT );
                       
      // Ground
      for( int x=0; x<8; x++ ){
        for( int y=0; y<24; y++ ){
          /// --Soil
          //int type = y/4;
          //PImage img = soil[type];
	  println("1");
          image( soil[4], spacing*x, spacing*y+160 ); 

          /// --Stone
          switch(type){
            case 0:
            case 1:
              if( x == y ) image( stone1, spacing*x, spacing*y+160 );
            break;
            case 2:
            case 3:
              if( (y-x)%4 == 2 || (x+y)%4 == 1 ){  
                image( stone1, spacing*x, spacing*y+160 );
              }  
            break;
            default:
              if( (x+y)%3 != 1 ) image( stone1,spacing*x, spacing*y+160 );
              if( (x+y)%3 == 0 ) image( stone2, spacing*x, spacing*y+160 );
            break;
      } } }

      // Cabbage
      if( cabbageX+20<playerX+80 && cabbageX+60>playerX
       && cabbageY+20<realPlayerY+80 && cabbageY+60>realPlayerY ){
        playerHealth += 1;
        cabbageX = 640;
      }else{
        image( cabbage, cabbageX, cabbageY );
      }
      
      // Soldier
      image( soldier, soldierX += 5, soldierY );
      if( soldierX > width ) soldierX = -spacing;

      if( soldierX<playerX+80 && soldierX+80>playerX
       && soldierY<realPlayerY+80 && soldierY+80>realPlayerY ){
        playerHealth -= 1;       
        movingDown = false;
        movingRight = false;
        movingLeft = false;
        T = 0;
        C = 5;
        R = 0;
        cameraOffsetY = 0;
        DIR = true;
        playerX = spacing*4;
        playerY = spacing*1;
        realPlayerY = playerY;
        if( keyPressed ){
          downPressed = false;
          rightPressed = false;
          leftPressed = false;
      } }
      
      // Rolling
      popMatrix();
      
      // Player
      /// --Srop
      if( !movingDown && !movingRight && !movingLeft ){
        image( groundhog, playerX, playerY );
      }

      /// --Condition
      if( downPressed && !rightPressed && !leftPressed ){
          movingDown = true;
          movingRight = false;
          movingLeft = false;
      }
      if( !downPressed && rightPressed && !leftPressed ){
          movingDown = false;
          movingRight = true;
          movingLeft = false;
      }      
      if( !downPressed && !rightPressed && leftPressed  ){
          movingDown = false;
          movingRight = false;
          movingLeft = true;
      }
        
      /// --Movement
      if( movingDown ){
        if( R < 24 ){                    
          if( T < 15 ){
            DIR = false;
            T ++;
            realPlayerY += SPD;
            if( R < 20 ) cameraOffsetY -= SPD;              
            else playerY += SPD;
          }else{          
            DIR = true; 
            T = 0;
            R += 1;
            playerY = round(playerY);
            cameraOffsetY = round(cameraOffsetY);
            realPlayerY = round(realPlayerY);
            movingDown = ( downPressed ) ? true : false;
          }
        }else{
          R = 24;
          movingDown = ( downPressed ) ? true : false;
        }
        image( groundhogDown, playerX, playerY );
      }
    
      if( movingRight ){        
        if( C < 8 ){
          if( T < 15 ){         
            DIR = false;
            T ++;
            playerX += SPD;
          }else{          
            DIR = true; 
            T = 0;
            C += 1;
            playerX = spacing * (C-1);
            movingRight = ( rightPressed ) ? true : false;
          }
        }else{
          C = 8;
          movingRight = ( rightPressed ) ? true : false;
        }
        image( groundhogRight, playerX, playerY );
      }

      if( movingLeft ){        
        if( C > 1 ){
          if( T < 15 ){         
            DIR = false;
            T ++;
            playerX -= SPD;
          }else{          
            DIR = true; 
            T = 0;
            C -= 1;
            playerX = spacing * (C-1);
            movingLeft = ( leftPressed ) ? true : false;
          }
        }else{
          C = 1;
          movingLeft = ( leftPressed ) ? true : false;
        }
        image( groundhogLeft, playerX, playerY );
      }
      
      // Health UI
      for( int l=0; l<playerHealth; l++ ){
        image( life, 10+(50+20)*l,10 );
      }
      if( playerHealth < 1 ) gameState = GAME_OVER;
    
    break;


    case GAME_OVER: // Gameover Screen
      image(gameover, 0, 0);		
      if(START_BUTTON_X + START_BUTTON_W > mouseX && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY && START_BUTTON_Y < mouseY) {
	image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
	if(mousePressed){
          gameState = GAME_RUN;
          mousePressed = false;
          // Remember to initialize the game here!    
          playerHealth = 2;
          cameraOffsetY = 0;
          DIR = true;
          T = 0;
          C = 5;
          R = 0;
          playerX = spacing * (C-1);
          playerY = spacing * (R-1) + 160;
          realPlayerY = playerY;
          soldierX = -spacing;
          soldierY = spacing * floor(random(0,4)) + 160;
          cabbageX = spacing * floor(random(0,8));
          cabbageY = spacing * floor(random(0,4)) + 160;
        }
      }else{
	image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
      }
    break;		
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
  // Add your moving input code here
  if( DIR ){
   switch(keyCode){
     case DOWN:
       downPressed = true;
     break; 
     case RIGHT:
       rightPressed = true;
     break;
     case LEFT:
       leftPressed = true;
     break;
   } }

  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;
      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;
      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;
      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
} }

void keyReleased(){
  switch(keyCode){    
    case DOWN:
      downPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
} }
