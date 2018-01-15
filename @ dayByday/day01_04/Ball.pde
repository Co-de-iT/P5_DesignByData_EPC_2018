class Ball {
  // fields
  PVector pos, vel;
  float r;
  color col;
  int lifeSpan;
  float age = 1, aging;
  

  Ball (PVector _pos, PVector _vel, float _rad, color _col) {
    pos = _pos;
    vel = _vel;
    r = _rad;
    col = _col;
    lifeSpan = 300;
    aging = 1.0/lifeSpan;
  }
  
  void update(){
    if (age > 0){
    //moveRand();
    moveRot();
    age -= aging; // age = age-aging;
    }
  }

  void move() {
    pos.add(vel);
  }
  
  void moveRand(){
    vel = PVector.random2D(); // static 
    vel.mult(1.5);
    vel.limit(3);
    pos.add(vel);
  }
  
  void moveRot(){
    vel.rotate(random(-PI*0.5, PI*0.5));
    vel.limit(5*pow(age,2));
    pos.add(vel);
  }

  void display() {
    fill(col);
    //noStroke();
    stroke(0,20);
    float d = map(age,0,1,5, r*2);
    ellipse(pos.x, pos.y, d, d);
  }
}