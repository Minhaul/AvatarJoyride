class Sprite
{
  private PImage sprite_strip, current_frame;
  private int nframes, _height, _width;
  private PVector origin;
  
  public float frame, speed, angle, xscale, yscale;
  public static final int BASE = 0, CORNER = 1, CENTER = 2, RIGHT = 3, TOP = 4, LEFT = 5;
  public int height, width;
  
  public Sprite(String filename, int nframes, PVector origin)
  {
    this.nframes = nframes;
    this.origin = origin;
    xscale = yscale = 1;
    frame = 0;
    speed = 0.25;
    angle = 0;
    sprite_strip = loadImage(filename);
    _height = this.height = sprite_strip.height;
    _width = this.width = sprite_strip.width/nframes;
    current_frame = sprite_strip.get(0, 0, _width, _height);
  }
  
  public Sprite(String filename, int nframes, int originMode)
  {
    this(filename, nframes, new PVector(0, 0));
    if (originMode == BASE) {
      origin.x = _width/2;
      origin.y = _height;
    } else if (originMode == CENTER) {
      origin.x = _width/2;
      origin.y = _height/2;
    } else if (originMode == LEFT) {
      origin.x = 0;
      origin.y = _height/2;
    } else if (originMode == RIGHT) {
      origin.x = _width;
      origin.y = _height/2;
    } else if (originMode == TOP) {
      origin.x = _width/2;
      origin.y = 0;
    }
  }
  
  public Sprite(String filename, int nframes)
  {
    this(filename, nframes, new PVector(0, 0));
  }
  
  public void render(PVector origin)
  {
    update();
    pushMatrix();
    translate(origin.x, origin.y);
    rotate(angle);
    scale(xscale, yscale);
    image(current_frame, -this.origin.x, -this.origin.y);
    popMatrix();
  }
  
  private void update()
  {
    frame += speed;
    while (frame > nframes)
      frame -= nframes;
    current_frame = sprite_strip.get((round(frame) % nframes) * _width, 0, _width, _height);
    this.width = int(_width * xscale);
    this.height = int(_height * yscale);
  }
}
