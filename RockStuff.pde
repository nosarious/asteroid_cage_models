HE_Mesh createARock( float[][] points){
  print("starting rock formation ");
  HE_Mesh thisMesh;
  HEC_ConvexHull creator=new HEC_ConvexHull();
  
  creator.setPoints(points);
  //alternatively points can be WB_Coord[], HE_Vertex[], any Collection<? extends WB_Coord>, any Collection<HE_Vertex>,
  //double[][] or int[][]
  //creator.setN(10); // set number of points, can be lower than the number of passed points, only the first N points will be used

  thisMesh = new HE_Mesh(creator); 
  firstShape = new HE_Mesh(creator);
  println("rock is formed.");
  return thisMesh;
}

HE_Mesh createDualRock(HE_Mesh thisMesh){
  //this should return a HEC_Dual mesh
  HE_Mesh thisNewMesh = new HE_Mesh();
  thisNewMesh = thisMesh;
  thisNewMesh.copy();
  
  //find centers and build a new polygon shape
  HEC_Dual creator2=new HEC_Dual();
  creator2.setSource(thisNewMesh);
  thisNewMesh=new HE_Mesh(creator2);
  return thisNewMesh;
}


HE_Mesh finishRock(HE_Mesh thisMesh){
  //this should return an asteroid mesh from a given mesh
  HE_Mesh thisNewMesh = new HE_Mesh();
  thisNewMesh = thisMesh.get();
  
  print("finishing rock ");
  
  //Find the inset of these shapes
  HEM_SmoothInset modifier = new HEM_SmoothInset();
  
  modifier.setLevel(0);// level of recursive division
  modifier.setOffset(10);// distance between inset face and original faces (should be > 0)
  //insetMesh = new HE_Mesh(creator2);
  thisNewMesh.modify(modifier);
  
  HEM_Extrude modifier2 = new HEM_Extrude();
  modifier2.setDistance(-60);// extrusion distance, set to 0 for inset faces
  modifier2.setRelative(false);// treat chamfer as relative to face size or as absolute value
  modifier2.setChamfer(10);// chamfer for non-hard edges
  modifier2.setHardEdgeChamfer(20);// chamfer for hard edges
  modifier2.setThresholdAngle(0.25*HALF_PI);// treat edges sharper than this angle as hard edges
  modifier2.setFuse(false);// try to fuse planar adjacent planar faces created by the extrude
  modifier2.setFuseAngle(0.05*HALF_PI);// threshold angle to be considered coplanar
  modifier2.setPeak(false);//if absolute chamfer is too large for face, create a peak on the face
  //HE_Mesh extrudeCreator = new HE_Mesh();
  //extrudeCreator.setSource(inset);
  //extrude = new HE_Mesh(extrude);
  thisNewMesh.modify(modifier2);
  
  HES_CatmullClark subdividor=new HES_CatmullClark();
  subdividor.setKeepBoundary(true);// preserve position of vertices on a surface boundary
  subdividor.setKeepEdges(true);// preserve position of vertices on edge of selection (only useful if using subdivideSelected)
  thisNewMesh.subdivide(subdividor, 2);
  println("rock finishing completed");
  
  return thisNewMesh;
}