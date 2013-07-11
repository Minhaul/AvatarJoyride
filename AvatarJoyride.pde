import ddf.minim.*;
import java.util.List;
import java.util.Random;

Random rgen;

Sprite bg;
Aang aang;
FireBender zuko;
KeyReader reader;

List<FireBender> Zukos;
List<FireBender> toRemoveZ;

List<Projectile> FireBalls;
List<Projectile> AirBalls;
List<Projectile> toRemove;

Boolean gameOver;
Boolean pause;
int health;
int score;

PImage heart;

AudioPlayer player;
Minim minim;

void setup()
{
  smooth();
  
  gameOver = false;
  pause = false;
  health = 10;
  score = 0;
  
  heart = loadImage("heart.png");
  
  rgen = new Random();
  
  Zukos = new ArrayList<FireBender>();
  FireBalls = new ArrayList<Projectile>();
  AirBalls = new ArrayList<Projectile>();
  toRemove = new ArrayList<Projectile>();
  toRemoveZ = new ArrayList<FireBender>();
  
  minim = new Minim(this);
  player = minim.loadFile("music.mp3", 512);
  player.loop();
  
  reader = new KeyReader();
  bg = new Sprite("bg_strip.png", 8, Sprite.CORNER);
  size(bg.width, bg.height);
  bg.angle = 0;
  bg.speed = 0.15;
  
  aang = new Aang(new PVector(width/2, height - 16));
}

//for rendering the background and aang
void draw()
{
  fill(150, 0, 0);
  
  if (pause)
  {
    textSize(40);
    text("Paused", width / 2 - 70, height / 2);
  }
  else
  {
    textSize(15);
    
    bg.render(new PVector(0,0));
      
    int heartxStart = width - 20;
    int hearty = 10;
    for (int i = 0; i < health; i++)
    {
      image(heart, heartxStart - (i * (heart.width + 3)), hearty);
    }
  
    if (gameOver)
      {
        fill(255, 255, 255);
        textSize(50);
        text("GAME OVER", (width / 2) - 140, (height / 2));
        textSize(20);
        text("Score: " + Integer.toString(score), (width / 2) - 50, (height / 2) + 23);
        text("Press C to play again!", (width / 2) - 100, (height / 2) + 45);
        if (reader.check("c"))
        {
          score = 0;
          health = 10;
          toRemove.clear();
          toRemoveZ.clear();
          Zukos.clear();
          FireBalls.clear();
          AirBalls.clear();
          aang.origin = (new PVector(width/2, height - 16));
          gameOver = false;
        }
      }
    else
    { 
      text("Score: " + Integer.toString(score), 10, 20);
      
      aang.update();
  
      if ((rgen.nextInt(500) < 5) && (Zukos.size() < 5))
      {
        PVector spawn = new PVector(rgen.nextInt(2) * (width + 20) - 10, height - 16);
        Zukos.add(new FireBender(spawn, aang));
      }
  
      for (FireBender zuko : Zukos)
      {
        if (rgen.nextInt(500) < 10)
        {
          float aangx = aang.origin.x;
          float aangy = aang.origin.y - (aang.f.height / 2);
          FireBalls.add(new Projectile("fireball.png", 3, zuko.origin.x, zuko.origin.y - (zuko.f.height / 2), aangx - zuko.origin.x, aangy - (zuko.origin.y - zuko.f.height / 2), 5));
        }

        zuko.update();    
      }
  
      // Airballs
      for (Projectile airBall : AirBalls) {
        airBall.render();
        if (!airBall.inBounds()) {
          toRemove.add(airBall);
        }
        for (FireBender zuko : Zukos)
        {
          if (zuko.center().dist(airBall.center()) < zuko.f.height / 2 + airBall.img.height / 2)
          {
            boolean alreadyIn = false;
            for (Projectile other : toRemove)
            {
               if (other == airBall)
               {
                  alreadyIn = true;
                  break;
               } 
            }
            if (!alreadyIn)
            {
               toRemove.add(airBall); 
            }
            toRemoveZ.add(zuko);
            score += 100;
          }
        }
      }
      for (Projectile airball : toRemove) {
        AirBalls.remove(airball);
      }
      toRemove.clear();
      for (FireBender zuko : toRemoveZ)
      {
        Zukos.remove(zuko);
      }
      toRemoveZ.clear();
  
      // Fireballs
      for (Projectile fireBall : FireBalls) {
        fireBall.render();
        if (!fireBall.inBounds()) {
          toRemove.add(fireBall);
        }
        if (aang.center().dist(fireBall.center()) < aang.f.height / 2 + fireBall.img.height / 2)
          {
            boolean alreadyIn = false;
            for (Projectile other : toRemove)
            {
               if (other == fireBall)
               {
                  alreadyIn = true;
                  break;
               } 
            }
            if (!alreadyIn)
            {
               toRemove.add(fireBall); 
            }
            health--;
            if (health == 0)
            {
              gameOver = true;
            }
          }
      }
      for (Projectile fireball : toRemove) {
        FireBalls.remove(fireball);
      }
      toRemove.clear();
    }
  }
}

void keyPressed()
{
  reader.onKeyPressed();
  if (reader.check("p")) pause = !pause;
}

void keyReleased()
{
  reader.onKeyReleased();
}

void mousePressed()
{
  if (!pause)
  {
  AirBalls.add(new Projectile("airball.png", 1, aang.origin.x, aang.origin.y - (aang.f.height / 2), mouseX - aang.origin.x, mouseY - (aang.origin.y - aang.f.height / 2), 10));
  }
}

//to stop the music when the process is closed
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
