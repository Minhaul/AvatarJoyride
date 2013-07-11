class Projectile
{
  float x;
  float y;
  float xInc;
  float yInc;
  Sprite img;

  Projectile(String path, int nframes, float x, float y, float xInc, float yInc, float speed)
  {    
    this.x = x;
    this.y = y;
    this.xInc = speed * xInc / sqrt(xInc*xInc + yInc*yInc);
    this.yInc = speed * yInc / sqrt(xInc*xInc + yInc*yInc);
    img = new Sprite(path, nframes, Sprite.CENTER);
    img.angle = -atan2(xInc, yInc)+HALF_PI;
  }
  
  PVector center()
  {
    return new PVector(x, y);
  }

  void render()
  {
    x += xInc;
    y += yInc;
    //pushMatrix();
    //translate(x, y);
  //  rotate(-atan2(xInc, yInc)+HALF_PI);
    img.render(new PVector(x, y));
//    popMatrix();
  }
  
  boolean inBounds() 
  {
    return (!((x < -10 || x > width + 10) || (y < -10 || y > height - 16 - (img.height / 2))));
  }
}

