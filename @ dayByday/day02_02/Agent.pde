class Agent {

  // fields

  Vec3D pos, vel, acc; 
  float maxVel, maxForce;
  float sR, sI; // separation radius and intensity
  float cR, cI; // cohesion radius and intensity
  float aR, aI; // alignment radius and intensity

  // constructor

  Agent(Vec3D _pos, Vec3D _vel) {
    pos = _pos;
    vel = _vel;
    acc = new Vec3D();
    maxVel = 1.5;
    maxForce = 0.01;
    sR = 15;
    sI = 10;
    cR = 200;
    cI = 5;
    aR = 40;
    aI = 5;
  }

  // behaviors (methods)

  void flock(ArrayList<Agent> agents) {
    cohesion(agents);
    alignment(agents);
    separate(agents);
  }

  void update() {
    move();
    bounce();
  }

  void seek(Vec3D t) {
    // calculate desired
    Vec3D des = t.sub(pos);
    // set it to maxVel
    des.normalizeTo(maxVel);
    // calculate steer
    Vec3D steer = des.sub(vel);
    // set to the maxForce
    steer.normalizeTo(maxForce);
    // add it ot acc
    acc.addSelf(steer);
  }

  void cohesion(ArrayList<Agent> agents) {
    int count=0;
    Vec3D t = new Vec3D();
    float dist;

    for (Agent other : agents) {
      if (other != this) {
        dist = pos.distanceTo(other.pos); // calculate the distance with the other agent

        if (dist < cR) {
          count++;
          t.addSelf(other.pos);
        }
      }
    } // end for (Agent other : agents)

    if (count > 0) {
      t.scaleSelf(1.0/count); // average position of other agents
      Vec3D des = t.sub(pos);
      des.normalizeTo(maxVel);
      Vec3D steer = des.sub(vel);
      steer.normalizeTo(maxForce*cI);
      acc.addSelf(steer);
    }
  }


  void alignment(ArrayList<Agent> agents) {
    int count=0;
    Vec3D des = new Vec3D();
    float dist;

    for (Agent other : agents) {
      if (other != this) {
        dist = pos.distanceTo(other.pos); // calculate the distance with the other agent

        if (dist < aR) {
          count++;
          des.addSelf(other.vel);
        }
      }
    } // end for (Agent other : agents)

    if (count > 0) {
      des.scaleSelf(1.0/count); // average position of other agents
      des.normalizeTo(maxVel);
      Vec3D steer = des.sub(vel);
      steer.normalizeTo(maxForce*aI);
      acc.addSelf(steer);
    }
  }

  void separate(ArrayList<Agent> agents) {
    int count=0;
    Vec3D t = new Vec3D();
    float dist;

    for (Agent other : agents) {
      if (other != this) {
        dist = pos.distanceTo(other.pos); // calculate the distance with the other agent

        if (dist < sR) {
          count++;
          t.addSelf(other.pos);
        }
      }
    } // end for (Agent other : agents)

    if (count > 0) {
      t.scaleSelf(1.0/count); // average position of other agents
      Vec3D des = t.sub(pos);
      des.normalizeTo(maxVel);
      Vec3D steer = des.sub(vel);
      steer.normalizeTo(-maxForce*sI);
      acc.addSelf(steer);
    }
  }

  void move() {
    vel.addSelf(acc);
    vel.limit(maxVel);
    pos.addSelf(vel);
    acc = new Vec3D();
  }

  void bounce() {
    if (pos.x > width || pos.x < 0) vel.x *=-1; // +=  -=  *=  /=
    if (pos.y > height || pos.y < 0) vel.y *= -1;
  }

  void display() {
    float vM = vel.magnitude()/maxVel;
    //stroke(255);
    stroke(lerpColor(color(255, 0, 0), color(255), vM));
    strokeWeight(2);
    point(pos.x, pos.y, pos.z);
  }

  void displayTri(float r) {

    pushMatrix(); // enables temporary coordinates system
    translate(pos.x, pos.y);
    float theta = atan2(vel.y, vel.x) + PI*0.5;
    rotate(theta);
    stroke(0,80);
    fill(255);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix(); // reverts to the previous CS
  }
}