public class Layer {
  int numNodes, axions;
  ArrayList<Perceptron> layer = new ArrayList<Perceptron>();
  
  public Layer(int numNodes, int axions){
    //number of nodes equals number of inputs
    this.numNodes = numNodes;
    this.axions = axions;
    
    this.init();
  }
  
  void init(){
    for(int i = 0; i < this.numNodes; i++){
      this.layer.add(new Perceptron(this.axions));
    }
  }
  
  float train(float[] inputs, int target){
    float error = 0;
    
    for(int i = 0; i < this.layer.size(); i++){
      error += this.layer.get(i).train(inputs, target);
    }
    
    error /= this.layer.size();
    
    return error;
  }
  
  float[] guess(float[] inputs){
    float[] guesses = new float[inputs.length];
    
    for(int i = 0; i < this.layer.size(); i++){
      guesses[i] = this.layer.get(i).guess(inputs);
    }
    
    return guesses;
  }
  
  void setActivation(String type){
    for(int i = 0; i < this.layer.size(); i++){
      this.layer.get(i).activationType = type;
    }
  }
}
