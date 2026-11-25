float x = 50;
float y = 50;

float food_x = 150;
float food_y = 150;

boolean eaten = false;







void setup() {

  size(1000, 500); //window
}

void draw() {
  background(0, 0, 0);

  if (abs(x-food_x) < 15 && abs(y-food_y) < 15) {
    eaten = true;
    println("NOM NOM NOM GOOD JOB NOM NOM NOM"); // PAC MAN Food =)
    food_x = (random(10, width-10));
    food_y = (random(10, height-10));
    eaten = false;
  }

  if (eaten == false) {
    fill(255, 255, 0);
    rect(food_x, food_y, 30, 30); // PAC MAN
  }






  noStroke();
  fill(0, 0, 255); //blue
  ellipse(x, y, 100, 100); // x,y,w,h
  fill(255, 0, 0); // red
  rect(100, 100, 10, 10);
  rect(80, 90, 10, 10);
  rect(120, 110, 10, 10);
  rect(88, 110, 10, 10);
  rect(110, 88, 10, 10);
  fill(200, 200, 0); // yellow
  ellipse(250, 10, 5, 5); // stars
  ellipse(250, 5, 5, 5);
  ellipse(250, 15, 5, 5);
  ellipse(240, 20, 5, 5);
  ellipse(230, 25, 5, 5);
  ellipse(260, 5, 5, 5);
  ellipse(260, 20, 5, 5);
  ellipse(240, 15, 5, 5); //stars
  fill(215, 200, 255); // moon white
  ellipse(130, 50, 50, 50);
  fill(255, 255, 0);// sun yellow
  ellipse(0, 0, 175, 175);
  if (keyPressed) {
    if (key == 'd') {
      x = x + 2;
    } //right
    if (key == 'w') {
      y = y - 2;
    } //up
    if (key == 'a') {
      x = x - 2;
    } //left
    if (key == 's') {
      y = y + 2;
    } //down
  } //keypressed
} // draw
