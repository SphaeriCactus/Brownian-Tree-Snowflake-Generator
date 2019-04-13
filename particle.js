class Particle {
  constructor(x, y) {
    this.pos = createVector(x, y);

    this.r = 3;
    this.finalColour = 0;
    this.fin = false;
  }

  update() {
    this.pos.x --;
    this.pos.y += random(-3, 3);

    let angle = this.pos.heading();
    angle = constrain(angle, 0, PI/6);
    let magnitude = this.pos.mag();

    this.pos = p5.Vector.fromAngle(angle);
    this.pos.setMag(magnitude);
  }

  show() {
    noStroke();
    fill((this.fin ? this.finalColour : colour), 1, 1);
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2);
  }

  finished() {
    if (this.pos.x < 1) {
      this.fin = true;
      this.finalColour = colour;
      return true;
    } else {
      this.fin = false;
      return false;
    }
  }

  intersects(snowflake) {
    let result = false;

    for (let s of snowflake) {
      let d = dist(s.pos.x, s.pos.y, this.pos.x, this.pos.y);
      if (d < this.r * 2) {
        result = true;
        this.fin = true;
        this.finalColour = colour;
        break;
      }
    }

    return result;
  }
}
