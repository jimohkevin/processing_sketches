ArrayList<Cell> cells = new ArrayList<Cell>();

int num = 5;
int xBounds[], yBounds[];

void setup(){
  size(600, 400);
  
  xBounds = new int[]{0, width};
  yBounds = new int[]{0, height};
  
  for(int x = 0; x < num; x++){
    PVector pos = new PVector(random(width), random(height));
    
    cells.add(new Cell(pos, 50));
    cells.get(x).vel = new PVector(random(-5, 5), random(-5, 5));
  }
}

void draw(){
  background(0);
  stroke(0);
  
  for(Cell cell: cells){
    cell.display();
    cell.update(xBounds, yBounds);
    
    if(mousePressed)
      cell.applyForce(new PVector(0, 0.1).normalize());
      
  }
  
  
  
}
