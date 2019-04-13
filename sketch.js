let current;
let snowflake = [];
let colour;
const maxColour = 360;

function setup() {
  createCanvas(900, 900);
  colorMode(HSB, maxColour, 1, 1);
  current = new Particle(width/2, 0);
  colour = 0;
}

function draw() {
  translate(width/2, height/2);
  rotate(PI/6);
  background(0);

  while (!current.finished() && !current.intersects(snowflake)) {
    current.update();
  }

  snowflake.push(current);
  current = new Particle(width/2, 0);
  colour ++;
  if (colour > maxColour) {
    colour = 0;
  }

  for (let i = 0; i < 6; i ++) {
    rotate(PI/3);

    current.show();
    for (let p of snowflake) {
      p.show();
    }

    push();
    scale(1, -1);
    current.show();
    for (let p of snowflake) {
      p.show();
    }
    pop();
  }
}
