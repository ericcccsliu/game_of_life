class cells{
  
  private int[][] cell;
  int w; int l; //w is width, l is height (not length) 
  int size;
  int padding; 
  
  public cells(int w, int l, int size, int padding){
    this.w = w/size; 
    this.l = l/size; 
    this.size = size; 
    this.padding = padding; 
    
    cell = new int[this.w][this.l]; 
  }
  
  //method for setting inital configuration
  //make sure each thingie of the array is the same
  public void setConfiguration(int[][] init){
    for(int i = 0; i < init.length; i++){
       for(int j = 0; j < init[0].length; j++){
         cell[i][j] = init[i][j];
       }
    }
  }
  public void setConfiguration(){
     for(int i = 0; i < w; i++){
       for(int j = 0; j < l; j++){
         cell[i][j] = 0;
       }
    }
  }
  
  public void setConfiguration(double chance){
      for(int i = 0; i < w; i++){
         for(int j = 0; j < l; j++){
            if(Math.random() > (1-chance)){
                cell[i][j] = 1; 
            } else {
               cell[i][j] = 0;  
            }
         }
      }
  }
  
  
  //iterates the game by one step and draws
  public void iterate(){
     int[][] newCells = new int[w][l]; 
     
     for(int i = 0; i < w; i++){
       for(int j = 0; j < l; j++){
          int surrounding = adjacent(i, j); 
          if (cell[i][j] == 1){
             if(surrounding > 3 || surrounding < 2){
                newCells[i][j] = 0; //dies
             } else {
                newCells[i][j] = 1;  
             }
          } else {
             if(surrounding == 3){
                newCells[i][j] = 1; 
             } else {
                newCells[i][j] = 0;  
             }
          }
          drawCell(i, j, newCells[i][j]);
       }
     }
     cell = newCells; 
     
  }
  
  private int adjacent(int x,int y){
    
    int result = 0; 
    for(int i = -1; i <= 1; i++){
      for(int j = -1; j <= 1; j++){
        if(x + i >= 0 && x + i < w && y + j >= 0 && y + j < l
          && !(i == 0 && j == 0)) {
              result += cell[x+i][y+j]; 
          } else if (!(i == 0 && j == 0)){
            int a = x+i; int b = y+j; 
            if(x + i < 0){a = w - 1;}
            if(x + i >= w){a = 0;}
            if(y + j < 0){b = l - 1;}
            if(y + j >= l){b = 0;}
            result += cell[a][b]; 
          }
          
      }
    }
    
    return result; 
  }
  
  //draws a single cell
  private void drawCell(int x, int y, int life){
      fill((life == 1)? 255 : 0);
      rect(x*size, y*size, size-padding, size-padding, padding*2);
  }
  
  public void drawCells(){
     for(int i = 0; i < w; i++){
       for(int j = 0; j < l; j++){
          fill((cell[i][j] == 1)? 255 : 0);
          rect(i*size, j*size, size-padding, size-padding, padding*2); 
       }
     }
  }
  
  
  public void giveLife(int x, int y){
      if(cell[x][y] == 0){
         cell[x][y] = 1;  
      } else {
         cell[x][y] = 0; 
      }
  }
  //..also takes away
}
