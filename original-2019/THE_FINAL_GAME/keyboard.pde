int curKey = 9; // current Key
int lastKey = 3;

void keyboard() {

  if (keyPressed) {


    if (key == 'y') { //start
      level = 1;
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

    if (keyCode == CONTROL) { // ATTACK!!!!!
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

  lastKey = curKey;
  curKey = 9;

  if (key == 'i') {
    inventory = !inventory;
  }
}
