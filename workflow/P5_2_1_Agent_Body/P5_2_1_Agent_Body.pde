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
 . body: forward direction, tips number and position, tips search radius // now loads from file exported from GH
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
 
 
 agent color code
 
 grey/cyan: paused
 white: active
 black: aligned
 pink: connected
 
 */

import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import peasy.*;
import controlP5.*;
import java.util.*;



void setup() {

  size(1400, 900, P3D);
  //surface.setSize(displayWidth-20, displayHeight-80);
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
    if (lock && !agentsLocked) {
      agentsLocked = true;
      for (AgentBody a : agents) {
        a.locked = true; // locks agents
      }
    } else {
      for (AgentBody a : agents) {
        a.update(agents, cR, aR, sR, cI, aI, sI); // cR, aR, sR, cI, aI, sI
        a.alignWithField(field, fA);
        a.displayBody(color(255), 1);
      }
    }
  } else { // just display
    for (AgentBody a : agents) {
      a.displayBody(color(100, 120, 120), 3);
    }
  }


  // display field
  if (fieldDisp) {
    for (TensorPt t : field) {
      //t.display(color(255), 1, color(255, 0, 0), 20);
      t.display(1, 20); // display field with normal direction colors
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
  }

  if (saveImg) {
    saveFrame("img/AgentBody_####.png");
    saveImg = false;
  }

  dispGUI();
}

void keyPressed() {
  if (key =='i') saveImg = true;
  if (key=='v') {
    vidRec = !vidRec;
    Toggle t = (Toggle)c5.getController("vidRec"); // changes toggle state when using keyPressed
    t.setState(vidRec);
  }
  if (key=='f') {
    fieldDisp = !fieldDisp;
    Toggle t = (Toggle)c5.getController("fieldDisp"); // changes toggle state when using keyPressed
    t.setState(fieldDisp);
  }
  if (key==' ') { 
    go = !go;
    Toggle t = (Toggle)c5.getController("go");
    t.setState(go);
  }
  if (key=='l') {
    lock = true;
    Toggle t = (Toggle)c5.getController("lock");
    t.setState(lock);
  }
  if (key=='d') {
    debugView = !debugView;
    Toggle t = (Toggle)c5.getController("debugView");
    t.setState(debugView);
  }
  if (key=='e') exprtBds(0);
  //exportBodies(agents, exportFile, connectedOnly);
  //if (key=='o') viewOct = !viewOct;
}