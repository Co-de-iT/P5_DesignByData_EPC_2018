// parameters and global variables are collected here

int nAgents = 2000;//3000
float rad = 250;
float pSize;
float fA = 0.01; // field alignment intensity
AgentBody[] agents;
ToxiclibsSupport gfx;
PeasyCam cam;
TensorPt[] field;
PointOctree fieldOct;

ControlP5 c5;

boolean vidRec = false;
boolean fieldDisp = false;
boolean debugView = false;
boolean viewOct = false;
boolean lock = false;
boolean go = false;