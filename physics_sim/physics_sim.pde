ArrayList<Particle> particles = new ArrayList<Particle>();

float xBounds[], yBounds[], zBounds[];
int s = 10;
PVector gForce;

void setup() {
  size(1000, 1000);

  xBounds = new float[]{0, width};
  yBounds = new float[]{0, height};

  //initializes particles in a grid
  for (float i = 0; i < 750; i++) {

    particles.add(new Particle(new PVector(random(s, width-s), random(s, height-s), random(-width/2+s, width/2-s)), s));
  }
  //print(particles.size());

  //configures particle settings
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).id = i;
    particles.get(i).setZ(new float[]{-width/2, width/2});
    particles.get(i).xBounds = xBounds;
    particles.get(i).yBounds = yBounds;

    particles.get(i).internalResistance = 1;
  }
}

void draw() {
  background(255);
  //noStroke();
  for (Particle particle : particles) {
    particle.update();
    particle.display();



    if (mousePressed)
      particle.applyForce(particle.pos.copy().sub(new PVector(mouseX, mouseY, 0)).normalize().mult(-0.7));

    for (Particle part2 : particles) {
      //Particle part1 = particle;

      //PVector pos1 = part1.pos.copy();
      //PVector pos2 = part2.pos.copy();

      //PVector radVec = pos1.sub(pos2); 
      //PVector radVecSQ = new PVector(radVec.x*abs(radVec.x), radVec.y*abs(radVec.y), radVec.z*abs(radVec.z));

      ////radVec.mult(10);


      //float gConstant = 1;

      //gForce = new PVector(1/radVecSQ.x, 1/radVecSQ.y, 1/radVecSQ.z);
      //gForce.mult(part1.s*gConstant);
      //gForce.normalize();

      //gForce.mult(0.01);

      if (particle.id != part2.id) {
        //part2.applyForce(gForce);
        //print(degrees(PVector.angleBetween(particle.pos, part2.pos)) + "\n");
      }
    }
  }
  //noLoop();



  //interactions between particles

  for (int i = 0; i < particles.size(); i++) {
  }
  //noLoop();






  if (keyPressed && key == 'w') {
    //resets the sketch

    particles.clear();
    setup();
  }
}
