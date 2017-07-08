// overly wordy because I sepnt too much time trying to figure this out.
void saveModels(){
  String mainFolderName = sketchPath()+"/"+"asteroid"+day()+frameCount;
  String asteroidFolder = mainFolderName+"/"+"asteroidCells";
  String firstFolder = mainFolderName+"/"+"firstCells";
  String dualFolder = mainFolderName+"/"+"dualCells";
  
  File mF = new File(mainFolderName);
  File aF = new File(asteroidFolder);
  File fF = new File(firstFolder);
  File dF = new File(dualFolder);
  
  mF.mkdir();
  aF.mkdir();
  fF.mkdir();
  dF.mkdir();
  
  print("starting save routine. ");
  for (int i=0; i<asteroidCells.size(); i++){
    try {
      HET_Export.saveToOBJ(asteroidCells.getMesh(i), asteroidFolder,"asteroidCell"+i);
    }
    catch(final Exception ex) {
      //oops HE_Mesh messed up, retreat!
      ex.printStackTrace();
      print (" failed to create a file for ");//thisNewMesh=tmp;
    }
    print(" "+i);
  }
  println (" the asteroid cells are saved. ");
  for (int i=0; i<allFirstWireFrames.size(); i++){
      try {
        HET_Export.saveToOBJ(allFirstWireFrames.getMesh(i), firstFolder,"firstWireframeCell"+i);
      }
      catch(final Exception ex) {
        //oops HE_Mesh messed up, retreat!
        ex.printStackTrace();
        print (" failed to create a file for ");//thisNewMesh=tmp;
      }
      print(" "+i);
  }
  println (" the first wireframe cells are saved. ");
  for (int i=0; i<allDualWireFrames.size(); i++){
    try {
      HET_Export.saveToOBJ(allDualWireFrames.getMesh(i), dualFolder,"dualWireframeCell"+i);
    }
    catch(final Exception ex) {
      //oops HE_Mesh messed up, retreat!
      ex.printStackTrace();
      print (" failed to create a file for ");//thisNewMesh=tmp;
    }
    print(" "+i);
  }
  println (" the dual wireframe cells are saved. ");
}