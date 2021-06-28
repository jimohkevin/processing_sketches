Neuron n;

void setup(){
  size(400,400);
  
  n = new Neuron();
  
  float[] inputs = {-1, 0.5};
  int guess = n.guess(inputs);
  
  println(guess);
  
}

void draw(){
  
  
  
  
  //quick exit shortcut
  if(keyPressed && key == 'r'){
    exit();
  }
}
