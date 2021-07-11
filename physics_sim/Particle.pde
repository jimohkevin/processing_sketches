public class Particle {
  PVector pos, vel, accel;
  public float xBounds[], yBounds[], zBounds[];
  float s;
  float sScaled;

  public float drag, internalResistance;

  float time = millis();

  ArrayList<PVector> positions = new ArrayList<PVector>();

  boolean zIsOn = false;

  public int trailSize = 1;

  public int id = 0;
  
  public color col = color(0);

  public Particle(PVector pos, float s) {
    this.pos = pos.copy();
    this.vel = new PVector(0, 0, 0);
    this.accel = new PVector(0, 0, 0);
    this.s = s;

    this.sScaled = s;

    this.drag = 0.95;
    this.internalResistance = 0.97;
  }

  public void update() {
    this.vel.mult(this.drag);

    this.pos.add(this.vel);
    this.vel.add(this.accel);

    this.accel.mult(0);
    this.keepInBounds();

    if (zIsOn) {
      this.sScaled = map(this.pos.z, this.zBounds[0], this.zBounds[1], 1, this.s);
    }
  }

  public void applyForce(PVector force) {
    this.accel.add(force);
  }

  public void display() {
    //ellipse(this.pos.x, this.pos.y, this.s, this.s);
    //positions.add(this.pos);

    if (this.trailSize >= 1) {
      float maxOpacityMultiplier = 2.3; //max opacity multiplier, choose number between 1 & 4. The higher, the lower the max opacity
      for (int i = 0; i < this.positions.size(); i++) {
        color cols = color(red(this.col), green(this.col), blue(this.col), map(i/sq(this.positions.size()*maxOpacityMultiplier-i), 0, 1, 1, 255));

        fill(cols);
        stroke(cols);

        ellipse(this.positions.get(i).x, this.positions.get(i).y, this.sScaled, this.sScaled);
      }

      if (this.positions.size() > this.trailSize) {
        this.positions.remove(0);
      }

      if (millis() - time >= 5) {
        this.positions.add(this.pos.copy());

        time = millis();
      }
    } else {
      color col = color(0);

      if (this.zIsOn) {
        col = color(0, map(this.pos.z, this.zBounds[0], this.zBounds[1], 1, 150));

        fill(col);
        stroke(col);
        strokeWeight(this.sScaled);
      }

      if (this.sScaled < 0){
        print(this.sScaled);
      }
      //point(this.pos.x, this.pos.y);
      ellipse(this.pos.x, this.pos.y, this.sScaled, this.sScaled);
    }
  }

  public void keepInBounds() {

    if (this.pos.x < this.xBounds[0] + this.sScaled/2) {
      this.vel.x *= -this.internalResistance;
      this.pos.x = this.xBounds[0] + this.sScaled/2;
    }

    if (this.pos.x > this.xBounds[1] - this.sScaled/2) {
      this.vel.x *= -this.internalResistance;
      this.pos.x = this.xBounds[1] - this.sScaled/2;
    }

    if (this.pos.y < this.yBounds[0] + this.sScaled/2) {
      this.vel.y *= -this.internalResistance;
      this.pos.y = yBounds[0] + this.sScaled/2;
    }

    if (this.pos.y > this.yBounds[1] - this.sScaled/2) {
      this.vel.y *= -this.internalResistance;
      this.pos.y = this.yBounds[1] - this.sScaled/2;
    }

    if (this.zIsOn) {
      if (this.pos.z < this.zBounds[0] + this.sScaled/2) {
        this.vel.z *= -this.internalResistance;
        this.pos.z = this.zBounds[0] + this.sScaled/2;
      }

      if (this.pos.z > this.zBounds[1] - this.sScaled/2) {
        this.vel.z *= -this.internalResistance;
        this.pos.z = this.zBounds[1] - this.sScaled/2;
      }
    }
  }

  public void loopBounds() {

    if (this.pos.x < this.xBounds[0] + this.sScaled/2) {

      this.pos.x = this.xBounds[1] - this.sScaled/2;
    }

    if (this.pos.x > this.xBounds[1] - this.sScaled/2) {

      this.pos.x = this.xBounds[0] + this.sScaled/2;
    }

    if (this.pos.y < this.yBounds[0] + this.sScaled/2) {

      this.pos.y = yBounds[1] - this.sScaled/2;
    }

    if (this.pos.y > this.yBounds[1] - this.sScaled/2) {

      this.pos.y = this.yBounds[0] + this.sScaled/2;
    }

    if (this.zIsOn) {
      if (this.pos.z < this.zBounds[0] + this.sScaled/2) {

        this.pos.z = this.zBounds[1] - this.sScaled/2;
      }

      if (this.pos.z > this.zBounds[1] - this.sScaled/2) {

        this.pos.z = this.zBounds[0] + this.sScaled/2;
      }
    }
  }

  public void setZ(float zBounds[]) {
    this.zBounds = zBounds;

    this.zIsOn = true;
  }
}
