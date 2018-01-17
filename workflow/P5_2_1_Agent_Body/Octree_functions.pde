// Octree creation from points

/*
 note on Octree:
 
 . octree must always be a cube in shape
 . pivot is the lower corner (min coordinates) and extension is the side of a cube
 . must be initialized to its maximum size from the beginning
 
 */


PointOctree octreeFromField(TensorPt[] field) {
  PointOctree octree;

  float mX = Float.MAX_VALUE, mY = Float.MAX_VALUE, mZ = Float.MAX_VALUE, 
    MX = Float.MIN_VALUE, MY = Float.MIN_VALUE, MZ = Float.MIN_VALUE;


  for (int i=0; i < field.length; i++) {
    if (field[i].x < mX) mX = field[i].x; 
    if (field[i].x > MX) MX = field[i].x;
    if (field[i].y < mY) mY = field[i].y; 
    if (field[i].y > MY) MY = field[i].y;
    if (field[i].z < mZ) mZ = field[i].z; 
    if (field[i].z > MZ) MZ = field[i].z;
  }
  Vec3D pivot = new Vec3D(mX, mY, mZ);
  Vec3D extent = new Vec3D(MX-mX, MY-mY, MZ-mZ);
  Vec3D centroid = pivot.add(extent.scale(0.5));
  pivot = centroid.add(extent.scale(-1));

  // find max size
  float size = extent.x>extent.y? (extent.x > extent.z? extent.x: extent.z):(extent.y > extent.z? extent.y: extent.z);
  octree = new PointOctree(pivot, size*2);

  for (int i = 0; i< field.length; i++) {
    octree.addPoint(field[i]);
  }

  return octree;
}



TensorPt getOctClosest(PointOctree field, Vec3D pos) {
  PointOctree leaf = field.getLeafForPoint(pos);
  TensorPt tp=null;// = new Vec3D();
  if (leaf !=null && leaf.getSize()>0) {
    float dist, dMin = Float.MAX_VALUE;
    //ArrayList <Vec3D> ptLeaf = (ArrayList<Vec3D>) leaf.getPoints();
    ArrayList  ptLeaf = (ArrayList) leaf.getPoints();
    for (int i=0; i< ptLeaf.size(); i++) {
      TensorPt pt = (TensorPt) ptLeaf.get(i);
      dist = pos.distanceToSquared(pt);
      if (dist > 0 && dist< dMin) {
        dMin = dist;
        tp = pt;
      }
    }
  }
  return tp;
}


// toxi display methods

// this method recursively paints an entire octree structure
void drawOctree(PointOctree node, boolean doShowGrid, int col) {
  if (doShowGrid) {
    drawBox(node);
  }
  if (node.getNumChildren() > 0) {
    PointOctree[] children = node.getChildren();
    for (int i = 0; i < 8; i++) {
      if (children[i] != null) {
        drawOctree(children[i], doShowGrid, col);
      }
    }
  } else {
    java.util.List points = node.getPoints();
    if (points != null) {
      stroke(col);
      strokeWeight(5);
      beginShape(POINTS);
      int numP = points.size();
      for (int i = 0; i < numP; i += 10) {
        Vec3D p = (Vec3D)points.get(i);
        vertex(p.x, p.y, p.z);
      }
      endShape();
    }
  }
}

void drawBox(PointOctree node) {
  pushStyle();
  noFill();
  stroke(0, 24);
  strokeWeight(1);
  pushMatrix();
  translate(node.x, node.y, node.z);
  box(node.getSize());
  popMatrix();
  popStyle();
}