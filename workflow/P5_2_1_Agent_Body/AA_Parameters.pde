// parameters and global variables are collected here

int nAgents = 2000;//3000
float rad = 250;
float pSize;
float fA = 0.01; // field alignment intensity
float cR = 80; // cohesion radius
float aR = 80; // alignment radius
float sR = 10; // separation radius
float cI = 0.1; // cohesion intensity
float aI = 1; // alignment intensity
float sI = 5; // separation intensity

// 80, 80, 10, 0.1, 1, 5); // cR, aR, sR, cI, aI, sI

AgentBody[] agents;
ToxiclibsSupport gfx;
PeasyCam cam;
TensorPt[] field;
PointOctree fieldOct;

ControlP5 c5;

String timeStamp;

boolean vidRec = false;
boolean fieldDisp = false;
boolean debugView = false;
boolean viewOct = false;
boolean lock = false;
boolean agentsLocked = false;
boolean go = false;
boolean connectedOnly = false;