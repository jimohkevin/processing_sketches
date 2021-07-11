int counter = 0, time = 0;
ArrayList<PImage> bgs = new ArrayList<PImage>();

void setup() {
  size(1200, 800);

  bgs.add(loadImage("https://images.radio.com/aiu-media/space-775x515-1-3621e4f3-afe5-42c0-8149-f58b72568e6b.jpg"));
  

  for (PImage img : bgs) {
    img.resize(width, height);
  }
}

void draw() {
  background(bgs.get(counter));

  if (millis() - time > 5000) {
    counter++;
    time = millis();

    if (counter > bgs.size()-1) {
      counter = 0;
    }
  }
}
