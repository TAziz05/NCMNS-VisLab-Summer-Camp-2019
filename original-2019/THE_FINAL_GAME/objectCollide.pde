float lookE = 0;
float lookW = 0;
float lookN= 0;
float lookS = 0;

void objectCollide() {

  // INSPECT ALPHA (transparency) VALUSE IN ALL DIRECTIONS
  // Objects you bump into will have an alpha value of 255, all else will be 0

  //Look East, starting at 10 pixels over and 20 pixels up,
  //then look at ech pixel south of that for 35 pixels
  //might need to adjust these nmbers for larger/smaller player sprites

  for (int i = 0; i < 35; i = i + 1) {
    color Z = get(int(pos_x)+10, int(pos_y-20)+i);
    lookE = alpha(Z);
    if (lookE == 255) {
      stopE = true;
    }
  }

  for (int i = 0; i < 35; i = i + 1) {
    color Z = get(int(pos_x)-15, int(pos_y-20)+i);
    lookW = alpha(Z);
    if (lookW == 255) {
      stopW = true;
    }
  }
  for (int i = 0; i < 15; i = i + 1) {
    color Z = get((int(pos_x)-10)+i, int(pos_y-25));
    lookN = alpha(Z);
    if (lookN == 255) {
      stopN = true;
    }
  }

  for (int i = 0; i < 15; i = i + 1) {
    color Z = get((int(pos_x)-10)+i, int(pos_y+25));
    lookS = alpha(Z);
    if (lookS == 255) {
      stopS = true;
    }
  }
}
