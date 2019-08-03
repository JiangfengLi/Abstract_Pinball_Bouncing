/* Authors: Eric Jaramillo, Matthew Lee, Jiangfeng Li
 *
 * This program displays a 1500x750 canvas with rectangles that influence and interact
 * with a ball moving throughout the screen. THe environment is mostly interactive in that
 * obstacles can be added, the ball can be customized and custom sounds can be recorded. Along
 * with other options such as a pause and shake function
 *
 * Key binds:
 * 'u' = change location of ball to random location
 *
 * Note: make sure to click on canvas before trying key binds
 */
import ddf.minim.*;
Minim minim;
AudioInput in;
AudioRecorder recorder; // varibles to keep track of user’s records

//This class is for the rectangles on the canvas that interact with the ball
class Obstacle {
  int x;
  int y;
  int oWidth;
  int oHeight;
  int r;
  int g;
  int b;
  int moveSpeed;

  //plain constructor for generating random objects
  Obstacle() {
  x = (int) random(1400);
  y =  (int) random(500);
  oWidth = (int) random(50, 100);
  oHeight = (int) random(50, 100);
  moveSpeed = (int) random(1, 4);
  changeColor();
  }

  //constructor for custom placed objects
  Obstacle(int new_x, int new_y) {
  x = new_x;
  y = new_y;
  oWidth = (int) random(50, 100);
  oHeight = (int) random(50, 100);
  moveSpeed = (int) random(1, 4);
  changeColor();
  }

  //used to set the x and y values of the obstacle
  void setCoords(int newX, int newY) {
  x = newX;
  y = newY;
  }

  //draws the obstacle to the canvas
  void drawObstacle() {
  fill(r, g, b);
  rect(x, y, oWidth, oHeight);
  }

  //changes the obstacle color to a random color
  void changeColor() {
  r = (int) random(255);
  g = (int) random(255);
  b = (int) random(255);
  }

  //moves the obstacles in random directions to simulate movement
  void shakeObstacles() {
  int direction = (int) random(4);
  if (direction == 0) {
    setCoords(x - moveSpeed, y - moveSpeed);
  } else if (direction == 1) {
    setCoords(x - moveSpeed, y + moveSpeed);
  } else if (direction == 2) {
    setCoords(x + moveSpeed, y - moveSpeed);
  } else if (direction == 3) {
    setCoords(x + moveSpeed, y + moveSpeed);
  }
  }
}

//This class creates on/off like buttons to toggle events
class ButtonSet {
  int x1 = 0;
  int y1 = 0;
  int bWidth1 = 0;
  int bHeight1 = 0;

  int x2 = 0;
  int y2 = 0;
  int bWidth2 = 0;
  int bHeight2 = 0;

  String textStr;
  boolean on1 = false;
  boolean on2 = true;

  //constuctor that takes in the position and size of buttons to be displayed
  ButtonSet(int xNew, int yNew, int hei, int wid, String tex) {
  x1 = xNew;
  y1 = yNew;
  bHeight1 = hei;
  bWidth1 = wid;

  x2 = xNew + bWidth1 + 25;
  y2 = yNew;
  bHeight2 = hei;
  bWidth2 = wid;

  textStr = tex;
  }

  //updates the status of the button clicked
  void update() {
  if (mousePressed == true) {
    //checks if left button was pressed
    if (mouseX >= x1 && mouseX <= x1 + bWidth1 && mouseY >= y1 && mouseY <= y1 + bHeight1) {
      if (!on1) {
        on1 = true;
        on2 = false;
      }
    }

    //checks if right button was pressed
    if (mouseX >= x2 && mouseX <= x2 + bWidth2 && mouseY >= y2 && mouseY <= y2 + bHeight2) {
      if (!on2) {
        on2 = true;
        on1 = false;
      }
    }
  }
  }

  //draws the buttons to the canvas
  void drawToCanvas() {
  if (on1) {
    fill(0, 128, 0);
    rect(x1, y1, bWidth1, bHeight1);
    fill(255, 0, 0);
    rect(x2, y2, bWidth2, bHeight2);
  } else {
    fill(255, 0, 0);
    rect(x1, y1, bWidth1, bHeight1);
    fill(0, 128, 0);
    rect(x2, y2, bWidth2, bHeight2);
  }
  textSize(32);
  fill(0);
  text(textStr, x2 + bWidth2 +10, y2 + bHeight2 / 2);
  }

  //returns status of left button
  boolean isOn() {
  return on1;
  }

  //returns status of right button
  boolean isOff() {
  return on2;
  }
}

//This class creates buttons for preset ball selection
class BallSelection {
  int x1 = 0;
  int y1 = 0;
  int bWidth1 = 0;
  int bHeight1 = 0;

