MonsterClass slime1 = new MonsterClass( 100, 30, 60, 210, 20); // x, y ,health, loot, sprite frame
MonsterClass slime2 = new MonsterClass( 200, 150, 90, 210, 120);
MonsterClass slime3 = new MonsterClass( 200, 40, 70, 210, 80);

int hitToggle = 0;

boolean jewelToggle = true;

class MonsterClass {

  Sprite sprite;
  float x = 100;
  float y = 30;
  float moveX;
  float moveY;
  int actionTime;
  boolean tryAgain;
  boolean chase = false;
  int chaseDist = 30;
  float chaseSpeed = 2;
  int health = 20;
  int lootPick;
  boolean lootTouch = false;
  int attackTimer = 0;
  int alpha = 255;
  int spriteFrame;

  MonsterClass(float x_, float y_, int health_, int lootPick_, int spriteFrame_) {
    x = x_;
    y = y_;
    health = health_;
    lootPick = lootPick_;
    spriteFrame = spriteFrame_;
  }

  void update() {
    if (health > 0) {
      //should I chase?

      chase = (abs(x - pos_x) < chaseDist && abs(y - pos_y) < chaseDist) ? true : false;

      //chase code
      if (chase) {
        x = (x > pos_x) ? x - chaseSpeed : x + chaseSpeed;
        y =(y > pos_y - 5) ? y - chaseSpeed : y + chaseSpeed;

        // monster health bar
        stroke(255);
        text("Monster", 110, health - 8);
        noFill();
        rect(160, height - 18, 50, 10);
        noStroke();
        fill(255);
        rect(160, height - 18, health, 10);
      }

      //bump into object


      //obstacle, do not move
      if (actionTime < millis() || tryAgain == true) {
        moveX = random(-0.1, 0.3);
        moveY = random(-0.1, 0.3);
        actionTime = millis() + 3000;
      } else {
        //no obstacle, move
        x = constrain( x + moveX, 10, width - 30);
        y = constrain( Y + moveY, 10, height - 20);
      }


      //attack range?
      if (abs(x - pos_x) < 10 && abs(y - pos_y) < 10) {
        sprite.setFrameSequence(spriteFrame + 50, spriteFrame + 19, 0.2);

        //attack!!!
        if (millis() > attackTimer) {
          playerHealthBar = constrain( playerHealthBar - int(random(3, 10)), 0, playerHealthBar);


          attackTimer = millis() + int(random(100, 500));
        }
      } else {
        //not attacking
        sprite.setFrameSequence (spriteFrame, spriteFrame + 9, 0.2);
      }

      //show sprites
      sprite.setXY(x, y);
      tint(255, alpha);
      sprite.setScale(1);


      if (level != 0 ) {
        sprite.draw();
      }


      noTint();
    } else {
      //monster is dead

      // loot drop
      if (lootTouch == false) {
        loot.setXY(x + 25, y + 5);
        loot.setFrameSequence(lootPick, lootPick, 0);
        loot.draw();
      }
      //pick up loot, remove from map, add to inventory
      if (player.pp_collision(loot) && lootTouch == false) {

        if (lootPick == 210) {
          diamond = diamond + 1;
          lootTouch = true;
          lootTouch = true;
          jewel.play();
        }
        if (jewelToggle == true) {
          jewel.play();
          jewelToggle = false;
        }
      } else {
        jewelToggle = true; //allow sound to play;
      }
    }//dead monster

    // damage to monster
    if (weapon.pp_collision(sprite) && hitToggle == 0 && curKey == 4) {
      alpha = 126; 
      health -= damage;
      monsterHit.play();
      alpha = 255;
      hitToggle = 1;
    }

    if (slime1.health < 1 && slime2.health < 1 && diamond == 2 && level == 1) {
      level = 2;
      slime1.respawn(45, 175, 175);
      slime2.respawn(95, 50, 50);
      slime3.respawn(75, 100, 100);
    }
    if (slime1.health < 1 && slime2.health < 1 && slime3.health < 1 && diamond == 5 && level == 2) {
      level = 3;
      slime1.respawn(50, 90, 175);
      slime2.respawn(95, 100, 50);
      slime3.respawn(75, 75, 100);
    }
    if (slime1.health < 1 && slime2.health < 1 && slime3.health < 1 && diamond == 8 && level == 3) {
      level = 4;
      slime1.respawn(55, 100, 175);
      slime2.respawn(95, 50, 100);
      slime3.respawn(75, 100, 75);
    }
    if (slime1.health < 1 && slime2.health < 1 && slime3.health < 1 && diamond == 11 && level == 4) {
      level = 5;

      slime2.respawn(215, 75, 75);
    }
    if (slime1.health < 1 && slime2.health < 1 && slime3.health < 1 && diamond == 12 && level == 5) {
      level = 6;
      slime1.respawn(20, 175, 175);
      slime2.respawn(25, 50, 50);
      slime3.respawn(30, 100, 100);
    }

    //winning
    if (slime1.health < 1 && slime2.health < 1 && slime3.health < 1 && level == 6) {
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
      text("    YOU HAVE WON", 20, height/2);
    }
  } //update

  void respawn( int health_, int x_, int y_) {
    lootTouch = false;
    health = health_;
    x = x_;
    y = y_;
  }
} //monsterclass
