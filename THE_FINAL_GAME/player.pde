Sprite player;

float pos_x = 20;
float pos_y = 130;
boolean stopN; // true = object in the way
boolean stopS; // true = object in the way
boolean stopE; // true = object in the way
boolean stopW; // true = object in the way
float playerRealSpeed = 4; // how fast you REALLY walk
float playerAnimateSpeed = .1; // how fast you APPEAR to walk
float elapsedTime; // animation timing
StopWatch sw = new StopWatch(); // animation timing
int playerHealthBarOriginal = 200;
int playerHealthBar = playerHealthBarOriginal;
boolean isDead = false;
int damage = 8;

// WEAPONS
Sprite weapon;
boolean swordToggle = true;
boolean battleToggle = true;
boolean haveWeapon = true;
float weapon_x = 20;
float weapon_y = -7;
float weapon_rot = 1.3;
float weapon_Y_jostle = 0;
float weapon_X_jostle = 0;
float wep_jstl_timer = 0;
int lastMoveKey = 3; // weapon placemet


void player() {
  //LEFT
  if (curKey == 0 || lastMoveKey == 0) {
    if (stopW == false && curKey == 0) {
      player.setFrameSequence(4, 7, playerAnimateSpeed); //start frame, end frame
      pos_x-=playerRealSpeed;
    }
    if (haveWeapon == true && curKey != 4) {// have weapon and is at rest
      weapon_x = -12 + weapon_X_jostle;
      weapon_y = 1 + weapon_Y_jostle;
      weapon_rot = 0;
    } else if (haveWeapon ==true && curKey ==4) {
      weapon_x = -18;
      weapon_y = 5;
      weapon_rot = -0.5;
    }
  }//LEFT


  //RIGHT
  if (curKey == 1 || lastMoveKey == 1 ) {
    if (stopE == false && curKey == 1) {
      player.setFrameSequence(8, 11, playerAnimateSpeed); //start frame, end frame
      pos_x+=playerRealSpeed;
    }
    if (haveWeapon == true && curKey != 4) {
      weapon_x = 12 + weapon_X_jostle;
      weapon_y = 1 + weapon_Y_jostle;
      weapon_rot = 1.7;
    } else if (haveWeapon ==true && curKey ==4) {
      weapon_x = 18;
      weapon_y = 5;
      weapon_rot = 2.1;
    }
  }//RIGHT



  //UP
  if (curKey == 2 || lastMoveKey == 2) {
    if (stopN == false && curKey == 2) {
      player.setFrameSequence(12, 15, playerAnimateSpeed); //start frame, end frame
      pos_y-=playerRealSpeed;
    }
    if (haveWeapon == true && curKey != 4) {
      weapon_x = -14 + weapon_X_jostle;
      weapon_y = -3 + weapon_Y_jostle;
      weapon_rot = 0.4;
    } else if (haveWeapon ==true && curKey ==4) {
      weapon_x = 12;
      weapon_y = -11;
      weapon_rot =1.3;
    }
  }//UP



  //DOWN
  if (curKey == 3 || lastMoveKey == 3 ) {
    if (stopS == false && curKey == 3) {
      player.setFrameSequence(0, 3, playerAnimateSpeed); //start frame, end frame
      pos_y+=playerRealSpeed;
    }
    if (haveWeapon == true && curKey != 4) {
      weapon_x = 20 + weapon_X_jostle;
      weapon_y = -7 + weapon_Y_jostle;
      weapon_rot = 1.3;
    } else if (haveWeapon ==true && curKey ==4) {
      weapon_x = 4;
      weapon_y = 15;
      weapon_rot = -1.6;
    }
  }//DOWN

  //IDLE
  if (curKey == 9) {
    if (lastMoveKey == 0) {
      player.setFrameSequence(4, 4, 0);
    }
    if (lastMoveKey == 1) {
      player.setFrameSequence(8, 8, 0);
    }
    if (lastMoveKey == 2) {
      player.setFrameSequence(12, 12, 0);
    }
    if (lastMoveKey == 3) {
      player.setFrameSequence(0, 0, 0);
    }
  }//IDLE

  //keep player inside the window (and above the health bar)
  pos_x = constrain(pos_x, 12, width - 12);
  pos_y = constrain(pos_y, 16, height - 44);

  player.setXY(pos_x, pos_y);
  elapsedTime = (float) sw.getElapsedTime();
  S4P.updateSprites(elapsedTime);

  if (playerHealthBar < 1 && !isDead) {
    isDead = true; //player is dead... =(
    deathSound.play();
  }

  player.setScale(1); //player size
  if (isDead) {
    tint(120, 150); // grey and see-through
  } else if (playerHealthBar < 31) {
    tint(255, 0, 0); // low health = red
  } else {
    noTint();
  }
  player.draw();
  noTint();

  // hit harder when you're almost dead
  if (playerHealthBar < 31) {
    damage = 12;
  } else {
    damage = 8;
  }
} //PLAYER


// The bar along the bottom: your health, the room and your diamonds
void drawHUD() {
  noStroke();
  fill(0, 150);
  rect(0, height-25, width, 25); // x,y,w,h

  textAlign(LEFT, CENTER);
  textSize(12);
  fill(255);
  text("YEET", 6, height-13);

  // health bar
  float barW = 100;
  float healthW = map(playerHealthBar, 0, playerHealthBarOriginal, 0, barW);
  noFill();
  stroke(255);
  rect(45, height-18, barW, 10); // HEALTHBAR OUTLINE
  noStroke();
  if (playerHealthBar < 31) {
    fill(255, 80, 80);
  } else {
    fill(255);
  }
  rect(45, height-18, healthW, 10); //PART THAT CHANGES

  // room and diamonds
  textAlign(RIGHT, CENTER);
  fill(255);
  text("ROOM " + level + "/" + LAST_ROOM + "    ", width - 40, height-13);
  loot.setXY(width - 30, height - 13);
  loot.setFrameSequence(210, 210, 0);
  loot.setScale(0.6);
  loot.draw();
  loot.setScale(1);
  textAlign(LEFT, CENTER);
  text(diamond, width - 20, height-13);
}