  int x2 = 0;
  int y2 = 0;
  int bWidth2 = 0;
  int bHeight2 = 0;

  int x3 = 0;
  int y3 = 0;
  int bWidth3 = 0;
  int bHeight3 = 0;

  String textStr;
  boolean on1 = false;
  boolean on2 = false;
  boolean on3 = true;

  //constructor that takes in the position and size of buttons to display
  BallSelection(int xNew, int yNew, int hei, int wid, String tex) {
  x1 = xNew;
  y1 = yNew;
  bHeight1 = hei;
  bWidth1 = wid;

  x2 = xNew + bWidth1 + 25;
  y2 = yNew;
  bHeight2 = hei;
  bWidth2 = wid;

  x3 = xNew + bWidth1 + bWidth2 + 50;
  y3 = yNew;
  bHeight3 = hei;
  bWidth3 = wid;

  textStr = tex;
  }

  //updates the status of the buttons clicked
  int update() {
  if (mousePressed == true) {
    //checks if leftmost button was pressed
    if (mouseX >= x1 && mouseX <= x1 + bWidth1 && mouseY >= y1 && mouseY <= y1 + bHeight1) {
      if (!on1) {
        on1 = true;
        on2 = false;
        on3 = false;
      }
      return 1;
    }

    //checks if center button was pressed
    if (mouseX >= x2 && mouseX <= x2 + bWidth2 && mouseY >= y2 && mouseY <= y2 + bHeight2) {
      if (!on2) {
        on1 = false;
        on2 = true;
        on3 = false;
      }
      return 1;
    }

    //checks if rightmost button was pressed
    if (mouseX >= x3 && mouseX <= x3 + bWidth2 && mouseY >= y3 && mouseY <= y3 + bHeight2) {
      if (!on3) {
        on1 = false;
        on2 = false;
        on3 = true;
      }
      return 1;
    }
  }
  return 0;
  }

  //draws the buttons to the canvas
  void drawToCanvas() {
  if (on1) {
    fill(0, 128, 0);
    rect(x1, y1, bWidth1, bHeight1);
    fill(255, 0, 0);
    rect(x2, y2, bWidth2, bHeight2);
    fill(255, 0, 0);
    rect(x3, y3, bWidth3, bHeight3);
  } else if (on2) {
    fill(255, 0, 0);
    rect(x1, y1, bWidth1, bHeight1);
    fill(0, 128, 0);
    rect(x2, y2, bWidth2, bHeight2);
    fill(255, 0, 0);
    rect(x3, y3, bWidth3, bHeight3);
  } else {
    fill(255, 0, 0);
    rect(x1, y1, bWidth1, bHeight1);
    fill(255, 0, 0);
    rect(x2, y2, bWidth2, bHeight2);
    fill(0, 128, 0);
    rect(x3, y3, bWidth3, bHeight3);
  }
  textSize(32);
  fill(0);
  text(textStr, x3 + bWidth3 +10, y3 + bHeight3 / 2);
  }

  //returns status of leftmost button
  boolean isOne() {
  return on1;
  }  

  //returns status of center button
  boolean isTwo() {
  return on2;
  }

  //returns status of rightmost button
  boolean isThree() {
  return on3;
  }
}

//This class creates sliders for the ball customization
class Slider {
  int x;
  int y;
  int nX;
  int nY;
  int lWidth;
  int lHeight;
  int nWidth;
  int nHeight;
  String textStr;
  int val;

  //This constuctor takes in the x and y position of the sliders along with a default starting point
  Slider(int newX, int newY, int newWidth, int newHeight, String newText, int defaultVal) {
  x = newX;
  y = newY;
  lWidth = newWidth;
  lHeight = newHeight;
  textStr = newText;
  nX = newX + 4 + defaultVal;
  nY = newY - 5;
  nWidth = 10;
  nHeight = newHeight + 10;
  //val = (nX - x) / 4;
  val = defaultVal;
  }

  //updates the status of the slider
  void update() {
  if (mousePressed) {
    if (mouseX >= x && mouseX <= x + lWidth && mouseY >= y && mouseY <= y + lHeight + nHeight + 10) {
      if (mouseX >= x && mouseX <= x + lWidth) {
        nX = mouseX;
        val = (nX - x) / 4;
      }
    }
  }
  }

  //draws the sliders to the canvas
  void drawToCanvas() {
  fill(0);
  rect(x, y, lWidth, lHeight);
  fill(0, 0, 255);
  rect(nX, nY, nWidth, nHeight);
  fill(0);
  //text(textStr + ": " + ((nX - x) / 4), x + lWidth +10, y + lHeight / 2);
  text(textStr + ": " + val, x + lWidth +10, y + lHeight / 2);
  }

