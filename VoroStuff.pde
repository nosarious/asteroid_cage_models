
HE_MeshCollection createVoro(HE_Mesh outerShape){
  HE_Mesh thisNewMesh = new HE_Mesh();
  thisNewMesh = outerShape.get();
  
  HE_MeshCollection cells;
  HE_MeshCollection validCells;
  validCells = new HE_MeshCollection();
  
  // generate voronoi cells
  HEMC_VoronoiCells multiCreator=new HEMC_VoronoiCells();
  multiCreator.setPoints(thesePoints);
  // alternatively points can be WB_Point[], any Collection<WB_Point> and double[][];
  //multiCreator.setN(70);//number of points, can be smaller than number of points in input. 
  multiCreator.setContainer(thisNewMesh);// cutoff mesh for the voronoi cells, complex meshes increase the generation time
  //multiCreator.setOffset(20);// offset of the bisector cutting planes, sides of the voronoi cells will be separated by twice this distance
  multiCreator.setSurface(false);// is container mesh a volume (false) or a surface (true)
  multiCreator.setCreateSkin(false);// create the combined outer skin of the cells as an additional mesh? This mesh is the last in the returned array.
  multiCreator.setSimpleCap(false);
  multiCreator.setBruteForce(true);
  // can help speed up things for complex container and give more stable results. Creates the voronoi cells for a simple box and
  // uses this to reduce the number of slicing operations on the actual container. Not fully tested yet.
  cells=multiCreator.create();
  
  return cells;
}

//unused (for now)

HE_MeshCollection createVoroSurface(HE_Mesh outerShape){
  HE_Mesh thisNewMesh = new HE_Mesh();
  thisNewMesh = outerShape.get();
  
  HE_MeshCollection cells;
  
  // generate voronoi cells
  HEMC_VoronoiCells multiCreator=new HEMC_VoronoiCells();
  multiCreator.setPoints(thesePoints);
  // alternatively points can be WB_Point[], any Collection<WB_Point> and double[][];
  //multiCreator.setN(numPoints);//number of points, can be smaller than number of points in input. 
  multiCreator.setContainer(thisNewMesh);// cutoff mesh for the voronoi cells, complex meshes increase the generation time
  //multiCreator.setOffset(20);// offset of the bisector cutting planes, sides of the voronoi cells will be separated by twice this distance
  multiCreator.setSurface(true);// is container mesh a volume (false) or a surface (true)
  //multiCreator.setCreateSkin(true);// create the combined outer skin of the cells as an additional mesh? This mesh is the last in the returned array.
  multiCreator.setSimpleCap(true);
  // can help speed up things for complex container and give more stable results. Creates the voronoi cells for a simple box and
  // uses this to reduce the number of slicing operations on the actual container. Not fully tested yet.
  cells=multiCreator.create();
  
  return cells;
}