int xPosition = 150+int(random(0, 1800));
int yPosition = 250;
int xSpeed = 8;
int ySpeed = 8;
int xPaddle = 600, yPaddle = 1000;
int paddleWidth =80;
int score =0;
int squaresGone;
int screen = 0;
int start = 0;
int done = 0;
int death = 0;
PImage img;
PFont epic;
PFont text;
boolean right = false;
boolean left = false;
float timer2 = 0;
float deathTimer = 300;
int gameScreen =0;
int[] squares = new int[30];
boolean mouseArea(int x1, int x2, int y1, int y2) {
  return mousePressed && mouseX > x1 && mouseX < x2 && mouseY>y1 && mouseY <y2;
}
/********* SETUP BLOCK *********/

void setup() {
  fullScreen();
  frameRate(60);
  epic = createFont("True Lies.ttf", 128);
  text = createFont("Slabo27px-Regular.ttf", 128);
  for (int i=0; i<30; i++) {
    squares[i] = 1;
    rectMode(CENTER);
  }
}


//what to draw

void draw() {
  // Display the contents of the current screen
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
  }
}
void mousePressed() {
  gameScreen=1;
}

//SCREEN CONTENTS 

void initScreen() {
  background(0);
  fill(255);
  ellipse(random(height), random(width), random(3, 5), random(3, 5));
  ellipse(random(mouseX-50, mouseX+50), random(mouseY-50, mouseY+50), random(3, 10), random(3, 8));
  ellipse(random(mouseX-75, mouseX+75), random(mouseY-75, mouseY+75), random(3, 8), random(3, 8));
  ellipse(random(mouseX-25, mouseX+25), random(mouseY-25, mouseY+25), random(3, 8), random(3, 8));
  //Text & Buttons
  fill(255);
  textSize(64);
  textAlign(CENTER);
  textFont(epic);
  fill(12, 0, 180);
  text("Baller", (width/2.5)+5, (height/4)+5);
  fill(210, 98, 255);
  text("Balller", width/2.5, height/4);

  fill(0, 147, 165);
  text("Launcher", (width/1.8)+5, (height/2)+5);
  fill(2, 230, 255);
  text("Launchher", width/1.8, height/2);

  rectMode(CENTER);
  textSize(32);
  fill(210, 98, 190);
  rect(width/2, height/1.5, 250, 50);
  fill(250);
  text("Start", width/2, height/1.465);
  fill(23, 230, 190);
  rect(width/2, height/1.3, 250, 50);
  fill(250);
  text("Controls", width/2, height/1.275);
}
void gameScreen() {
  int xCor, yCor;
  xPosition= xPosition+xSpeed;
  yPosition= yPosition+ySpeed;
  if (xPosition>width||xPosition<0) {
    xSpeed = -xSpeed;
  }
  if (yPosition<0) {
    ySpeed = -ySpeed;
  }
  if (keyPressed) {
    if (key =='d') {
      xPaddle = xPaddle +15;
    } else if (key == 'a') {
      xPaddle = xPaddle -15;
    } else if (key == 'r') {
      background(0);
      xPosition = 150+int(random(0, 1800));
      yPosition = 250;
      xSpeed = 8;
      ySpeed = 8;
      xPaddle = width/2;
      yPaddle = 1000;
      paddleWidth =80;
      score =0;
      for (int i =0; i<30; i++) {
        squares[i]=1;
      }
    }
  }
  if (xPaddle>width) {
    xPaddle =0;
  }
  if (xPaddle<0) {
    xPaddle = width;
  }

  if ((xPaddle-paddleWidth)<xPosition && (xPaddle+paddleWidth)>xPosition && (yPaddle-11)<yPosition && (yPaddle)>yPosition) {
    ySpeed *= -1;
    score = score +1;
    println("hi");
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  background(0);
  fill(0, 255, 0);
  textSize(30);
  textAlign(RIGHT);
  text("Score", 100, 1010);
  text(score, 160, 1010);
  fill(xPosition/2, yPosition/10, 100);
  ellipse(xPosition, yPosition, 30, 30);
  fill(0, 255, 0);
  rect(xPaddle, yPaddle, paddleWidth*2+1, 21);
  if (yPosition>height) {
    textSize(50);
    textAlign(CENTER);
    textSize(100);
    text("YOU ARE DEAD", width/2, height /2);
    textSize(50);
    text("Final Score" +" "+ score, width/2, height/2+70);
  }
  if (mousePressed) {
    xSpeed=-xSpeed;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //all squares exist since 30 squares
  squaresGone=30;
  for (int i =0; i<30; i++) {
    xCor= i%10*100+500;
    yCor= 40*(i/5)+10;
    if (squares[i]==1) {
      rect(xCor +40, yCor+10, 80, 20);
      squaresGone=0;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (xPosition>(xCor+4)&&xPosition<(xCor+76)&& yPosition>yCor && yPosition<(yCor+20)&&squares[i]==1) {
      squares[i]=0;
      ySpeed = -ySpeed;
      score = score + 2;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (((xPosition>(xCor-5) && xPosition<xCor) || (xPosition>(xCor+80) && xPosition<(xCor+85))) && yPosition>yCor&&yPosition<(yCor+20)&& squares[i]==1) {
      squares[i]=0;
      xSpeed = -xSpeed;
      score = score+2;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (((xPosition>(xCor-1) && xPosition<(xCor+5)) || xPosition>(xCor+75) && xPosition<(xCor+81)) && yPosition>yCor&& yPosition<(yCor+20) && squares[i]==1) {
      squares[i]=0;
      xSpeed = -xSpeed;
      ySpeed = -ySpeed;
      score = score+2;
    }
  }
}