void inventory() {

  if (inventory == true && !isDead && !won) {
    drawPanel(230, 130);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(20);
    text("INVENTORY", width/2, height/2 - 38);

    //THINGS IN INVENTORY
    loot.setXY(width/2 - 30, height/2 + 2);
    loot.setFrameSequence(210, 210, 0);
    loot.draw();
    textAlign(LEFT, CENTER);
    textSize(16);
    text("x " + diamond, width/2 - 10, height/2 + 2);

    textAlign(CENTER, CENTER);
    textSize(10);
    fill(110);
    text("Press I to close", width/2, height/2 + 38);
  }
} // inventory
