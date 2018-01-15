Ball b; // variable declaration
ArrayList <Ball> balls; // declaring a flagged ArrayList
int nBalls = 500;

float rad = 250;
PVector pos, vel;
color col;

void setup() {
  size(800, 900);
  smooth(8);
  ellipseMode(CENTER);

  balls = new ArrayList<Ball>(); // instatiation (calls the constructor)

  for (int i=0; i< nBalls; i++) {
    // variable instantiation
    pos = PVector.random2D();
    pos.mult(random(rad));
    pos.add(new PVector(width*0.5, height*0.5));

    col = lerpColor(color(255, 0, 0), color(255), i/(float)(nBalls-1));// 5 > 5.0

    b = new Ball(pos, PVector.random2D().mult(1.5), random(2, 30), col);

    balls.add(b);
  }

  background(221);
}

void draw() {
  // for each Ball ba contained in balls
  for (Ball ba : balls) {
    ba.update();
    ba.display();
  }
}

void keyPressed() {
  if (key==' ') saveFrame("jitterball_####.png");
}