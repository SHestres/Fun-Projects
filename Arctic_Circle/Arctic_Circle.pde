///////////////////////////////////
//
//    Arctic Circle Theorem
//
//  Author: Sidney Hestres
//
// Note: This is messy code, feel free to look through it but you've been warned!
//       It works by creating a grid object, which is an array that hold tile states. The tile states are a number 0-8,
//       and those are explained in the instructions page. The indexes of the tiles are based on a modified triangle number
//       formula (modified to have a 2-tile tip)
//
///////////////////////////////////


grid thisGrid;
float back_color;

boolean squared;  //Controls stretch to window, or squared rendering
boolean tiles;  //Controls the rendering of tile borders

void setup(){
  size(1600,1600);
  surface.setResizable(true);
  tiles = true;
  
  thisGrid = new grid();
  back_color = 255;
  
}

void draw(){
  background(back_color);
  renderGrid(thisGrid);
  if(keyPressed){                      //Allows for continual progression
    if(key == 'p'){
      thisGrid = thisGrid.getNext();   //Advance to a grid one order higher
    }
  }
}

void keyPressed(){                        //To control single action inputs
  
  if(key == 'r'){thisGrid = new grid();}  //Reset
  
  else if(key == 'c'){
    if(back_color == 0){back_color = 255;}
    else{back_color = 0;}
  }
  else if(key == 's'){squared = !squared;}
  
  else if (key == 'n'){thisGrid = thisGrid.getNext();}
  
  else if (key == 't'){tiles = !tiles;}
}

void renderGrid(grid grid){
  
  int s = grid.size();
  float sq_width = float(width)/(s*2);  //Calculate the size of each square to be rendered. Each square is half of one tile
  float sq_height = float(height)/(s*2);
  
  if(squared){ 
    if(sq_width > sq_height){sq_width = sq_height;}
    else{sq_height = sq_width;}
  }
  
  int[] data = grid.getData();
  
  for(int i = 0; i < data.length; i++){
    
    float xpos;
    float ypos;
    if(i < ceil(data.length/2)){
      int row = ceil((-1+sqrt(4*i+5))/2); //This formula is derived from the eqution of triangle numbers
      
      int ind_offset = (row-1)*(row)-1;  //This looks different because it's the modified triangle number for the previous row
      int indInRow = i - (ind_offset + 1); //Which position in the row it has
      xpos = (width/2)-(row-indInRow)*sq_width;
      ypos = height/2 - (s - (row -1))*sq_height;
    }else{
      int j = data.length - 1 - i;  //A reverse indexing of the second half of the array
      int inv_row = ceil((-1+sqrt(4*j+5))/2); //This is a reverse indexing of the rows in the second half
      int ind_offset = inv_row*(inv_row - 1) - 1; 
      int invIndInRow = j - (ind_offset + 1); //Note: Because this is working with the inverted indexes, it is the position from the right of the row
      
      xpos = (width/2)+(inv_row - 1 - invIndInRow)*sq_width;
      ypos = height/2 + (s - inv_row) * sq_height;
    }
    
    
    float temp_sq_height = sq_height;
    float temp_sq_width = sq_width;
    
    if(tiles){  //To anybody seeing this: this is definitely NOT the most efficient way to do it, but I was kinda on a switch case binge so here we are
      switch(data[i]){
        case 1:
          fill(200,200,0);
          stroke(200, 200, 0);
          rect(xpos,ypos,sq_width,sq_height);
          fill(255,255,0);
          temp_sq_width *= 0.8;
          temp_sq_height *= 0.9;
          xpos += sq_width*0.1;
          ypos += sq_height*0.1;
          break;
        case 2:
          fill(0, 0, 200);
          stroke(0, 0, 200);
          rect(xpos, ypos, sq_width, sq_height);
          temp_sq_width *= 0.9;
          temp_sq_height *= 0.8;
          xpos += sq_width*0.1;
          ypos += sq_height*0.1;
          break;
        case 3:
          fill(200,0,0);
          stroke(200, 0, 0);
          rect(xpos,ypos,sq_width,sq_height);
          fill(255,255,0);
          temp_sq_width *= 0.8;
          temp_sq_height *= 0.9;
          xpos += sq_width*0.1;
          ypos += sq_height*0.1;
          break;
        case 4:
          fill(0, 200, 0);
          stroke(0,200, 0);
          rect(xpos, ypos, sq_width, sq_height);
          temp_sq_width *= 0.9;
          temp_sq_height *= 0.8;
          xpos += sq_width*0.1;
          ypos += sq_height*0.1;
          break;
        case 6:
          fill(200,200,0);
          stroke(200, 200, 0);
          rect(xpos,ypos,sq_width,sq_height);
          fill(255,255,0);
          temp_sq_width *= 0.8;
          temp_sq_height *= 0.9;
          xpos += sq_width*0.1;
          break;
        case 7:
          fill(0, 0, 200);
          stroke(0, 0, 200);
          rect(xpos, ypos, sq_width, sq_height);
          temp_sq_width *= 0.9;
          temp_sq_height *= 0.8;
          ypos += sq_height*0.1;
          break;
        case 8:
          fill(200,0,0);
          stroke(200, 0, 0);
          rect(xpos,ypos,sq_width,sq_height);
          fill(255,255,0);
          temp_sq_width *= 0.8;
          temp_sq_height *= 0.9;
          xpos += sq_width*0.1;
          break;
        case 9:
          fill(0, 200, 0);
          stroke(0,200, 0);
          rect(xpos, ypos, sq_width, sq_height);
          temp_sq_width *= 0.9;
          temp_sq_height *= 0.8;
          ypos += sq_height*0.1;
          break;
      }
    }
    
    
    switch(data[i]){ //Setting the color of rectangle based on the directin the tile is facing.
      case 1: case 6:
        fill(255, 255, 0); //Yellow for pointing left
        stroke(255, 255, 0);
        break;
      case 2: case 7:
        fill(0, 0, 255);
        stroke(0, 0, 255);
        break;
      case 3: case 8:
        fill(255, 0, 0);
        stroke(255, 0, 0);
        break;
      case 4: case 9:
        fill(0, 255, 0);
        stroke(0, 255, 0);
        break;
    }

    
    rect(xpos,ypos,temp_sq_width,temp_sq_height);
    
    
  }
}
