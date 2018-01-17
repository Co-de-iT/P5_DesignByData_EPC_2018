/* //<>//

 Encoded Bodies/Embodied Codes
 
 Processing workshop @ Design By Data ws - EPC Paris
 
 Workflow /////////////////////// Agent Bodies on volumetric arrangement
 
 Code by Alessio Erioli
 
 (c) Co-de-iT 2018
 
 includes:
 
 . AgentBody, Body, Tip, TensorPt classes
 
 /////////// DESIGN PARAMETERS ///////////
 
 _ imported
 . field
 . agents start position + velocity
 
 _ in here
 . body type
 . body: forward direction, tips number and position, tips search radius
 . agent body behavior
 . connection behavior
 . export filename
 
 /////////////////////// NOTE ON *BODY TYPE* SELECTION /////////////////////// 
 
 body type is inherited from the agents.txt file and it is set in Grasshopper, in the 01_field generation.gh file
 (see the export agent section in the GH file - the last expression component before the export has a "type" panel attached)
 
 key map:
 
 ' '   (space bar) go/pause
 f     display field
 d     debug view (planes, tripod, directions, etc)
 
 l     lock bodies (phase 2)
 e     export bodies to file
 
 i     save screenshot image
 v     video recording on/off
 
 */

import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import peasy.*;
import controlP5.*;
import java.util.*;



void setup() {

  size(1200, 900, P3D);
  //fullScreen(P3D); // uncheck this and check size() to see the sketch fullscreen
  smooth(8);

  cam = new PeasyCam(this, 500);
  gfx = new ToxiclibsSupport(this);

  agents = importAgents("agents.txt");

  // spheric random generation
  //agents = new AgentBody[nAgents];
  //for (int i=0; i<nAgents; i++) {
  //  agents[i] = new AgentBody(Vec3D.randomVector().scale(random(rad*0.2, rad)), Vec3D.randomVector(), 0, false);
  //}

  field = importField("field.txt");
  fieldOct = octreeFromField(field);

  c5 = new ControlP5(this);
  initGui();
}



void draw() {
  background(60);
  checkOverlap();

  if (go) { // run and display
    for (AgentBody a : agents) {

      if (lock) a.locked = true; // locks agents 
      a.update(agents, 80, 10);
      a.alignWithField(field, fA);
      a.displayBody();
    }
  } else { // just display
    for (AgentBody a : agents) {

      a.displayBody();
    }
  }


  // display field
  if (fieldDisp) {
    for (TensorPt t : field) {
      t.display(color(255), 5, color(255, 0, 0), 20);
    }
  }

  if (debugView) {
    for (AgentBody a : agents) {
      // uncheck one or more for debug purposes
      //a.displayPos();
      a.displayPlane(20);
      a.displayAxis(10);
      //a.displayVel(10);
    }
    strokeWeight(1);
    gfx.origin(10); // axis tripod
  }

  if (viewOct)drawOctree(fieldOct, true, color(0));

  if (vidRec) {
    saveFrame("video/AgentBodyMesh_####.jpg");
    cam.beginHUD();
    pushStyle();
    noStroke();
    fill(255, 0, 0);
    rect(10, 10, 10, 10);
    popStyle();
    cam.endHUD();
  }

  dispGUI();
}

void keyPressed() {
  if (key =='i') saveFrame("img/AgentBody_####.png");
  if (key=='v') vidRec = !vidRec;
  if (key=='f') fieldDisp = !fieldDisp;
  if (key==' ') go = !go;
  if (key=='l') lock = true;
  if (key=='d') debugView = !debugView;
  if (key=='e') exportBodies(agents, "_struct_topoXt");
  if (key=='o') viewOct = !viewOct;
}