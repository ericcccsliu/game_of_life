int refreshRate; 
boolean pause; 
int cellSize;
double filledProportion = 0.5;
cells ourCells;  

void setup() {
  fullScreen();
  System.out.println(height + " " + width); 
  
  background(0); 
  fill(0); 
  
  refreshRate = 250; 
  pause = true; //initial state paused
  
  cellSize = 40;
  
  ourCells = new cells(width, height, cellSize, cellSize/10); 
  ourCells.setConfiguration(filledProportion); 
}

void draw() {
  if(pause){
    ourCells.drawCells(); 
  } else {
    ourCells.iterate(); 
    delay(refreshRate); 
  }
}

void keyPressed(){
  if (key == ENTER || key == RETURN){
     if(pause){
        pause = false;  
     } else {
        pause = true;  
     }
  }
}

void mouseClicked(){
   ourCells.giveLife(((int)mouseX/cellSize), ((int)mouseY/cellSize));  
}
