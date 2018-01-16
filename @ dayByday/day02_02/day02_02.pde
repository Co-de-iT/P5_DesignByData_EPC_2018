
import toxi.geom.*;

Agent a;
int nAgents = 1000;
ArrayList <Agent> agents;
boolean record = false;

Vec3D target;

void setup() {
  size(900, 900, P3D);
  //fullScreen(P3D, 2); // fullScreen(P3D);
  smooth(8);

  agents = new ArrayList<Agent>();

  for (int i=0; i<nAgents; i++) {
    a = new Agent(new Vec3D(random(width), random(height), 0), 
      new Vec3D(random(-3, 3), random(-3, 3), 0));

    agents.add(a);
  }

  target = new Vec3D(width*0.5, height*0.5, 0);
  background(200,0,0);
  
}


void draw() {
  //background(0);

  target = new Vec3D(mouseX, mouseY, 0);

  for (int i=0; i<nAgents; i++) {
    a = agents.get(i);
    if (mousePressed) a.seek(target);
    a.flock(agents);
    a.update();
    //a.display();
    a.displayTri(3);
  }

  //noStroke();
  //fill(3);
  //blendMode(SUBTRACT);
  //rect(0, 0, width, height);
  //blendMode(BLEND);

  if (record) {
    saveFrame("video2/frame_####.jpg");
    //println("recording....");
    surface.setTitle("recording frame: "+frameCount);
  } else {
    surface.setTitle(nf(frameRate,2,2));
  }
}

void keyPressed() {
  if (key == 'i') saveFrame("imgs/flock_####.png");
  if (key=='r') record = !record;
}