Sprite bottle_pink;
boolean drinkToggle = true;
boolean inventory = false; //display the inventory?
int diamond = 0;

// One thing lying on the floor that you can pick up to heal
class Item {
  int room;
  float x, y;
  boolean isPokeball; // false = pink potion
  int heal;
  boolean taken = false;

  Item(int room_, float x_, float y_, boolean isPokeball_) {
    room = room_;
    x = x_;
    y = y_;
    isPokeball = isPokeball_;
    heal = isPokeball ? 20 : 10;
  }
}

// room, x, y, Poke Ball?
Item[] floorItems = {
  new Item(2, 50, 100, false),
  new Item(3, 50, 100, true),
  new Item(4, 50, 100, false),
  new Item(4, 100, 50, false),
  new Item(5, 120, 140, true),
  new Item(5, 100, 50, true)
};

void resetItems() {
  for (Item it : floorItems) {
    it.taken = false;
  }
}

void items() {
  for (Item it : floorItems) {
    if (it.taken || it.room != level) {
      continue;
    }

    // draw it on the floor
    if (it.isPokeball) {
      pokeball.setXY(it.x, it.y);
      pokeball.setFrameSequence(0, 0, 0);
      pokeball.setScale(0.5); // the ball I drew in 2019, shrunk down to item size
      pokeball.draw();
      pokeball.setScale(1);
    } else {
      bottle_pink.setXY(it.x, it.y);
      bottle_pink.setFrameSequence(32, 32, 0);
      bottle_pink.draw();
    }

    // walk over it to pick it up (only while you're alive!)
    if (!isDead && !won && dist(pos_x, pos_y, it.x, it.y) < 18) {
      it.taken = true; //item will go away
      drinkToggle = true;
      drink();
      playerHealthBar = constrain(playerHealthBar + it.heal, 0, playerHealthBarOriginal);
    }
  }
}//items

void drink() {

  if (drinkToggle == true) {
    drink.play();
    drinkToggle = false;
  }
}
