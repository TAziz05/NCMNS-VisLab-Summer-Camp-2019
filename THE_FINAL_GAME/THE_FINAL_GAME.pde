// THE FINAL GAME
// Made at the NCMNS VisLab summer coding camp, 2019.
// Fixed up and upgraded in 2026 (see the README for what changed).

import java.util.HashSet;
import sprites.*;
import sprites.maths.*;
import sprites.utils.*;
import processing.sound.*;

int level = 0;       // 0 = start screen, 1-6 = rooms
int LAST_ROOM = 6;
boolean won = false;  // beat the last room?

SoundFile sword, monsterHit, drink, jewel;
// new sounds and music, written as code in 2026 (see data/sounds/coded)
SoundFile hurtSound, deathSound, winSound, roomSound, music;
int hurtSoundAt = 0;

Sprite BACKGROUND1, smallplants, Gold, PLANTS2, TREES2, sword3, pillars, cracks4, cracks5, WINTER4, finalroom5, BACKGROUND2, BACKGROUND3, BACKGROUND4, BACKGROUND5, BACKGROUND6, loot, start, pokeball;

// Wall maps for each room. Any solid pixel is a wall.
PImage[] walls = new PImage[LAST_ROOM + 1];

// Where you appear when you walk into each room (index = room number)
float[] spawnX = {20, 20, 20, 20, 20, 160, 20};
float[] spawnY = {130, 130, 130, 130, 130, 40, 130};

int roomBannerUntil = 0; // shows "ROOM 2" etc. for a moment

void setup() {
  size(320, 320, P2D);

  player = new Sprite(this, "charmander.png", 4, 4, 0); // Columns,and rows

  //ENVIROMENT
  BACKGROUND1 = new Sprite(this, "BACKGROUND1.png", 1, 1, 0);
  smallplants = new Sprite(this, "smallplants.png", 1, 1, 0);
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

  //WALLS
  walls[1] = loadImage("smallplantsyes.png");
  for (int i = 2; i <= LAST_ROOM; i++) {
    walls[i] = loadImage("walls" + i + ".png");
  }
  for (int i = 1; i <= LAST_ROOM; i++) {
    walls[i].loadPixels();
  }

  //ITEMS
  weapon = new Sprite(this, "lots_of_stuff.png", 14, 30, 0);
  bottle_pink = new Sprite (this, "lots_of_stuff.png", 14, 30, 0);

  //SOUNDS
  sword = new SoundFile(this, "swing3.wav");
  monsterHit = new SoundFile(this, "sounds/random5.wav");
  drink = new SoundFile(this, "sounds/bubble2.wav");
  jewel = new SoundFile(this, "sounds/loot.wav");
  hurtSound = new SoundFile(this, "sounds/coded/hurt.wav");
  deathSound = new SoundFile(this, "sounds/coded/death.wav");
  winSound = new SoundFile(this, "sounds/coded/win.wav");
  roomSound = new SoundFile(this, "sounds/coded/room.wav");
  music = new SoundFile(this, "sounds/coded/music.wav");
  music.loop();
  music.amp(0.35);
  //monsters
  slime1.sprite = new Sprite(this, "sprites/Characters/slime_sheet.png", 10, 20, 0);
  slime2.sprite = new Sprite(this, "sprites/Characters/slime_sheet.png", 10, 20, 0);
  slime3.sprite = new Sprite(this, "sprites/Characters/slime_sheet.png", 10, 20, 0);
  loot = new Sprite(this, "lots_of_stuff.png", 210, 220, 0);

  start = new Sprite(this, "start.png", 1, 1, 0); //start screen graphics
  pokeball = new Sprite(this, "pokeball.png", 1, 1, 0);
} // setup

