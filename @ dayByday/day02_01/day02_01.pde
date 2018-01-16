
import toxi.geom.*;

Agent a;
int nAgents = 1000;
ArrayList <Agent> agents;

Vec3D target;

void setup() {
  size(900, 900, P3D);
  //fullScreen(P3D, 2); // fullScreen(P3D);

  agents = new ArrayList<Agent>();

  for (int i=0; i<nAgents; i++) {
    a = new Agent(new Vec3D(random(width), random(height), 0), 
      new Vec3D(random(-3, 3), random(-3, 3), 0));

    agents.add(a);
  }
  
  target = new Vec3D(width*0.5, height*0.5,0);
  background(0);
}


void draw() {
  //background(0);
  
  target = new Vec3D(mouseX, mouseY,0);

  for (int i=0; i<nAgents; i++) {
    a = agents.get(i);
    if (mousePressed) a.seek(target);
    a.separate(agents);
    a.update();
    a.display();
  }
  
  noStroke();
  fill(0,20);
  rect(0,0,width,height);
}