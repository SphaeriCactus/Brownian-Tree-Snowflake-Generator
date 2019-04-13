Particle current;
ArrayList<Particle> snowflake;
float colour;
float maxColour;

void setup() {
  //size(600, 600);
  fullScreen();
  maxColour = 360;
  colorMode(HSB, maxColour, 1, 1);
  current = new Particle(width/2, 0);
  snowflake = new ArrayList<Particle>();
  colour = 0;
}

void draw() {
  translate(width/2, height/2);
  rotate(PI/6);
  background(0);
  
  while (!current.finished() && !current.intersects(snowflake)) {
    current.update();
  }
  
  snowflake.add(current);
  current = new Particle(width/2, 0);
  colour ++;
  if (colour > maxColour) {
    colour = 0;
  }
  
  for (int i = 0; i < 6; i ++) {
    rotate(PI/3);
  
    current.show();
    for (Particle p : snowflake) {
      p.show();
    }
    
    pushMatrix();
    scale(1, -1);
    current.show();
    for (Particle p : snowflake) {
      p.show();
    }
    popMatrix();
  }
}

class Particle {
  PVector pos;
  float r;
  boolean fin;
  float finalColour;
  
  Particle(float x, float y) {
    pos = new PVector(x, y);
    
    r = 3;
    finalColour = 0;
    fin = false;
  }
  
  void update() {
    pos.x --;
    pos.y += random(-3, 3);
    
    float angle = pos.heading();
    angle = constrain(angle, 0, PI/6);
    float magnitude = pos.mag();
    
    pos = PVector.fromAngle(angle);
    pos.setMag(magnitude);
  }
  
  void show() {
    noStroke();
    fill((fin ? finalColour : colour), 1, 1);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
  
  boolean finished() {
    if (pos.x < 1) {
      fin = true;
      finalColour = colour;
      return true;
    } else {
      fin = false;
      return false;
    }
  }
  
  boolean intersects(ArrayList<Particle> snowflake) {
    boolean result = false;
    
    for (Particle s : snowflake) {
      float d = dist(s.pos.x, s.pos.y, pos.x, pos.y);
      if (d < r * 2) {
        result = true;
        fin = true;
        finalColour = colour;
        break;
      }
    }
    
    return result;
  }
}