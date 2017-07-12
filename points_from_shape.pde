 
 
// this is intended to 
// return points which are used 
// to create voronoi from the main volume
   
List <WB_Coord> pointsFromLine(){
  HE_Mesh newMesh;
  HEM_Twist modifier;
  HEC_Cylinder creator=new HEC_Cylinder();
  creator.setRadius(75,50); // upper and lower radius. If one is 0, HEC_Cone is called. 
  creator.setHeight(1000);
  creator.setFacets(5).setSteps(3);
  creator.setCap(true,true);// cap top, cap bottom?
  //Default axis of the cylinder is (0,1,0). To change this use the HEC_Creator method setZAxis(..).
  creator.setZAxis(0,1,1);
  
  newMesh=new HE_Mesh(creator); 
  
  modifier=new HEM_Twist();
  WB_Line L;
  L=new WB_Line(0,0,0,0,1,1);
  modifier.setTwistAxis(L);// Twist axis
  //you can also pass the line as two points:  modifier.setBendAxis(0,0,-200,1,0,-200)
  
  modifier.setAngleFactor(5.0);// Angle per unit distance (in degrees) to the twist axis
  // points which are a distance d from the axis are rotated around it by an angle d*angleFactor;
  
  newMesh.modify(modifier);
  
  List <WB_Coord> thePoints = newMesh.getPoints();
  
  return thePoints;
}

List <WB_Coord> pointsFromSphere(){
  
  int B, C;
  // make a icosahedron
  B=0;
  C=0;
  HEC_Geodesic creator=new HEC_Geodesic();
  creator.setRadius(20);
  creator.setB(B+1);
  creator.setC(C);
  creator.setType(HEC_Geodesic.ICOSAHEDRON);
  HE_Mesh thisMesh = new HE_Mesh(creator); 
  
  // get points from icosohedron
  thesePoints = thisMesh.getPoints();
  
  List <WB_Coord> thePoints = thisMesh.getPoints();
  
  return thePoints;
}