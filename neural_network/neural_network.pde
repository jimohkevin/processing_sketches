/*
  •Add feed forward
 •Add backpropagation
 */

import java.util.Arrays;

NeuralNetwork n;
Point trainingPt;

ArrayList<Point> points = new ArrayList<Point>();

void setup() {
  size(600, 400);

  n = new NeuralNetwork("Katherine");

  n.addLayer(6, 10);
  n.addLayer(10, 4);
  n.addLayer(4, 1);
  n.setActivation("sigmoid");



  float s = random(100, 180);
  trainingPt = new Point(new PVector(random(-width/2+s/2, width/2-s/2), random(-height/2+s/2, height/2-s/2)), s);

  float numPoints = 500;
  for (float i = -width/2; i <= width/2; i += sqrt(numPoints)) {
    for (float j = -height/2; j <= height/2; j += sqrt(numPoints)) {
      points.add(new Point(new PVector(i, j), 20));
    }
  }
}

boolean needsTraining = true;

void draw() {
  background(255);
  translate(width/2, height/2);


  for (Point p : points) {
    float[] inputs = {p.pos.x, p.pos.y, trainingPt.pos.x, trainingPt.pos.y, p.pos.x-trainingPt.pos.x, p.pos.y-trainingPt.pos.y};
    float[] targets = returnTarg(p);
    float[] guess = n.guess(inputs);

    if (needsTraining) {
      float[] error = n.train(inputs, targets);
      float error1 = error[0];

      if (error1 <= 0.03) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      p.show();

      if (guess[0] >= 0.95) {
        fill(255);
      } else {
        fill(0);
      }

      ellipse(p.pos.x, p.pos.y, p.s*0.4, p.s*0.4);

      if (error1 > 0.03)
        println(error1);
    } else {


      if (guess[0] >= 0.95) {
        fill(255);
      } else {
        fill(0);
      }

      ellipse(p.pos.x, p.pos.y, p.s*0.4, p.s*0.4);
    }



    //println(n.guess(inputs)[0]);
  }

  noFill();
  trainingPt.show();
  //trainingPt.pos = new PVector(mouseX-width/2, mouseY-height/2);
}

void keyPressed() {
  if (key == 't') {
    if (needsTraining) {
      needsTraining = false;
    } else {
      needsTraining = true;
    }
  }

  if (key == 'r') {
    points.clear();
    setup();
  }
}

float[] returnTarg(Point p) {
  float output1;

  if (dist(p.pos.x, p.pos.y, trainingPt.pos.x, trainingPt.pos.y) <= trainingPt.s/2) {
    output1 = 1;
  } else {
    output1 = 0;
  }

  float[] target = {output1};
  return target;
}
