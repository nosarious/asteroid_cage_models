import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import wblut.nurbs.*;
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
int counter;
int cellCounter;
float[][] points;
boolean[] isCellOn;
boolean[] isCellOff;

PShader depthShader;

PGraphics depthImage;

HE_Mesh newMesh;

int aValue;// used to generate asteroid colour, random every creation

void setup(){
  counter = 1;
  centerPoint = new WB_SimpleCoordinate4D(0.0,0.0,0.0,0.0);
  
  size(1000,700,P3D);
  smooth(8);
  
  depthImage = createGraphics(width, height);
  
  // Load shader
  depthShader = loadShader("frag.glsl","vert.glsl");
  
  //thesePoints.add(centerPoint);
  
  prepSettings(); //comment out to quicken shader development
  
  render=new WB_Render(this);
  
  // only used to quicken blur shader development
  /*
  HEC_Cylinder creator=new HEC_Cylinder();
  creator.setRadius(75,50); // upper and lower radius. If one is 0, HEC_Cone is called. 
  creator.setHeight(800);
  creator.setFacets(7).setSteps(4);
  creator.setCap(true,true);// cap top, cap bottom?
  //Default axis of the cylinder is (0,1,0). To change this use the HEC_Creator method setZAxis(..).
  creator.setZAxis(0,1,1);
  
  newMesh=new HE_Mesh(creator); 
  
  HE_FaceIterator fitr=newMesh.fItr();
  while (fitr.hasNext()) {
    fitr.next().setColor(color(random(255),random(255),random(255)));
  }
  */
}

void update(){
   
}

void draw(){
  background(55);
  
  // Bind shader //shader is not working with lighting
  //shader(depthShader); //use of shader will ignore lighting
  
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  pointLight(255,255,255,0,0,0);
  translate(width/2, height/2,-800);
  rotateY(mouseX*1.0f/width*TWO_PI);
  rotateX(mouseY*1.0f/height*TWO_PI);
  
  pushMatrix();
    //scale (0.85);
    //translate(0.0,0.0,100);
    stroke(250,25);
    //render.drawEdges(aShape);
    //render.drawEdges(newMesh); //used to quicken shader development
    noStroke();
    //fill(255);
    drawAsteroidCells();
    //render.drawFacesFC(newMesh); //used to quicken shader development
  popMatrix();
}

void drawAsteroidCells(){
  colorMode(HSB, 360);
  color asteroidColour = color(aValue, 360,360);
  
  int fwValue = aValue + 150;
  if (fwValue >360) fwValue -= 360;
  
  int dwValue = aValue + 200;
  if (dwValue >360) dwValue -= 360;
  
  
  color firstWireframeColour = color (fwValue, 360,200);
  color dualWireframeColour = color (dwValue, 360,100);
  
  for (int i=0; i<asteroidCells.size(); i++){
    if (((i % counter) == 0)){
      //noFill();
      if (cellCounter == 1){
        fill(dualWireframeColour);
        try{
          render.drawFaces(allDualWireFrames.getMesh(i));
        } catch (final Exception ex) {
          println("failed cell at "+ i);
        }
      } else {
        fill(firstWireframeColour);
        try{
          render.drawFaces(allFirstWireFrames.getMesh(i));
        } catch (final Exception ex) {
          println("failed cell at "+ i);
        }
      }
    } else {
    //if (!((i % counter) == 0)){
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
    if (counter>8) counter = 1;
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