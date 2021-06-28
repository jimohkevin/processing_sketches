Neuron n;
int slope = -2;
Point[] points = new Point[500];

void setup() {
  size(600, 600);

  n = new Neuron();

  //float[] inputs = {-1, 0.5};
  //float guess = n.guess(inputs);

  for (int i = 0; i < points.length; i++) {
    points[i] = new Point(new PVector(random(-width/2, width/2), random(-height/2, height/2)));
  }
}

void draw() {
  background(255);

  for (Point p : points) {
    float[] positions = {p.pos.x, p.pos.y};
    int target;
    
    //generates training data
    if (p.pos.y > f(p.pos.x)) {
      //fill(255);
      target = 1;
    } else {
      //fill(0);
      target = -1;
    }
    
    float guessData = n.train(positions, target);
    
    if(guessData == 0){
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    
    ellipse(p.pos.x + width/2, p.pos.y + height/2, 20, 20);
  }

  for(int i = -width/2; i < width/2; i++){
    strokeWeight(2);
    stroke(0);
    point(i + width/2, f(i)+height/2);
  }


  //displays grid
  
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  
  //quick exit shortcut
  if (keyPressed && key == 'r') {
    setup();
  }
}

float f(float x){
  
  return slope*x;
}

void mousePressed(){
  for(int i = 0; i < points.length; i++){
    points[i].pos = new PVector(random(-width/2, width/2), random(-height/2, height/2));
  }
  slope = int(random(-10,10));
}
