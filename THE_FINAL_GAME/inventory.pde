void inventory() {

  if (inventory == true) {
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
    text("INVENTORY", 100, 140);

    //THINS IN INVENTORY
    if (diamond > 0) {
      loot.setXY(100, 190);
      loot.setFrameSequence(210, 210, 0);
      loot.draw();
      textSize(10);
      text(diamond, 105, 205);
    }
  }
} // inventory
