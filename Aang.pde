class Aang
{
  public PVector origin;
  public PVector speed;
  Sprite f;
  Sprite l;
  Sprite r;
  
  Aang(PVector origin)
  {
    this.origin = origin;
    f = new Sprite("aang_front.png", 3, Sprite.BASE);
    l = new Sprite("aang_left.png", 3, Sprite.BASE);
    r = new Sprite("aang_right.png", 3, Sprite.BASE);
    speed = new PVector(0, 0);
    
    f.angle = 0;
    l.angle = 0;
    r.angle = 0;
  }
  
  PVector center()
  {
    return new PVector(origin.x, origin.y - (f.height / 2));
  }
  
  void update()
  {
    float runSpeed = reader.check("shift")? 1.5: 1;
    if (reader.check("d"))
      speed.x = runSpeed * 2;
    else if (reader.check("a"))
      speed.x = runSpeed * -2;
    else
      speed.x = 0;
    
    if (origin.y > height - 16)
    {
      origin.y = height - 16;
      speed.y = 0;
    }
    else if (origin.y < height - 16)
      speed.y +=0.4;
    
    if (reader.check("space"))
      speed.y -= 0.7;
    
    if (speed.x > 0)
    {
      f.speed = 0;
      l.speed = 0;
      
      r.render(origin);
      r.speed = 0.15;
    }
    else if (speed.x < 0)
    {
      f.speed = 0;
      r.speed = 0;
      
      l.render(origin);
      l.speed = 0.15;
    }
    else if (speed.x == 0)
    {
      f.speed = 0;
      l.speed = 0;
      r.speed = 0;
      
      f.render(new PVector(origin.x, origin.y + 2));
      f.frame = 1;
      
    }
    origin.add(speed);
  }
  
}