  //returns the value of the slider
  int getVal() {
  return val;
  }
}

//creates a ball class with variables and functions to control the movement of the ball and its properties
class Ball {
  int xspeed, yspeed, xdir, ydir = 0;
  int r = 0;
  int xpos = 750;
  int ypos = 275;
  int red, blue, green = 0;

  //constructor to make custom ball
  Ball(int xs, int ys, int xd, int yd, int rad) {
  xspeed = xs;
  yspeed = ys;
  xdir = xd;
  ydir = yd;
  r = rad;
  }
  //pre-set ball constructors
  Ball(int n) {
  if (n == 1) {
    xspeed = 6;
    yspeed = 6;
    xdir = 1;
    ydir = 1;
    r = 20;
    red = 255;
    green = 0;
    blue = 0;
  }
  if (n == 2) {
    xspeed = 4;
    yspeed = 7;
    xdir = 1;
    ydir = 2;
    r = 30;
    blue = 255;
    red = 0;
    green = 0;
  }
  if (n == 3) {
    xspeed = 2;
    yspeed = 4;
    xdir = 2;
    ydir = 1;
    r = 15;
    green = 255;
    blue = 0;
    red = 0;
  }
  }

  //setter to change the xpos of the ball
  void setX(int x) {
  xpos = x;
  }

  //setter th change the ypos of the ball
  void setY(int y) {
  ypos = y;
  }

  //determines the movement of the ball, color, canvas
  void move() {
  // Update the position of the shape
  xpos += ( xspeed * xdir );
  ypos += ( yspeed * ydir );
  collision(); //detects collisions
  background(R, G, B);
  fill(red, green, blue);
  ellipse(xpos, ypos, r, r);
  }

  void collision() {
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-r || xpos < r) {
    //play the sound effect for corresponding walls
    if (xpos > width-r)  
      playRandomly(0);
    else
      playRandomly(1);
    xdir *= -1;    
    //changes color of background
    R = random(255);
    B =random(255);
    G = random(255);
  }

  if (ypos > height-200-r || ypos < r) {
    //play the sound effect for corresponding walls
    if (ypos > height-200-r)
      playRandomly(2);
    else
      playRandomly(3);
    ydir *= -1;
    R = random(255);
    B =random(255);
    G = random(255);
  }
  // detects each obstacle and determines if the ball will collide
  for (Obstacle o : obstacleList) {
    // determines if the ball hits the rectangle at all
    if (ypos + r > o.y && ypos - r < o.y + o.oHeight &&
      xpos + r > o.x && xpos - r < o.x + o.oWidth) {
      // determines if hits on a x side of the rectangle or y side
      if ((xpos + r) <= o.x + r/2 || (xpos - r) >= o.x + o.oWidth - r/2) {
        xdir *= -1;
      } else {
        ydir *= -1;// * random(2);
      }
      R = random(255);
      B =random(255);
      G = random(255);
      playRandomly((int)random(4, 9));
      return;
    }
  }
  }

  // play the sound effect in sounds list according to index num
  void playRandomly(int num) {
  SoundList[num].rewind();
  SoundList[num].play();
  }

  void setSpeed(int speed) {
  xspeed = speed;
  yspeed = speed;
  }

  void setSize(int size) {
  r = size;
  }

  int getSpeed() {
  return (int) xspeed;
  }

  int getSize() {
  return r;
  }
}

// global variables
Slider customSize;
Slider customSpeed;
BallSelection currentBall;
ButtonSet customBall;
ButtonSet pauseScene;
ButtonSet shakeOb;
ButtonSet addOb;
ButtonSet customSound;
ArrayList<Obstacle> obstacleList = new ArrayList<Obstacle>();
ArrayList<Ball> ballList = new ArrayList<Ball>();
boolean pause = false;
boolean makeNewObstacle = false;
float xpos, ypos;
float R = 0;
float G = 0;
float B = 0;
Ball ball = new Ball(1);
AudioPlayer[] SoundList = new AudioPlayer[9];

