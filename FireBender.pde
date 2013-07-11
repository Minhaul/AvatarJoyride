class FireBender
{
  public PVector origin;
  public PVector speed;
  Sprite f;
  Sprite b;
  Sprite l;
  Sprite r;
  
  Aang aang;
  
  FireBender(PVector origin, Aang aang)
  {
    this.aang = aang;
    this.origin = origin;
    f = new Sprite("zuko_front.png", 3, Sprite.BASE);
    l = new Sprite("zuko_left.png", 3, Sprite.BASE);
    r = new Sprite("zuko_right.png", 3, Sprite.BASE);
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
    if (aang.origin.x < origin.x - 30) speed.x = -1;
    else if (aang.origin.x > origin.x + 30) speed.x = 1;
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
