//creates wireframes for each mesh in a collection
HE_Mesh createWireframes(HE_MeshCollection theseMeshes){
  HE_Mesh thisNewMesh = new HE_Mesh();
  int numcells=theseMeshes.size();
  boolean[] isCellOn=new boolean[numcells];
  for (int i=0; i<numcells; i++) {
    //print(" "+ i );
    HE_Mesh thisCellMesh = new HE_Mesh();
    thisCellMesh = theseMeshes.getMesh(i).get();
    thisNewMesh.add(createWireframe(thisCellMesh));
  }
  //thisNewMesh.validate();
  //thisNewMesh.simplify(thisNewMesh);
  //println ("wireFrames are made");
  
  return thisNewMesh;
}

//creates a wireframe for a given mesh
HE_Mesh createWireframe(HE_Mesh thisMesh){
  //this should return a wireframe mesh from a given mesh
  HE_Mesh thisNewMesh = new HE_Mesh();
  thisNewMesh = thisMesh.get();
  
  thisNewMesh.fuseCoplanarFaces();
  
  HEM_Wireframe modifier=new HEM_Wireframe();
  //modifier.setStrutRadius(cellRatioArea);// strut radius
  modifier.setStrutRadius(30);
  modifier.setStrutFacets(5);// number of faces in the struts, min 3, max whatever blows up the CPU
  modifier.setMaximumStrutOffset(10);// limit the joint radius by decreasing the strut radius where necessary. Joint offset is added after this limitation.
  modifier.setAngleOffset(0.5);// rotate the struts by a fraction of a facet. 0 is no rotation, 1 is a rotation over a full facet. More noticeable for low number of facets.
  modifier.setTaper(true);// allow struts to have different radii at each end?
  //modifier.setFillFactor(0.5);
  modifier.setCap(true);
  thisNewMesh.modify(modifier);
  
  thisNewMesh.fuseCoplanarFaces();
  //thisNewMesh.validate();
  
  HES_CatmullClark subdividor=new HES_CatmullClark();
  //using latest build so this isn't necessary anymore
  /*
  //try to catmull this mesh.
  //if it doesn't work, send back unatlered mesh. 
  HE_Mesh tmp=thisNewMesh.get();
  HES_CatmullClark subdividor=new HES_CatmullClark();
  try {
    thisNewMesh.subdivide(subdividor, 1);
  }
  catch(final Exception ex) {
    //oops HE_Mesh messed up, retreat!
    ex.printStackTrace();
    thisNewMesh=tmp;
  }
  */ 
  thisNewMesh.scaleSelf(0.96);
  return thisNewMesh;
}

// unused (for now)
HE_MeshCollection createSeperateWireframes(HE_MeshCollection theseMeshes){
  HE_Mesh thisNewMesh = new HE_Mesh();
  int numcells=theseMeshes.size();
  boolean[] isCellOn=new boolean[numcells];
  for (int i=0; i<numcells; i++) {
    //print(" "+ i );
    HE_Mesh thisCellMesh = new HE_Mesh();
    thisCellMesh = theseMeshes.getMesh(i);
    
    thisCellMesh = createWireframe(thisCellMesh);
    //thisNewMesh.add(createWireframe(thisCellMesh));
  }
  //thisNewMesh.validate();
  //thisNewMesh.simplify(thisNewMesh);
  //println ("wireFrames are made");
  
  return theseMeshes;
}