Layer i, o;

ArrayList<Point> points = new ArrayList<Point>();

Point trainingPt;
int num = 500;

void setup() {
  size(600, 600);

  i = new Layer(2, 5);
  o = new Layer(1, 5);
  
  for (float i = -width/2; i < width/2; i += width/sqrt(num)) {
    for (float j = -height/2; j < height/2; j += height/sqrt(num)) {
      points.add(new Point(new PVector(i, j), random(15, 20)));
    }
  }

  float s = random(190, 250);

  trainingPt = new Point(new PVector(random(-width/2+s/2, width/2-s/2), random(-height/2+s/2, height/2-s/2)), s);
}

boolean needsTraining = true;

void draw() {
  translate(width/2, height/2);

  background(255);
  stroke(0);

  grid();

  if (needsTraining) {
    ///println(training());
    training();
  }

  noFill();
  ellipse(trainingPt.pos.x, trainingPt.pos.y, trainingPt.s, trainingPt.s);

  for (Point p : points) {
    float[] inputs = {p.pos.x, p.pos.y, dist(p.pos.x, p.pos.y, trainingPt.pos.x, trainingPt.pos.y), trainingPt.pos.x, trainingPt.pos.y};
    
    float guess = o.guess(inputs)[0];
    

    if (guess == 1) {
      fill(255);
    } else {
      fill(0);
    }

    ellipse(p.pos.x, p.pos.y, 8, 8);
  }

  trainingPt.pos.x = mouseX-width/2;
  trainingPt.pos.y = mouseY-height/2;
}

void mousePressed() {
  reset();
}

void keyPressed() {
  keyPressedBinds();
}



//............................................................
//organization methods

ArrayList generateTrainingData() {
  ArrayList<TrainingData> trainingDataSet = new ArrayList<TrainingData>();

  //for (Point p : points) {
  //  int target;

  //  //generates training data
  //  if (p.pos.y >= f(p.pos.x, slope)) {
  //    //fill(255);
  //    target = 1;
  //  } else {
  //    //fill(0);
  //    target = -1;
  //  }

  //  trainingDataSet.add(new TrainingData(new PVector(p.pos.x, p.pos.y), target));
  //}
  for (Point p : points) {
    int target;
    float dist = dist(p.pos.x, p.pos.y, trainingPt.pos.x, trainingPt.pos.y);

    //generates training data
    if (dist <= trainingPt.s/2) {
      //fill(255);
      target = 1;
    } else {
      //fill(0);
      target = -1;
    }

    trainingDataSet.add(new TrainingData(new PVector(p.pos.x, p.pos.y), dist, target));
  }


  return trainingDataSet;
}

void reset() {
  float s = random(25, 250);

  trainingPt = new Point(new PVector(random(-width/2+s/2, width/2-s/2), random(-height/2+s/2, height/2-s/2)), s);
}

void grid() {
  line(0, -height/2, 0, height/2);
  line(-width/2, 0, width/2, 0);
}

float training() {
  ArrayList<TrainingData> t = new ArrayList<TrainingData>();

  t = generateTrainingData();
  float guessData = 0;
  float currentGuess = 1;

  for (TrainingData d : t) {
    //stores the position data in proper format
    float[] inputs = {d.pos.x, d.pos.y, d.dist, trainingPt.pos.x, trainingPt.pos.y};
    
    float[] inputGuesses = i.guess(inputs);
    
    float outputError = o.train(inputs, d.target);
    float inputLayerError = i.train(inputs, d.target);
    
    currentGuess = o.guess(inputs)[0];

    guessData += currentGuess;

    if (outputError == 0) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    ellipse(d.pos.x, d.pos.y, 20, 20);
  }

  return guessData /= t.size();
}

void keyPressedBinds() {
  if (key == 'r') {
    //resets perceptron
    points.clear();
    setup();
  }

  if ( key == 't') {
    if (needsTraining) {
      needsTraining = false;
    } else {
      needsTraining = true;
    }
  }
}
