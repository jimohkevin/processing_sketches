public class FlowField {
  public ArrayList<ForceVector> forceVectors = new ArrayList<ForceVector>();
  float res;

  public FlowField(float resolution) {
    this.res = resolution;

    this.init();
  }

  void init() {
    PVector pos, force, origin, radius;
    float theta;
    origin = new PVector(0, 0);

    //for (float i = 0; i <= 2*PI; i += PI/180) {
    //  println(degrees(i) + ": " + degrees(acos(cos(i))));
    //}

    for (int i = -width/2; i <= width/2; i += width/sqrt(this.res)) {
      for (int j = -height/2; j <= height/2; j += height/sqrt(this.res)) {
        pos = new PVector(i, j);

        radius = pos.copy().sub(origin);
        radius.div(2);
        
        //resolves limited range of acos()
        if (j >= 0) {
          theta = acos(i/sqrt(sq(i)+sq(j)));
        } else {
          theta = 2*PI-acos(i/sqrt(sq(i)+sq(j)));
        }

        
        //circular vector field broken down by quadrant
        
        float c = -0.5;
        if (i > 0 && j > 0)
          //i+ j+
          force = new PVector(c/(sq(cos(theta))/radius.x), -c/(sq(sin(theta))/radius.y));
          
        else if(i > 0 && j < 0){
          //i+ j-
          force = new PVector(-c/(sq(cos(theta))/radius.x), c/(sq(sin(theta))/radius.y));
          
        } else if(i < 0 && j < 0){
          //i- j-
          force = new PVector(c/(sq(cos(theta))/radius.x), -c/(sq(sin(theta))/radius.y));
          
        } else{
          //i- j+
          force = new PVector(-c/(sq(cos(theta))/radius.x), c/(sq(sin(theta))/radius.y));
          
        }
        forceVectors.add(new ForceVector(pos, force));
      }
    }
  }

  public void display() {
    for (ForceVector f : forceVectors) {
      pushMatrix();



      translate(f.pos.x, f.pos.y);

      if (f.force.x > 0)
        rotate(atan(f.force.y/f.force.x));
      else
        rotate(PI+atan(f.force.y/f.force.x));

      line(0, 0, f.force.mag()*8, 0);
      fill(255, 0, 0);
      ellipse(f.force.mag()*8, 0, 2, 2);
      fill(255);

      popMatrix();
    }
  }
}


public class ForceVector {
  public PVector pos, force;
  public ForceVector(PVector position, PVector force) {
    this.pos = position;
    this.force = force;
    this.force.normalize();
  }
}
