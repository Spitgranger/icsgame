boolean start, instructions, finish, mouseClick, enterScore, topScore;
String instructions1, instructions2, top1, top2, top3;
int level, startTime, score, dRow, dCol, c, nameAmount;
float transparency;

int[] row;
int[] col;

int[] saturation = {100, 105, 110, 115, 120, 130, 140, 150, 160, 170, 180, 190, 191, 192, 193, 194, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195};
int[] brightness= {110, 120, 130, 140, 150, 155, 160, 165, 170, 175, 180, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195, 195};

HashMap <Integer, String> ranks = new HashMap <Integer, String>();

PImage pin;
PImage logo;
void settings(){ 
  fullScreen();
}
void setup(){
  frameRate(30);
  //Loading the highscore table
  highScores = loadTable("data/scores.csv", "header");
  highScores.sortReverse("score");
  if (nameAmount > 0) {
    TableRow row1 = highScores.getRow(0);
    top1 =  row1.getString("name");
  }
  if (nameAmount > 1) {
    TableRow row2 = highScores.getRow(1);
    top2 =  row2.getString("name");
  }
  if (nameAmount > 2) {
    TableRow row3 = highScores.getRow(2);
    top3 =  row3.getString("name");
}
nameAmount = highScores.getRowCount();

  row = new int[(int)Math.floor(displayHeight/100)]; //Automatically calculates the optimal grid size for screens.
  col = new int[(int)Math.floor(displayHeight/100)];
  transparency = 0;
  ratings();
  colorMode(HSB, 255);
  startTime = 1800; //30 frames per second * 60 seconds is 1800
  score = 0; //Set the score to 0 at first
  for (int i = 0; i < Math.floor(displayHeight/100); i++) { //fill the arrays with values of i * 100, since 100 is the width of each square
    row[i] = i*100;
    col[i] = i*100;
  }
  dRow = (int)random(0, row.length); //randomize the row value of the different square
  dCol = (int)random(0, col.length); //randomize the col value of the different square
  c = (int)random(0, 255); //randomize the color value of the different square

  mouseClick = false;
  start = false;
  instructions = true;
  finish = false;
  topScore = false;
  instructions1 = "You have 60 seconds to get as high as a score as you can. Each food is worth 2 points.";
  instructions2 = "Every time you eat food, your snake will increase by 5 pixels.";
  strokeWeight(0);
  logo = loadImage("colorspotLogo.png");
  pin = loadImage("pushpin.png");
}
void draw(){
   if (instructions) {
    loop();
    for (int i = 0; i < 5; i++) { //Updating the "transparency" value for the fading effect
      transparency += 1;
    }
    fill(20, transparency);
    rectMode(CORNER);
    rect(0, 0, width, height);
    //"Color Spot" Title Text
    image(logo, 50,50);
    //Instructions Background Shapes
    rectMode(CENTER);
    fill(25, 186, 254);
    rect(width/2 + 5, height/2.4 + 5, width/2, height/3);
    fill(25, 120, 254);
    rect(width/2, height/2.4, width/2, height/3);
    //Instructions
    textSize(32);
    textAlign(CENTER);
    fill(250);
    text("By: ASDGFSDGSDSASu", width/2, height/5);
    fill(30);
    text(instructions1, width/2, height/1.9, width/2, height/2);
    textSize(35);
    text(instructions2, width/2, height/1.4, width/2, height/2);
    pin.resize(0, 45);
    image(pin, width/2, height/4.1);
    //Start button
    fill(198, 100, 200);
    rect(width/3.5 + 5, height/1.2 + 5, width/5, width/12);
    fill(198, 120, 254);
    rect(width/3.5, height/1.2, width/5, width/12);
    fill(198, 100, 150);
    textSize(92);
    text("START", width/3.5, height/1.16);
    fill(200, 50, 255);
    textSize(89);
    text("START", width/3.5, height/1.16);
    image(pin, width/3.5, height/1.325);
    //Check highscores button
    fill(99, 100, 200);
    rect(width/1.3 + 5, height/1.2 + 5, width/3, width/12);
    fill(99, 120, 254);
    rect(width/1.3, height/1.2, width/3, width/12);
    fill(99, 100, 150);
    textSize(92);
    text("HIGHSCORES", width/1.3, height/1.16);
    fill(101, 50, 255);
    textSize(90);
    text("HIGHSCORES", width/1.3, height/1.16);
    image(pin, width/1.3, height/1.325);
    if (mousePressed && mouseX > 355 && mouseX < 745 && mouseY > 920 && mouseY < 1084) { //If START is pressed
      start = true;
      instructions = false;
      frameCount = 0;
    }
    if (mousePressed && mouseX > 1157 && mouseX < 1800 && mouseY > 920 && mouseY < 1084) { //If HIGHSCORES is pressed
      highScores.sortReverse("score");
      instructions = false;
      topScore = true;
      enterScore = false;
    }
   }
}