import java.util.HashSet;
import sprites.*;
import sprites.maths.*;
import sprites.utils.*;
import processing.sound.*;
int level = 0;


SoundFile sword, monsterHit, drink, jewel;



Sprite BACKGROUND1, smallplants, smallplantsyes, Gold, PLANTS2, TREES2, sword3, pillars, cracks4, cracks5, WINTER4, finalroom5, BACKGROUND2, BACKGROUND3, BACKGROUND4, BACKGROUND5, BACKGROUND6, loot, start, pokeball;

void setup() {
  size(320, 320, P2D);

  player = new Sprite(this, "charmander.png", 4, 4, 0); // Columns,and rows


  //ENVIROMENT
  BACKGROUND1 = new Sprite(this, "BACKGROUND1.png", 1, 1, 0);
  smallplants = new Sprite(this, "smallplants.png", 1, 1, 0); 
  smallplantsyes = new Sprite(this, "smallplantsyes.png", 1, 1, 0);
  Gold = new Sprite(this, "Gold.png", 1, 1, 0);
  PLANTS2 = new Sprite(this, "PLANTS2.png", 1, 1, 0);
  TREES2 = new Sprite(this, "TREES2.png", 1, 1, 0);
  sword3 =  new Sprite(this, "sword3.png", 1, 1, 0);
  pillars = new Sprite(this, "pillars.png", 1, 1, 0);
  cracks4 = new Sprite(this, "cracks4.png", 1, 1, 0);
  cracks5 = new Sprite(this, "cracks5.png", 1, 1, 0);
  WINTER4 = new Sprite(this, "WINTER4.png", 1, 1, 0);
  finalroom5 = new Sprite(this, "finalroom5.png", 1, 1, 0);

  BACKGROUND2 = new Sprite (this, "BACKGROUND2.png", 1, 1, 0);

  BACKGROUND3 = new Sprite (this, "BACKGROUND3.png", 1, 1, 0);

  BACKGROUND4 = new Sprite (this, "BACKGROUND4.png", 1, 1, 0);

  BACKGROUND5 = new Sprite (this, "BACKGROUND5.png", 1, 1, 0);

  BACKGROUND6 = new Sprite (this, "BACKGROUND6.png", 1, 1, 0);





  //ITEMS
  weapon = new Sprite(this, "lots_of_stuff.png", 14, 30, 0);
  bottle_pink = new Sprite (this, "lots_of_stuff.png", 14, 30, 0);


  //SOUNDS
  sword = new SoundFile(this, "swing3.wav");
  monsterHit = new SoundFile(this, "sounds/random5.wav");
  drink = new SoundFile(this, "sounds/bubble2.wav");
  jewel = new SoundFile(this, "sounds/loot.wav");
  //monsters
  slime1.sprite = new Sprite(this, "sprites/characters/slime_sheet.png", 10, 20, 0);
  slime2.sprite = new Sprite(this, "sprites/characters/slime_sheet.png", 10, 20, 0);
  slime3.sprite = new Sprite(this, "sprites/characters/slime_sheet.png", 10, 20, 0);
  loot = new Sprite(this, "lots_of_stuff.png", 210, 220, 0);

  start = new Sprite(this, "start.png", 1, 1, 0); //start screen graphics
  pokeball = new Sprite(this, "pokeball.png", 1, 1, 0);
} // setup

void draw() {
  background(255, 255, 255, 0);//red blue green alpha(Transparent)

  //START GAME
  if (level == 0) {
    //fill(0);
    // textSize(20);
    //text("THE FINAL GAME", 50, height/2);
    start.setFrameSequence(1, 1, 0);
    start.setXY(width/2, height/2);
    start.draw();
  }

  if (level == 1) {
    smallplantsyes.setFrameSequence(1, 1, 0);
    smallplantsyes.setXY(width/2, height/2);
    smallplantsyes.draw();
  }



  objectCollide();



  if (level == 1) {
    BACKGROUND1.setFrameSequence(1, 1, 0);
    BACKGROUND1.setXY(width/2, height/2);
    BACKGROUND1.draw();
  }
  if (level == 1) {
    smallplants.setFrameSequence(1, 1, 0);
    smallplants.setXY(width/2, height/2);
    smallplants.draw();

    if (level == 1) 
      Gold.setFrameSequence(1, 1, 0);
    Gold.setXY(width/2, height/2);
    Gold.draw();
  }

  if (level == 2) {
    BACKGROUND2.setFrameSequence(1, 1, 0);
    BACKGROUND2.setXY(width/2, height/2);
    BACKGROUND2.draw();
  }
  if (level == 2) {
    PLANTS2.setFrameSequence(1, 1, 0);
    PLANTS2.setXY(width/2, height/2);
    PLANTS2.draw();

    if (level == 2) 
      TREES2.setFrameSequence(1, 1, 0);
    TREES2.setXY(width/2, height/2);
    TREES2.draw();
  }
  if (level == 3) {
    BACKGROUND3.setFrameSequence(1, 1, 0);
    BACKGROUND3.setXY(width/2, height/2);
    BACKGROUND3.draw();
  }
  if (level == 3) {
    sword3.setFrameSequence(1, 1, 0);
    sword3.setXY(width/2, height/2);
    sword3.draw();

    if (level == 3) 
      pillars.setFrameSequence(1, 1, 0);
    pillars.setXY(width/2, height/2);
    pillars.draw();
  }
  if (level == 4) {
    BACKGROUND4.setFrameSequence(1, 1, 0);
    BACKGROUND4.setXY(width/2, height/2);
    BACKGROUND4.draw();
  }
  if (level == 4) {
    cracks4.setFrameSequence(1, 1, 0);
    cracks4.setXY(width/2, height/2);
    cracks4.draw();

    if (level == 4) 
      WINTER4.setFrameSequence(1, 1, 0);
    WINTER4.setXY(width/2, height/2);
    WINTER4.draw();
  }
  if (level == 5) {
    BACKGROUND5.setFrameSequence(1, 1, 0);
    BACKGROUND5.setXY(width/2, height/2);
    BACKGROUND5.draw();
  }

  if (level == 5) {
    cracks5.setFrameSequence(1, 1, 0);
    cracks5.setXY(width/2, height/2);
    cracks5.draw();


    if (level == 5) 
      finalroom5.setFrameSequence(1, 1, 0);
    finalroom5.setXY(width/2, height/2);
    finalroom5.draw();
  }


  if (level == 6) {
    BACKGROUND6.setFrameSequence(1, 1, 0);
    BACKGROUND6.setXY(width/2, height/2);
    BACKGROUND6.draw();
  }




  if (lastMoveKey != 3 &&  level != 0) { // weapon behind player (going north)
    weapon.draw();
  }


  keyboard();
  player();

  //update monsters
  slime1.update();
  slime2.update();
  slime3.update();


  weapon.setRot(weapon_rot);
  weapon.setXY(pos_x + weapon_x, pos_y + weapon_y);
  weapon.setFrameSequence(78, 78, 0); //sword

  if (lastMoveKey == 3 && level != 0) {
    weapon.draw();
  }






 stopN = false;
 stopS = false;  
 stopE = false;
 stopW = false;

  items();
  inventory();

  //LOSING
  if (playerHealthBar < 1) {
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(width/2, height/2, 230, 130);
    stroke(2);
    color(000000);
    rect(width/2, height/2, 210, 110);
    rectMode(CORNER);
    textSize(20);
    fill(0);
    text("   YOU HAVE DIED", 20, height/2);
  }
} //draw
