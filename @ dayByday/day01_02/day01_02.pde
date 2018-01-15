float r = 300,a;
float x,y;
float fx, fy;
int n = 500;

void setup() {
  size(800, 900);
  ellipseMode(CENTER);
}

void draw() {
  background(221);
  //  increment variable; loop condition; increment rule
  // i = i+1; > i+= 1; > i++;
  a = TWO_PI/n;
  fx = map(mouseX,0, width,1,3);
  fy = map(mouseY,0,height, 1,3);
  for(int i=0; i<n;i++){
    x = width*0.5 + r*cos(a*i*fx);
    y = height*0.5 + r*sin(a*i*fy);
    ellipse(x,y,10,10);
  }
  //ellipse(width*0.5, height*0.5, 10,10);
}