Sprite bottle_pink;
boolean item2_1 = true; // true = item not picked up (item1_1 = level 1, item 1)
boolean item4_1 = true;
boolean item4_2 = true;
boolean item3_1 = true;
boolean item5_1 = true;
boolean item5_2 = true;
boolean drinkToggle = true;
boolean inventory = false; //display the inventory?
int diamond = 0;

void items() {
  //items no yet picked up
  if (item2_1 == true && level == 2) { //true = appear on map
    bottle_pink.setXY (50, 100);
    bottle_pink.setFrameSequence(32, 32, 0);
    bottle_pink.draw();
  }
  if (item4_1 == true && level == 4) { //true = appear on map
    bottle_pink.setXY (50, 100);
    bottle_pink.setFrameSequence(32, 32, 0);
    bottle_pink.draw();
  }
  if (item4_2 == true && level == 4) { //true = appear on map
    bottle_pink.setXY (100, 50);
    bottle_pink.setFrameSequence(32, 32, 0);
    bottle_pink.draw();
  }

  //the moment bottle is picked up
  //items no yet picked up
  if (item3_1 == true && level == 3) { //true = appear on map
    pokeball.setXY (50, 100);
    pokeball.setFrameSequence(32, 32, 0);
    pokeball.draw();
  }

  if (item5_1 == true && level == 5) { //true = appear on map
    pokeball.setXY (50, 100);
    pokeball.setFrameSequence(32, 32, 0);
    pokeball.draw();
  }
  if (item5_2 == true && level == 5) { //true = appear on map
    pokeball.setXY (100, 50);
    pokeball.setFrameSequence(32, 32, 0);
    pokeball.draw();
  }

    if (player.pp_collision(bottle_pink) && level == 2 && item2_1 == true) {
    drinkToggle = true;
    drink();
    item2_1 = false; //bottle will go away
    int addedHealth = 10;
    playerHealthBar = constrain(playerHealthBar + addedHealth, 0, playerHealthBarOriginal);
  }
  
    if (player.pp_collision(bottle_pink) && level == 4 && item4_1 == true) {
    drinkToggle = true;
    drink();
    item4_1 = false; //bottle will go away
    int addedHealth = 10;
    playerHealthBar = constrain(playerHealthBar + addedHealth, 0, playerHealthBarOriginal);
  }
  
   if (player.pp_collision(bottle_pink) && level == 4 && item4_2 == true) {
    drinkToggle = true;
    drink();
    item4_2 = false; //bottle will go away
    int addedHealth = 10;
    playerHealthBar = constrain(playerHealthBar + addedHealth, 0, playerHealthBarOriginal);
  }
  
  
  
  
  if (player.pp_collision(pokeball) && level == 3 && item3_1 == true) {
    drinkToggle = true;
    drink();
    item3_1 = false; //bottle will go away
    int addedHealth = 20;
    playerHealthBar = constrain(playerHealthBar + addedHealth, 0, playerHealthBarOriginal);
  }
  if (player.pp_collision(pokeball) && level == 5 && item5_1 == true) {
    drinkToggle = true;
    drink();
    item5_1 = false; //bottle will go away
    int addedHealth = 20;
    playerHealthBar = constrain(playerHealthBar + addedHealth, 0, playerHealthBarOriginal);
  }
  if (player.pp_collision(pokeball) && level == 5 && item5_2 == true) {
    drinkToggle = true;
    drink();
    item5_2 = false; //bottle will go away
    int addedHealth = 20;
    playerHealthBar = constrain(playerHealthBar + addedHealth, 0, playerHealthBarOriginal);
  }
}//items
void drink() {

  if (drinkToggle == true) {
    drink.play();
    drinkToggle = false;
  }
}
