int curKey = 9; // current Key
int lastKey = 3;

void keyboard() {

  if (keyPressed) {

    if (level == 0) { //start
      if (key == 'y' || key == 'Y' || key == ENTER || key == RETURN) {
        startGame();
      }
      return;
    }

    // no moving or attacking once the game is over
    if (isDead || won) {
      curKey = 9;
      return;
    }

    if (key == CODED) {
      if (keyCode == LEFT) {
        curKey = 0;
        lastMoveKey = 0;
      }
      if (keyCode == RIGHT) {
        curKey = 1;
        lastMoveKey = 1;
      }
      if (keyCode == UP) {
        curKey = 2;
        lastMoveKey = 2;
      }
      if (keyCode == DOWN) {
        curKey = 3;
        lastMoveKey = 3;
      }
    } //CODED

    // ATTACK!!!!! (Control, or Space since Control+arrows does other things on a Mac)
    if (keyCode == CONTROL || key == ' ') {
      curKey = 4;
      if (swordToggle == true) {
        sword.play(); //sound
        swordToggle = false;
        hitToggle = 0;
      }
    }

    lastKey = curKey;

    //WEAPON JOSTLE
    if (millis() < wep_jstl_timer + 150) {
      weapon_X_jostle = .5;
      weapon_Y_jostle = .5;
    }
    if (millis() > wep_jstl_timer + 150) {
      weapon_X_jostle = -.5;
      weapon_Y_jostle = -.5;
    }
    if (millis() > wep_jstl_timer + 350) {
      wep_jstl_timer = 150;
    }
  } else { //keypressed
    swordToggle = true; //reset sword sound
  } //keyPressed
} //keyboard

void keyReleased() {

  if (curKey != 9) {
    lastKey = curKey;
  }
  curKey = 9;

  if ((key == 'i' || key == 'I') && level != 0 && !isDead && !won) {
    inventory = !inventory;
  }

  if ((key == 'r' || key == 'R') && (isDead || won)) {
    resetGame();
  }
}
