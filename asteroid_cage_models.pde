import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import java.util.List;

//variables
HE_Mesh firstShape;
HE_Mesh dualShape;
HE_Mesh aShape;

HE_Mesh firstWireframe;
HE_Mesh dualWireframe;
HE_Mesh firstVoro;

HE_Mesh bShape;
HE_Mesh innerShape;
WB_Render render;
HE_MeshCollection asteroidCells;
HE_MeshCollection firstCells;
HE_MeshCollection dualCells;

HE_Mesh finalAsteroid;
HE_Mesh finalFirstWireframe;
HE_Mesh finalDualWireframe;

HE_MeshCollection allDualWireFrames;
HE_MeshCollection allFirstWireFrames;

HE_Mesh cellLattices;
WB_SimpleCoordinate4D centerPoint;
List <WB_Coord> thesePoints;
int B, C;
int counter;
int cellCounter;
float[][] points;
boolean[] isCellOn;
boolean[] isCellOff;



void setup(){
  counter = 1;
  centerPoint = new WB_SimpleCoordinate4D(0.0,0.0,0.0,0.0);
  
  size(1000,700,P3D);
  smooth(8);
  // make a icosahedron
  B=1;
  C=0;
  HEC_Geodesic creator=new HEC_Geodesic();
  creator.setRadius(20);
  creator.setB(B+1);
  creator.setC(C);
  creator.setType(HEC_Geodesic.ICOSAHEDRON);
  innerShape = new HE_Mesh(creator); 
  
  // get points from icosohedron
  thesePoints = innerShape.getPoints();
  //thesePoints.add(centerPoint);
  
  prepSettings();
  
  render=new WB_Render(this);
}

void update(){
   
}

void draw(){
  
  background(55);
  directionalLight(255, 255, 255, 1, 1, -1);
  //directionalLight(127, 127, 127, -1, -1, 1);
  //pointLight(255,255,255,0,0,0);
  translate(width/2, height/2,-800);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  
  pushMatrix();
    //scale (0.85);
    //translate(0.0,0.0,100);
    //stroke(0,50);
    //render.drawEdges(aShape);
    noStroke();
    //fill(255);
    drawAsteroidCells();
    
  popMatrix();
  
}

void drawAsteroidCells(){
  for (int i=0; i<asteroidCells.size()-1; i++){
    if (((i % counter) == 0)){
      //noFill();
      if (cellCounter == 1){
      fill(255,255,0);
        render.drawFaces(allDualWireFrames.getMesh(i));
      } else {
      fill(255,0,0);
        render.drawFaces(allFirstWireFrames.getMesh(i));
      }
    } 
    /*
    if (((i % (counter+1))==0)){
      fill(255,0,0);
      render.drawFaces(allFirstWireFrames.getMesh(i));
    }
    */
    if (!((i % counter) == 0)){
      fill(255);
      noStroke();
      //stroke(0);
      render.drawFacesFC(asteroidCells.getMesh(i));
    }
  }
}

void mousePressed(){
  prepSettings();
}

void keyPressed(){
  if (key==' '){ //change which cells are shown/hidden (uses %)
    counter ++;
    if (counter>8) counter = 2;
    println(counter);
  }
  if (key=='.'){ //change which wireframe is shown
    cellCounter++;
    if (cellCounter>1) cellCounter = 0; 
  }
  if (key==','){ //change which wireframe is shown
    cellCounter--;
    if (cellCounter<0) cellCounter =  1; 
  }
  if (key=='s'){ //save the models to files.
    saveModels(); 
  }
}