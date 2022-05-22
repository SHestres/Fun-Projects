import java.util.Random;
class grid{
  private int size;  //The order of the current grid
  private int[] fill;  //And array to hold the tile located on each grid. This is represented by a 
  
  private grid next;  //A reference to the next grid in this series
  
  public grid(){ //Constructs a first order grid
    size = 1;
    fill = new int[4];
    fillEmpties();
  }
  
  public grid(int s){  //Constructs an empty grid of order s
    size = s;
    int arraySize = 0;
    for(int i = 1; i <= size; i++){
      //println(arraySize);
      arraySize += 4*i;
      //println(i, arraySize);
    }
    fill = new int[arraySize];
    //println(arraySize, fill.length);
  }
  
  
  public int size(){
    return size;
  }
  
  
  public int[] getData(){
    return fill;
  }
  
  public grid getNext(){  //returns a reference to the next grid in this series
    if(next == null){
      next = new grid(size + 1);
      //println(next.getData());
      next.fillUpwards(fill);
      //println(next.getData());
      next.progress();
      //println(next.getData());
      next.fillEmpties();
      //println(next.getData());
      
    }
    return next;
  }
    
  public void fillUpwards(int[] filler){ //Takes the filled array of the previous grid in the series and copies it into this larger grid
    int s_old = filler.length;
    int s_new = fill.length;
    //println(s_old,s_new);
    for(int i = 0; i < ceil(s_old/2); i++){
      //println(i);
      fill[belowIndex(i)] = filler[i];  //The fill should be placed in the center of the new grid. A border of empty squares is required for removeBaddies()
      fill[aboveIndex(s_new - i - 1)] = filler[s_old - i - 1];
    }
  }
    
    
  public void progress(){  //Clears all tiles facing each other and then steps all tiles forward. This does not check for the state of the grid and will throw errors if called on a grid that cannot progress
    clearBaddies();
    int[] temp = new int[fill.length];
    for(int i = 0; i < fill.length; i++){
      int state = fill[i];
      switch(state){
        case 1: case 6:  //Used to represent a tile facing left
          temp[i-1] = fill[i];
          //println("case 1: ", i);
          //println(temp);
          break;
          
        case 2: case 7: //A tile facing up
          temp[aboveIndex(i)] = fill[i];
          
          //println("case 2: ", i);
          //println(temp);
          break;
          
        case 3: case 8: //A tile facing right
          temp[i+1] = fill[i];
          
          //println("case 3: ", i);
          //println(temp);
          break;
          
        case 4: case 9: //A tile facing down
          temp[belowIndex(i)] = fill[i];
          
          //println("case 4: ", i);
          //println(temp);
          break;
      }
    }
    for(int i = 0; i < temp.length; i++){
      fill[i] = temp[i];
    }
    
  }
  
  public void clearBaddies(){  //Clears all tiles facing each other. Note: Here we only have to check tile facing left and upwards
    for(int i = 0; i < fill.length; i++){
      switch(fill[i]){
        case 1: case 6://A tile facing left
          if(fill[i-1] == 3 || fill[i-1] == 8){
            fill[i] = 0;
            fill[i - 1] = 0;
          }
          break;
        case 2: case 7: //A tile facing upwards
          if(fill[aboveIndex(i)] == 4 || fill[aboveIndex(i)] == 9){
            fill[i] = 0;
            fill[aboveIndex(i)] = 0;
          }
          break;
      }
    }
  }
  
  private int aboveIndex(int ind){
    int out;
    if(ind < ceil(fill.length/2)){
      int row = ceil((-1+sqrt(4*ind+5))/2); //This formula is derived from the eqution of triangle numbers
      out = ind-(2*row-1);
    }else{
      int j = fill.length - 1 - ind;  //A reverse indexing of the second half of the array
      int inv_row = ceil((-1+sqrt(4*j+5))/2); //This is a reverse indexing of the rows in the second half
      if(inv_row == size){  //This is necessary to calculate the second index for a tile going over the middle
        out = ind-2*size;
      }else{
        out = ind-(2*inv_row+1);
      }
    }
    return out;
  }
  
  private int belowIndex(int ind){
    int out;
    if(ind < ceil(fill.length/2)){
      int row = ceil((-1+sqrt(4*ind+5))/2); //This formula is derived from the eqution of triangle numbers
      if(row == size){  //This is necessary to calculate the second index for a tile going over the middle
        out = ind+2*size;
      }else{
        out = ind+(2*row+1);
      }
    }else{
      int j = fill.length - 1 - ind;  //A reverse indexing of the second half of the array
      int inv_row = ceil((-1+sqrt(4*j+5))/2); //This is a reverse indexing of the rows in the second half
      out = ind+(2*inv_row-1);
    }
    return out;
  }
  
  public void fillEmpties(){
    for(int i = 0; i < fill.length; i++){
      //randomSeed(hour()+second()+millis());
      int rand = (int)(Math.random()*1.99999);
      //println(i);
      //println(fill);
      if(fill[i] == 0){
        switch(rand){
          case 0:
            fill[i] = 1;
            fill[belowIndex(i)] = 6;
            fill[i+1] = 3;
            fill[belowIndex(i+1)] = 8;
            break;
          case 1:
            fill[i] = 2;
            fill[belowIndex(i)] = 4;
            fill[i+1] = 7;
            fill[belowIndex(i+1)] = 9;
            break;
        }
      }
    }
  }
    
  
  
}
