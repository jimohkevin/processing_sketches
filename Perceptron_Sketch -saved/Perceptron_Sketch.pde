Perceptron n;

Point[] points = new Point[500];

int slope = -2, intercept = 0, epochs = 0;

float acceptableError = 0.03;

void setup() {
  size(600, 600);

  n = new Perceptron(2);

  //initializes points
  for (int i = 0; i < points.length; i++) {
    points[i] = new Point(new PVector(random(-width/2, width/2), random(-height/2, height/2)));
  }
}

void draw() {
  background(255);
  
  training();
  drawF(slope);
  drawPredictedF();
  grid();
}

void mousePressed() {
  resetPointsAndSlope();
}

void keyPressed() {
  keyPressedBinds();
}



//............................................................
//organization methods

void drawPredictedF() {
  float w0 = n.weights.get(0);
  float w1 = n.weights.get(1);
  float w2 = n.weights.get(2);

  for (int i = -width/2; i < width/2; i++) {
    strokeWeight(2);
    stroke(0);
    point(i + width/2, -(w2/w1)-(w0/w1)*i+height/2);
  }
}

ArrayList generateTrainingData() {
  ArrayList<TrainingData> trainingDataSet = new ArrayList<TrainingData>();

  for (Point p : points) {
    int target;

    //generates training data
    if (p.pos.y >= f(p.pos.x, slope)) {
      //fill(255);
      target = 1;
    } else {
      //fill(0);
      target = -1;
    }

    trainingDataSet.add(new TrainingData(new PVector(p.pos.x, p.pos.y), target));
  }



  return trainingDataSet;
}

void grid() {
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}

float training() {
  ArrayList<TrainingData> t = new ArrayList<TrainingData>();

  t = generateTrainingData();
  float guessData = 0;
  float currentGuess = 1;

  for (TrainingData d : t) {
    //stores the position data in proper format
    float[] pos = {d.pos.x, d.pos.y};

    currentGuess = n.train(pos, d.target);



    guessData += currentGuess;

    if (currentGuess < acceptableError) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    ellipse(d.pos.x + width/2, d.pos.y + height/2, 20, 20);
  }

  return guessData /= t.size();
}

void drawF(float slope) {
  for (int i = -width/2; i < width/2; i++) {
    strokeWeight(2);
    stroke(0);
    point(i + width/2, f(i, slope)+height/2);
  }
}

void resetPointsAndSlope() {
  for (int i = 0; i < points.length; i++) {
    points[i].pos = new PVector(random(-width/2, width/2), random(-height/2, height/2));
  }
  slope = int(random(-10, 10));
  intercept = int(random(-height*3/4, height*3/4));
}

float f(float x, float slope) {
  return x*slope+intercept;
}

void keyPressedBinds() {
  if (key == 'r') {
    //resets perceptron
    setup();
  }
}
