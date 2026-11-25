// WALLS
// Each room has a wall map (see "walls" in the main tab).
// A solid pixel in the wall map means you can't walk there.

// Is there a wall at this spot in the current room?
boolean wallAt(float x, float y) {
  if (level < 1 || level > LAST_ROOM) {
    return false;
  }
  PImage w = walls[level];
  int ix = int(x);
  int iy = int(y);
  if (ix < 0 || iy < 0 || ix >= w.width || iy >= w.height) {
    return false; // the edge of the window is handled in player()
  }
  int a = (w.pixels[iy * w.width + ix] >> 24) & 0xFF;
  return a == 255;
}

void objectCollide() {

  // Look all around the player for walls.
  //Look East, starting at 10 pixels over and 20 pixels up,
  //then look at each pixel south of that for 35 pixels
  //might need to adjust these numbers for larger/smaller player sprites

  for (int i = 0; i < 35; i = i + 1) {
    if (wallAt(pos_x + 10, pos_y - 20 + i)) {
      stopE = true;
    }
  }

  for (int i = 0; i < 35; i = i + 1) {
    if (wallAt(pos_x - 15, pos_y - 20 + i)) {
      stopW = true;
    }
  }
  for (int i = 0; i < 15; i = i + 1) {
    if (wallAt(pos_x - 10 + i, pos_y - 25)) {
      stopN = true;
    }
  }

  for (int i = 0; i < 15; i = i + 1) {
    if (wallAt(pos_x - 10 + i, pos_y + 25)) {
      stopS = true;
    }
  }
}
