float d;
color bg, fg;

void setup(){
  size(800,600);
  
  fg = color(0,10);
  bg = color(255);
  
  //stroke(255, 100); // stroke color, alpha  G, A
  //strokeWeight(4); // stroke weight
  noStroke();
  fill(fg);
  rectMode(CENTER);
  
  background(bg);// single value > greyscale
}

void draw(){
  
  // 3 values > R,G,B
  if(mousePressed && mouseButton == LEFT){
    // boolean operators
    // AND && both terms are true > true
    // OR  ||  at least one is true > true
    // NOT ! inverts the boolean value
    //  other operators
    // EQUALS == 
    // NOT EQUAL != 
    // LARGER THAN, SMALLER THAN  > <, >= ,<=
     //line(0,0, mouseX, mouseY);
     rect(mouseX, mouseY, 200, 100);
  }else{
  
  }
  
  if(mousePressed && mouseButton == RIGHT) background(bg);
  
 
}


// function declaration
float sum(float a, float b){
  float c; // variable declaration
  c = a+b; // should be read like this: c <= a+b
  return c;
}