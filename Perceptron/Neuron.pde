public class Neuron{
  float [] weights = new float [2];
  
  
  //constructor
  public Neuron(){
    for(int i = 0; i < weights.length; i++){
      weights[i] = random(-1, 1);
    }
  }
  
  int guess(float[] inputs){
    float sum = 0;
    
    for(int i = 0; i < weights.length; i++){
      sum += inputs[i]*weights[i];
    }
    
    int output = activate(sum);
    
    return output;
  }
  
  //activation function
  int activate(float n){
    if(n >= 0){
      return 1;
    } else{
      
      return -1;
    }
  }
}
