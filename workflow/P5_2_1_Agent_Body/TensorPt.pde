class TensorPt extends Vec3D {
  Vec3D dir, dn, fPos;
  float value;
  int id;
  ArrayList<Integer> connections;

  TensorPt(Vec3D pos, Vec3D dir, int id, float value) {
    super(pos);
    this.dir = dir;
    dn = new Vec3D(dir).normalize();
    this.id = id;
    fPos = pos.add(dir);
    this.value = value;
    connections = new ArrayList <Integer> ();
    //octree = new PointOctree(
  }

  TensorPt(Vec3D pos, Vec3D dir, int id) {
    this(pos, dir, id, 0);
  }

  void display(color pCol, float pWeight, color vCol, float vScale) {
    stroke(pCol);
    strokeWeight (pWeight*1.5);
    point(x, y, z);
    if (vScale > 0) {
      stroke(vCol);
      strokeWeight(pWeight);
      line(x, y, z, x+dir.x*vScale, y+dir.y*vScale, z+dir.z*vScale);
    }
  }
  
  // display with color by normal map orientation
  void display(float pWeight, float vScale) { 
    float r = map (dn.x,-1,1,0,255);
    float g = map (dn.y,-1,1,0,255);
    float b = map (dn.z,-1,1,0,255);
    stroke(color (r,g,b));
    strokeWeight (pWeight*1.5);
    point(x, y, z);
    if (vScale > 0) {
      //stroke(vCol);
      strokeWeight(pWeight);
      line(x, y, z, x+dir.x*vScale, y+dir.y*vScale, z+dir.z*vScale);
    }
  }
}