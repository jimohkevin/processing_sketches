ArrayList<PImage> bgs = new ArrayList<PImage>();

ArrayList<Particle> particles = new ArrayList<Particle>();

FlowField f;

int resolution = 1000;

int counter = 0, time = 0;

boolean fieldShowing = false;



void setup() {
  size(600, 400);

  f = new FlowField(resolution);
  loadImages();

  //resizes background images to fit
  for (PImage img : bgs) {
    img.resize(width, height);
  }
}

void draw() {

  //shifts everything to near cartesian

  pushMatrix();
  translate(width/2, height/2);

  background(bgs.get(counter));

  slideShowTimer(20000);

  fill(255);
  //strokeWeight(0.5);

  if (fieldShowing) {
    //stroke(0);
    f.display();
  }

  strokeWeight(1);
  for (Particle p : particles) {
    fill(255);
    p.display();
    p.update();
    p.vel.limit(2);

    for (int i = 0; i < f.forceVectors.size(); i++) {
      ForceVector fv = f.forceVectors.get(i);
      float dist = dist(p.pos.x, p.pos.y, fv.pos.x, fv.pos.y);

      if (dist >= 1) {
        p.applyForce(fv.force.copy().div(sq(dist)).mult(2));
      }
    }
  }



  if (mousePressed) {
    int pLength = particles.size();

    particles.add(new Particle(new PVector(mouseX-width/2, mouseY-height/2), random(5, 75)));

    //settings
    particles.get(pLength).xBounds = new float []{-width/2, width/2};
    particles.get(pLength).yBounds = new float []{-height/2, height/2};
    particles.get(pLength).trailSize = 16;
    particles.get(pLength).col = color(random(110, 220), random(80, 220), random(110, 255));
    //particles.get(pLength).drag = 0.99;
  }

  popMatrix();
}

void keyPressed() {
  keysPressed();
}

void loadImages() {
  bgs.add(loadImage("https://i.pinimg.com/originals/25/dd/05/25dd05996e495781ab23252c936fa734.jpg"));
  bgs.add(loadImage("https://wallpapers.com/images/high/4k-ultra-hd-sci-fi-wallpaper-and-background-image-xt5ockd1zxbax8xp.jpg"));
  bgs.add(loadImage("https://www.cheatsheet.com/wp-content/uploads/2021/06/Rick-and-Morty-Season-4-Rick-Sanchez.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/free-download-sci-fi-countryside-painting-city-resolution-full-hd-wallpaper1617364783.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/vector-sci-fi-hd-wallpaper-and-background-image1617364753.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/dark-world-sci-fi-wallpaper-download-free-full-hd-background1617364608.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/beatiful-vintage-sci-fi-wallpaper-for-desktop1617364563.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/retro-sci-fi-battle-space-ship-wallpaper1617363724.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/nature-landscape-wallpaper-and-backgrounds1617363518.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/dark-fantasy-retro-sci-fi-wallpaper1617363472.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/cartoon-vintage-sci-fi-hd-wallpaper1617363449.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/fantastic-retro-sci-fi-artist-4k-wallpaper-image1617363424.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/movie-retro-sci-fi-wallpaper-fantasy1617363404.jpg"));
  bgs.add(loadImage("https://www.picgaga.com/uploads/wallpaper/retro-sci-fi/blue-dark-retro-sci-fi-wallpaper-for-mobile1617363348.jpg"));
}

void slideShowTimer(float sec) {
  if (millis() - time > sec) {
    counter = floor(random(bgs.size()));
    time = millis();

    if (counter > bgs.size()-1) {
      counter = 0;
    }
  }
}

void keysPressed() {
  if (key == 'r') {
    for (Particle p : particles) {
      p.pos = new PVector(random(-width/2, width/2), random(-height/2, height/2));
    }
  }
  if (key == 'f') {
    if (fieldShowing == true)
      fieldShowing = false;
    else
      fieldShowing = true;
  }

  if (key == 'c')
    particles.clear();
    
  if (key == 'u'){
    
  }
}