//sets up the canvas, draws the initial random obstacles, creates the buttons and
//preloads the sounds that will be used throughout
void setup() {
  size(1500, 750);
  background(255, 255, 255);
  line(0, 550, 1500, 550);
  frameRate(60);
  noStroke();
  ellipseMode(RADIUS);

  //creates all buttons and sliders
  customSound = new ButtonSet(1150, 675, 40, 40, "Custom Sound");
  customBall = new ButtonSet(1150, 600, 40, 40, "Custom Ball");
  pauseScene = new ButtonSet(50, 600, 40, 40, "Pause");
  shakeOb = new ButtonSet(50, 675, 40, 40, "Shake");
  addOb = new ButtonSet(300, 600, 40, 40, "Add Obstacle");
  currentBall = new BallSelection(300, 675, 40, 40, "Ball Selection");
  customSize = new Slider(750, 600, 200, 10, "Size", 10);
  customSpeed = new Slider(750, 675, 200, 10, "Speed", 3);

  //append sound file to the list of sound effects
  minim = new Minim (this);
  in = minim.getLineIn();

  SoundList[0] = minim.loadFile("spinJump.mp3");
  SoundList[1] = minim.loadFile("WesternRicochet.wav");
  SoundList[2] = minim.loadFile("BounceSoundBible623.wav");
  SoundList[3] = minim.loadFile("Bench.wav");
  SoundList[4] = minim.loadFile("marbles-daniel_simon.wav");
  SoundList[5] = minim.loadFile("Sword Swing.wav");
  SoundList[6] = minim.loadFile("Blop.wav");
  SoundList[7] = minim.loadFile("service-bell.mp3");
  SoundList[8] = minim.loadFile("spin_jump.wav");
  recorder = minim.createRecorder(in, "myRecord.wav");

  for (int i = 0; i < 10; i++) { //populates the canvas with random obstacles
  Obstacle newO = new Obstacle();
  obstacleList.add(newO);
  }

  for (int i = 1; i < 4; i++) {
  Ball b = new Ball(i);
  ballList.add(b);
  }
}

//resets the background to simulate movement and draws control panel to the scene
void draw() {
  if (!pause) { //pauses the scene
  ball.move();
  }
  if (shakeOb.isOn() && !pause) { //handles shaking the obstacles
  background(R, G, B);
  for (Obstacle ob : obstacleList) { //loops through array of obstacles
    ob.shakeObstacles();
    if (!pause) {
      ball.move();
    }
  }
  }
  if (pauseScene.isOn()) { //pauses scene
  pause = true;
  }
  if (pauseScene.isOff()) { //unpauses the scene
  pause = false;
  }
  if (addOb.isOn()) { //toggles on create new obstacles
  makeNewObstacle = true;
  }
  if (addOb.isOff()) { //turns off create new obstacles
  makeNewObstacle = false;
  }
  for (Obstacle ob : obstacleList) { //draws all bstacles
  ob.drawObstacle();
  }
  noStroke();
  fill(#D3D3D3);
  rect(0, 550, 1500, 200);
  stroke(0);
  line(0, 550, 1500, 550);
  pauseScene.drawToCanvas();
  pauseScene.update();

  //These draw the buttons to the canvas
  shakeOb.drawToCanvas();
  shakeOb.update();

  addOb.drawToCanvas();
  addOb.update();

  customBall.drawToCanvas();
  customBall.update();

  customSound.drawToCanvas();
  customSound.update();


  if (customBall.isOn()) { //checks if user wants to make custom ball
  customSize.drawToCanvas();
  customSize.update();
  customSpeed.drawToCanvas();
  customSpeed.update();
  ball.setSpeed(customSpeed.getVal());
  ball.setSize(customSize.getVal());
  }
  if (customBall.isOff()) { //turns off ball customization
  currentBall.drawToCanvas();
  currentBall.update();
  }

  //start recording if the customSound is on and user is not recording sound
  if (customSound.isOn() && !recorder.isRecording()) {

  recorder = minim.createRecorder(in, "myRecord.wav");
  recorder.beginRecord();
  }

  // end and save the recording if customSound is off and recorder is recording
  if (customSound.isOff() && recorder.isRecording()) {
  //send recording and overwrite a sound file in position 7
  recorder.endRecord();
  recorder.save();
  SoundList[8] = minim.loadFile("myRecord.wav");
  }
}

//handles mouse presses for creating new obstacles
void mousePressed() {
  if (makeNewObstacle) { //if the user wants to make new obstacles
  Obstacle newObstacle = new Obstacle(mouseX, mouseY);
  obstacleList.add(newObstacle);
  }
  if (currentBall.isOne() && !makeNewObstacle && currentBall.update() == 1) { //sets ball to preset 1
  ball = new Ball(1);
  }
  if (currentBall.isTwo() && !makeNewObstacle && currentBall.update() == 1) { //sets ball to preset 2
  ball = new Ball(2);
  }
  if (currentBall.isThree() && !makeNewObstacle && currentBall.update() == 1) { //sets ball to preset 3
  ball = new Ball(3);
  }
}

//handles key presses
void keyPressed() {
  //places ball at random location on board
  if (key == 'u') {  
  ball.setX((int) random(1300));
  ball.setY((int) random(500));
  }
}
