float r = 300, ai;
float x, y;
float ang = 0;
int n = 500;
boolean go = false; // trigger

void setup() {
  size(800, 900);
  ellipseMode(CENTER);
  ai = TWO_PI/n;
}

void draw() {
  background(221);
  //  increment variable; loop condition; increment rule
  // i = i+1; > i+= 1; > i++;
  x = width*0.5 + r*cos(ang);
  y = height*0.5 + r*sin(ang);
  ellipse(x, y, 10, 10);
  // halt-hold option
  //if(!mousePressed) ang += ai; // ang = ang+ai;
  
  // trigger option
  if (go) ang += ai;
}

void mousePressed() {
  go = !go; // switch trigger state
}