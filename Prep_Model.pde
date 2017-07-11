//creates the model

void prepSettings(){
  
  //thesePoints = pointsFromLine();
  thesePoints = pointsFromSphere();
  
  float objectRadius = 1000;
  points =new float[500][3];
  for (int i=0;i<12;i++) {
    float r = objectRadius;// + random(0.01f)-100;
    float phi = radians(random(-90, 90));
    float theta = radians(random(360));
    points[i][0] = r*cos(phi)*cos(theta);
    points[i][1] = r*sin(phi);
    points[i][2] = r*cos(phi)*sin(theta);
    
  }
  
  bShape = new HE_Mesh();
  bShape = createARock(points);
  
  bShape.moveToSelf(centerPoint);
  
  firstShape = bShape.get();
  HEM_TangentialSmooth smooth= new HEM_TangentialSmooth();
  firstShape.modify(smooth);
 
  bShape = createDualRock(bShape);
  dualShape = bShape.get();
  
  aShape = new HE_Mesh();
  aShape = bShape.get();
  //aShape.copy();
  aShape=finishRock(aShape);
  aShape.scaleSelf(0.9);
  
  HE_FaceIterator fitr=bShape.fItr();
  while (fitr.hasNext()) {
    fitr.next().setColor(color(200,10,200));
  }
  
  fitr=aShape.fItr();
  while (fitr.hasNext()) {
    fitr.next().setColor(color(200,175,10));
  }
  
  HET_MeshOp.flipFaces(bShape);
  bShape.scaleSelf(0.5);
  
  HE_Mesh innerFirst = bShape.get();
  HE_Mesh innerAsteroid = bShape.get();
  HE_Mesh innerDual = bShape.get();
  
  // all of the shapes have an inner void 
  
  aShape.add(innerAsteroid);// asteriod
  firstShape.add(innerFirst);//largestshape
  dualShape.add(innerDual);//dualshape
  
  //scaling so shapes are roughly the same size as the asteroid
  
  dualShape.scaleSelf(0.90);
  firstShape.scaleSelf(0.9);
  
  println("the shapes are combined");
  
  //create the voros 
  
  asteroidCells = createVoro(aShape);
  print("asteroid has "+asteroidCells.size()+" cells.");
  
  firstCells = createVoro(firstShape);
  print("first shape has "+firstCells.size()+" cells.");
  
  dualCells = createVoro(dualShape);
  println("dual has "+dualCells.size()+" cells.");
  
  /*
  int numcells=firstCells.size();
  isCellOn=new boolean[numcells];
  isCellOff=new boolean[numcells];
  for (int i=0; i<numcells; i++) {
    boolean check = (random(100)<50);
    isCellOn[i] = check;
    isCellOff[i] = !check;
  }
  */

  allFirstWireFrames = new HE_MeshCollection();
  for (int i=0; i<firstCells.size(); i++){
      allFirstWireFrames.add(createWireframe(firstCells.getMesh(i)));
  }
  println("there are "+allFirstWireFrames.size()+" cells in first wireframe collection");
  
  HE_MeshCollection theseOtherCells = new HE_MeshCollection();
  //theseOtherCells = new HE_MeshCollection();
  for (int i=0; i<firstCells.size(); i++){
      theseOtherCells.add(createWireframe(dualCells.getMesh(i)));
  }
  allDualWireFrames = theseOtherCells;
  println("there are "+allDualWireFrames.size()+" cells in dual wireframe collection");
  
}