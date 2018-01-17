class TensorPt extends Vec3D {
  Vec3D dir, fPos;
  float value;
  int id;
  ArrayList<Integer> connections;

  TensorPt(Vec3D pos, Vec3D dir, int id, float value) {
    super(pos);
    this.dir = dir;
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
}