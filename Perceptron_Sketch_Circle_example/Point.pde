public class Point{
  public PVector pos;
  
  float s = 20;
  
  
  public Point(PVector position, float size){
    this.pos = position;
    this.s = size;
    
  }
  
  void show(){
    ellipse(this.pos.x, this.pos.y, this.s, this.s);
  }
  
}
