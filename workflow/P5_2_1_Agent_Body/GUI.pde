void checkOverlap() { //checks if mouse overlaps interface
  if (c5.isMouseOver()) cam.setActive(false);
  else cam.setActive(true);
}

void dispGUI() {
  cam.beginHUD();

  c5.draw();
  //textSize(10);
  //fill(255, 0, 0);
  //text(frameCount, 10, height-10);

  cam.endHUD();
}

void initGui() {
  //color combination for interface
  //                    hover color /  base color  / active color   / label color /  data label
  CColor gray = new CColor(color(180), color(120), color(255), color(255), color(0));  
  float x=10, y = 20;
  int w=210, h=10;
  float dY = h+10;

  c5.setAutoDraw(false);

  // ______________________ sliders



  c5.addSlider("fA") // <<< use the variable name here
    .setLabel("fAl")
    .setPosition(x, y)
    .setWidth(w).setHeight(h)
    .setRange(0.00, 1.00).setValue(fA)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginRight=130;

  /*
   
   y+=dY;
   c5.addSlider("cI")
   .setLabel("Ci")
   .setPosition(x, y)
   .setWidth(w).setHeight(h)
   .setRange(0.01, 0.20).setValue(cI)
   .setColor(gray);
   //.getCaptionLabel().getStyle().marginLeft=-30;
   
   y+=dY;
   
   y+=dY;
   c5.addSlider("aR")
   .setLabel("Ar")
   .setPosition(x, y)
   .setWidth(w).setHeight(h)
   .setRange(10, 50).setValue(aR)
   .setColor(gray);
   //.getCaptionLabel().getStyle().marginLeft=-30;
   
   y+=dY;
   c5.addSlider("aI")
   .setLabel("Ai")
   .setPosition(x, y)
   .setWidth(w).setHeight(h)
   .setRange(0.01, 0.15).setValue(aI)
   .setColor(gray);
   //.getCaptionLabel().getStyle().marginLeft=-30;
   
   y+=dY;
   
   y+=dY;
   c5.addSlider("sR")
   .setLabel("Sr")
   .setPosition(x, y)
   .setWidth(w).setHeight(h)
   .setRange(1, 10).setValue(sR)
   .setColor(gray);
   //.getCaptionLabel().getStyle().marginLeft=-30;
   
   y+=dY;
   c5.addSlider("sI")
   .setLabel("Si")
   .setPosition(x, y)
   .setWidth(w).setHeight(h)
   .setRange(0.1, 3).setValue(sI)
   .setColor(gray);
   //.getCaptionLabel().getStyle().marginLeft=-30;
   */

  // ______________________ toggles & buttons

  y+=dY*2;
  int bW=40;
  int bS = 85;

  c5.addToggle("fieldDisp")
    .setLabel("field")
    .setPosition(x, y)
    .setWidth(bW).setHeight(h)
    .setColor(gray);

  c5.addToggle("debugView")
    .setLabel("debug")
    .setPosition(x+bS, y)
    .setWidth(bW).setHeight(h)
    .setColor(gray);

  c5.addButton("saveImg") // << the button calls the function saveImg
    .setLabel("img")
    .setPosition(x+bS*2, y)
    .setWidth(bW).setHeight(h)
    .setColor(gray)
    .getCaptionLabel().getStyle().marginTop=13;


  y+=dY*2;

  c5.addToggle("go") // << the boolean variable controlled by the toggle
    .setLabel("> - ||")
    .setPosition(x, y)
    .setWidth(bW).setHeight(h)
    .setColor(gray);

  c5.addToggle("lock")
    .setLabel("lock")
    .setPosition(x+bS, y)
    .setWidth(bW).setHeight(h)
    .setColor(gray);

  c5.addButton("exprtBds") // << the button calls the function exprtBds
    .setLabel("Xport")
    .setPosition(x+bS*2, y)
    .setWidth(bW).setHeight(h)
    .setColor(gray)
    .getCaptionLabel().getStyle().marginTop=13;
}

void saveImg(int val) {
  // val (1) is returned each time the button is pressed
  saveFrame("img/flock_####.png");
}

void exprtBds(int val) {
  exportBodies(agents, "_struct_topoXt");
}