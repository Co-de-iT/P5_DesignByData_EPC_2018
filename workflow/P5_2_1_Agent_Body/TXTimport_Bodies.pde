// agents body import

Body importAgentBody(String fileName, float tipRad, float angVis, float maxForce, int maxConn) {

  Body bod;
  Vec3D core, forward, vec;
  Tip[] tips;

  // load file and split lines into separate strings
  String[] txtLines = loadStrings(dataPath(fileName));

  // core is always (0,0,0)
  core=new Vec3D();
  // default forward is Z axis
  forward = new Vec3D(0,0,1);
  tips = new Tip[txtLines.length-1];

  // loop thru them
  for (int i = 0; i < txtLines.length; ++i) {

    //splits into elements
    String[] arrToks = split(txtLines[i], ',');

    //separates coords point
    //String[] arrToks = split(elements[0], ',');
    float xx = Float.valueOf(arrToks[0]);
    float yy = Float.valueOf(arrToks[1]);
    float zz = Float.valueOf(arrToks[2]);
    vec = new Vec3D(xx, yy, zz);
    if (i==0) {
      // first line is the forward dir
      forward = new Vec3D(vec);
    } else {
      //add pt to tips array

      tips[i-1] = new Tip(vec, core, i-1, tipRad, angVis, maxForce, maxConn);
    }
  }
  
  bod = new Body(tips, forward,0);

  return bod;
}

// field import