void draw() {
  background(0);

  //START SCREEN
  if (level == 0) {
    start.setFrameSequence(1, 1, 0);
    start.setXY(width/2, height/2);
    start.draw();

    // blinking "press start"
    noStroke();
    fill(0, 170);
    rect(0, height - 46, width, 46);
    textAlign(CENTER, CENTER);
    fill(255);
    if ((millis() / 500) % 2 == 0) {
      textSize(16);
      text("PRESS Y TO START", width/2, height - 33);
    }
    textSize(10);
    fill(220);
    text("Arrows: move   Space/Ctrl: attack   I: inventory", width/2, height - 13);

    keyboard();
    return;
  }

  drawRoom();
  objectCollide();
  keyboard();

  items();

  //update monsters
  slime1.update();
  slime2.update();
  slime3.update();
  checkProgress();

  if (lastMoveKey != 3) { // weapon behind player (going north)
    drawWeapon();
  }
  player();
  if (lastMoveKey == 3) {
    drawWeapon();
  }

  stopN = false;
  stopS = false;
  stopE = false;
  stopW = false;

  drawHUD();
  drawRoomBanner();
  inventory();

  //LOSING
  if (isDead) {
    drawPanel(230, 110);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(22);
    text("YOU HAVE DIED", width/2, height/2 - 14);
    textSize(12);
    fill(90);
    text("Press R to try again", width/2, height/2 + 20);
  }

  //WINNING
  if (won) {
    drawPanel(230, 110);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(22);
    text("YOU HAVE WON!", width/2, height/2 - 14);
    textSize(12);
    fill(90);
    text("Press R to play again", width/2, height/2 + 20);
  }
} //draw

// Draws the background and decorations for the current room
void drawRoom() {
  if (level == 1) {
    drawLayer(BACKGROUND1);
    drawLayer(smallplants);
    drawLayer(Gold);
  }
  if (level == 2) {
    drawLayer(BACKGROUND2);
    drawLayer(PLANTS2);
    drawLayer(TREES2);
  }
  if (level == 3) {
    drawLayer(BACKGROUND3);
    drawLayer(sword3);
    drawLayer(pillars);
  }
  if (level == 4) {
    drawLayer(BACKGROUND4);
    drawLayer(cracks4);
    drawLayer(WINTER4);
  }
  if (level == 5) {
    drawLayer(BACKGROUND5);
    drawLayer(cracks5);
    drawLayer(finalroom5);
  }
  if (level == 6) {
    drawLayer(BACKGROUND6);
  }
}

void drawLayer(Sprite layer) {
  layer.setFrameSequence(1, 1, 0);
  layer.setXY(width/2, height/2);
  layer.draw();
}

void drawWeapon() {
  weapon.setRot(weapon_rot);
  weapon.setXY(pos_x + weapon_x, pos_y + weapon_y);
  weapon.setFrameSequence(78, 78, 0); //sword
  if (isDead) {
    tint(120, 150);
  }
  weapon.draw();
  noTint();
}

// White box with a black border, centered on the screen
void drawPanel(float w, float h) {
  rectMode(CENTER);
  noStroke();
  fill(255);
  rect(width/2, height/2, w, h);
  stroke(0);
  strokeWeight(2);
  noFill();
  rect(width/2, height/2, w - 20, h - 20);
  strokeWeight(1);
  noStroke();
  rectMode(CORNER);
}

void drawRoomBanner() {
  if (millis() < roomBannerUntil) {
    float a = constrain((roomBannerUntil - millis()) / 4.0, 0, 255);
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0, a);
    text("ROOM " + level, width/2 + 2, 42);
    fill(255, a);
    text("ROOM " + level, width/2, 40);
  }
}

// Move into a room: put the player at the entrance and show the room name
void enterRoom(int room) {
  level = room;
  pos_x = spawnX[room];
  pos_y = spawnY[room];
  roomBannerUntil = millis() + 1500;
  roomSound.play();
}

void startGame() {
  resetGame();
}

// Put everything back the way it was at the start
void resetGame() {
  playerHealthBar = playerHealthBarOriginal;
  isDead = false;
  won = false;
  diamond = 0;
  inventory = false;
  resetItems();
  slime1.respawn(60, 100, 30);
  slime2.respawn(90, 200, 150);
  slime3.respawn(70, 200, 40);
  curKey = 9;
  lastKey = 3;
  lastMoveKey = 3;
  enterRoom(1);
}
