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
  if (vidRec) {
    pushStyle();
    noStroke();
    fill(255, 0, 0);
    rect(c5x, c5y, 10, 10);
    popStyle();
  }
  if (dispMsg) {
    if (dispMsgStart) {
      tStart = millis();
      dispMsgStart = false;
    }
    if (millis() < tStart+time) {
      text(msg, c5x, height-20);
    } else {
      dispMsg=false;
    }
  }
  cam.endHUD();
}


void initGui() {
  //color combination for interface
  //                    hover color /  base color  / active color   / label color /  data label
  CColor gray = new CColor(color(180), color(120), color(255), color(255), color(0));  

  c5.setAutoDraw(false);

  // ______________________ sliders

  c5.addSlider("fA") // <<< use the variable name here
    .setLabel("fAl")
    .setPosition(c5x, c5y)
    .setWidth(c5w).setHeight(c5h)
    .setRange(0.00, 1.00).setValue(fA)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginRight=130;


  c5y+=c5dY;
  c5.addSlider("cR")
    .setLabel("Cr")
    .setPosition(c5x, c5y)
    .setWidth(c5w).setHeight(c5h)
    .setRange(20, 200).setValue(cR)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginLeft=-30;


  c5y+=c5dY;
  c5.addSlider("cI")
    .setLabel("Ci")
    .setPosition(c5x, c5y)
    .setWidth(c5w).setHeight(c5h)
    .setRange(0.01, 3).setValue(cI)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginLeft=-30;

  c5y+=c5dY;
  c5.addSlider("aR")
    .setLabel("Ar")
    .setPosition(c5x, c5y)
    .setWidth(c5w).setHeight(c5h)
    .setRange(10, 200).setValue(aR)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginLeft=-30;

  c5y+=c5dY;
  c5.addSlider("aI")
    .setLabel("Ai")
    .setPosition(c5x, c5y)
    .setWidth(c5w).setHeight(c5h)
    .setRange(0.01, 2).setValue(aI)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginLeft=-30;

  c5y+=c5dY;
  c5.addSlider("sR")
    .setLabel("Sr")
    .setPosition(c5x, c5y)
    .setWidth(c5w).setHeight(c5h)
    .setRange(1, 50).setValue(sR)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginLeft=-30;

  c5y+=c5dY;
  c5.addSlider("sI")
    .setLabel("Si")
    .setPosition(c5x, c5y)
    .setWidth(c5w).setHeight(c5h)
    .setRange(0.1, 10).setValue(sI)
    .setColor(gray);
  //.getCaptionLabel().getStyle().marginLeft=-30;


  // ______________________ toggles & buttons
  // field + debug
  // play + lock
  // image + video
  // export + connectOnly

  c5y+=c5dY*2;


  c5.addToggle("fieldDisp")
    .setLabel("field")
    .setPosition(c5x, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray);

  c5.addToggle("debugView")
    .setLabel("debug")
    .setPosition(c5x+c5bS, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray);

  c5y+=c5dY*2;

  c5.addButton("saveImg") // << the button calls the function saveImg
    .setLabel("img")
    .setPosition(c5x, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray)
    .getCaptionLabel().getStyle().marginTop=13;

  c5.addToggle("vidRec")
    .setLabel("video_rec")
    .setPosition(c5x+c5bS, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray);

  c5y+=c5dY*2;

  c5.addButton("exprtBds") // << the button calls the function exprtBds
    .setLabel("Xport")
    .setPosition(c5x, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray)
    .getCaptionLabel().getStyle().marginTop=13;

  c5.addToggle("connectedOnly")
    .setLabel("conn_Only")
    .setPosition(c5x+c5bS, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray);

  c5y+=c5dY*2;

  c5.addToggle("go") // << the boolean variable controlled by the toggle
    .setLabel("> . ||")
    .setPosition(c5x, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray);

  c5.addToggle("lock")
    .setLabel("lock")
    .setPosition(c5x+c5bS, c5y)
    .setWidth(c5bW).setHeight(c5h)
    .setColor(gray);

  c5y+=c5dY*2;
}

void saveImg(int val) {
  // val (1) is returned each time the button is pressed
  saveImg = true;
  dispMsg= true;
  dispMsgStart = true;
  msg = ">>>  image saved";
}

void exprtBds(int val) {
  if (lock) { 
    exportBodies(agents, exportFile, connectedOnly);
    dispMsg= true;
    dispMsgStart = true;
    msg = ">>>  export_data/"+timeStamp+ exportFile +".txt"+ " file saved";
  } else {
    dispMsg= true;
    dispMsgStart = true;
    msg = "!!!  bodies must be locked before exporting";
  }
}