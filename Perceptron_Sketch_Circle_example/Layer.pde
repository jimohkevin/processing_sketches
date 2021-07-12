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
      layer.add(new Perceptron(this.axions));
    }
  }
  
  ArrayList<Float> train(ArrayList<float[]> inputs, ArrayList<Integer> targets){
    ArrayList<Float> error = new ArrayList<Float>();
    
    for(int i = 0; i < inputs.size(); i++){
      error.add(layer.get(i).train(inputs.get(i), targets.get(i)));
    }
    
    return error;
  }
  
  float[] guess(ArrayList<float[]> inputs){
    float[] guesses = new float[inputs.size()];
    
    for(int i = 0; i < inputs.size(); i++){
      guesses[i] = layer.get(i).guess(inputs.get(i));
    }
    
    return guesses;
  }
  
  
}
