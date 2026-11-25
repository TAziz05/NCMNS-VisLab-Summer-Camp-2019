MonsterClass slime1 = new MonsterClass( 100, 30, 60, 210, 20); // x, y ,health, loot, sprite frame
MonsterClass slime2 = new MonsterClass( 200, 150, 90, 210, 120);
MonsterClass slime3 = new MonsterClass( 200, 40, 70, 210, 80);

int hitToggle = 0;

class MonsterClass {

  Sprite sprite;
  float x = 100;
  float y = 30;
  float homeX, homeY; // where it spawned; it won't wander far from here
  float leash = 40;
  float moveX;
  float moveY;
  int actionTime;
  boolean tryAgain;
  boolean chase = false;
  int chaseDist = 60;
  float chaseSpeed = 1.5;
  int health = 20;
  int maxHealth = 20;
  int lootPick;
  float lootX, lootY;
  boolean lootTouch = false;
  int attackTimer = 0;
  int hitFlashUntil = 0;
  int spriteFrame;

  MonsterClass(float x_, float y_, int health_, int lootPick_, int spriteFrame_) {
    x = x_;
    y = y_;
    homeX = x_;
    homeY = y_;
    health = health_;
    maxHealth = health_;
    lootPick = lootPick_;
    spriteFrame = spriteFrame_;
  }

  // Would the slime bump into a wall if it stood here?
  boolean blocked(float nx, float ny) {
    return wallAt(nx, ny) || wallAt(nx - 8, ny) || wallAt(nx + 8, ny) || wallAt(nx, ny + 8) || wallAt(nx, ny - 8);
  }

  // Move by (dx, dy) unless a wall or the edge of the window is in the way
  void tryMove(float dx, float dy) {
    float nx = constrain(x + dx, 10, width - 12);
    float ny = constrain(y + dy, 12, height - 40);
    if (!blocked(nx, y)) {
      x = nx;
    } else {
      tryAgain = true;
    }
    if (!blocked(x, ny)) {
      y = ny;
    } else {
      tryAgain = true;
    }
  }

  void update() {
    boolean frozen = isDead || won; // everything stops when the game is over

    if (health > 0) {
      if (!frozen) {
        //should I chase?
        chase = (abs(x - pos_x) < chaseDist && abs(y - pos_y) < chaseDist);

        if (chase) {
          //chase code
          float dx = (x > pos_x) ? -chaseSpeed : chaseSpeed;
          float dy = (y > pos_y - 5) ? -chaseSpeed : chaseSpeed;
          if (abs(x - pos_x) < chaseSpeed) dx = 0;
          if (abs(y - (pos_y - 5)) < chaseSpeed) dy = 0;
          tryMove(dx, dy);
        } else {
          //wander around, and pick a new direction every 3 seconds (or after bumping into something)
          if (actionTime < millis() || tryAgain == true) {
            moveX = random(-0.3, 0.3);
            moveY = random(-0.3, 0.3);
            // wandered too far from home? head back
            if (dist(x, y, homeX, homeY) > leash) {
              moveX = (homeX - x) / dist(x, y, homeX, homeY) * 0.3;
              moveY = (homeY - y) / dist(x, y, homeX, homeY) * 0.3;
            }
            actionTime = millis() + 3000;
            tryAgain = false;
          }
          tryMove(moveX, moveY);
        }
      }

      //attack range?
      if (!frozen && abs(x - pos_x) < 10 && abs(y - pos_y) < 10) {
        // the "angry" row of this slime's color on the sprite sheet
        int angry = spriteFrame - (spriteFrame % 50) + 30;
        sprite.setFrameSequence(angry, angry + 9, 0.1);

        //attack!!!
        if (millis() > attackTimer) {
          playerHealthBar = constrain( playerHealthBar - int(random(3, 10)), 0, playerHealthBar);
          attackTimer = millis() + int(random(100, 500));
          if (millis() > hurtSoundAt) {
            hurtSound.play();
            hurtSoundAt = millis() + 350;
          }
        }
      } else {
        //not attacking
        sprite.setFrameSequence (spriteFrame, spriteFrame + 9, 0.2);
      }

      //show sprites (flash red for a moment after being hit)
      sprite.setXY(x, y);
      sprite.setScale(1);
      if (millis() < hitFlashUntil) {
        tint(255, 90, 90);
      }
      sprite.draw();
      noTint();

      // little health bar over the slime once it's been hit
      if (health < maxHealth) {
        float barW = 24;
        noStroke();
        fill(0, 160);
        rect(x - barW/2 - 1, y - 19, barW + 2, 5);
        fill(120, 255, 120);
        rect(x - barW/2, y - 18, map(health, 0, maxHealth, 0, barW), 3);
      }

      // damage to monster
      if (!frozen && weapon.pp_collision(sprite) && hitToggle == 0 && curKey == 4) {
        health -= damage;
        hitFlashUntil = millis() + 150;
        monsterHit.play();
        hitToggle = 1;
        if (health <= 0) {
          dropLoot();
        }
      }
    } else {
      //monster is dead

      // loot drop
      if (lootTouch == false) {
        loot.setXY(lootX, lootY);
        loot.setFrameSequence(lootPick, lootPick, 0);
        loot.draw();

        //pick up loot, remove from map, add to inventory
        if (!frozen && player.pp_collision(loot)) {
          if (lootPick == 210) {
            diamond = diamond + 1;
          }
          lootTouch = true;
          jewel.play();
        }
      }
    }//dead monster
  } //update

  // Pick a spot for the diamond: next to the slime if there's room, otherwise right where it died
  void dropLoot() {
    lootX = constrain(x + 25, 12, width - 12);
    lootY = constrain(y + 5, 12, height - 40);
    if (wallAt(lootX, lootY)) {
      lootX = x;
      lootY = y;
    }
  }

  void respawn( int health_, int x_, int y_) {
    lootTouch = false;
    health = health_;
    maxHealth = health_;
    x = x_;
    y = y_;
    homeX = x_;
    homeY = y_;
    tryAgain = false;
    actionTime = 0;
    hitFlashUntil = 0;
  }
} //monsterclass


// Is every slime in this room beaten, with its diamond picked up?
boolean roomCleared() {
  return slime1.health < 1 && slime1.lootTouch
    && slime2.health < 1 && slime2.lootTouch
    && slime3.health < 1 && slime3.lootTouch;
}

// Move on to the next room once this one is cleared
void checkProgress() {
  if (isDead || won || !roomCleared()) {
    return;
  }

  if (level == 1) {
    enterRoom(2);
    slime1.respawn(45, 175, 175);
    slime2.respawn(95, 50, 50);
    slime3.respawn(75, 100, 100);
  } else if (level == 2) {
    enterRoom(3);
    slime1.respawn(50, 90, 175);
    slime2.respawn(95, 100, 50);
    slime3.respawn(75, 75, 100);
  } else if (level == 3) {
    enterRoom(4);
    slime1.respawn(55, 130, 175);
    slime2.respawn(95, 50, 100);
    slime3.respawn(75, 100, 75);
  } else if (level == 4) {
    enterRoom(5);
    slime2.respawn(215, 160, 75); // the big one!
  } else if (level == 5) {
    enterRoom(6);
    slime1.respawn(20, 175, 175);
    slime2.respawn(25, 250, 60);
    slime3.respawn(30, 130, 200);
  } else if (level == LAST_ROOM) {
    won = true;
    winSound.play();
  }
}
