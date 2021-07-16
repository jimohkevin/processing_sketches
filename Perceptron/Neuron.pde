public class Neuron{
  float [] weights;
  float learningrate = 0.0000001;
  
  
  //constructor
  public Neuron(int n){
    this.weights = new float[n];
    for(int i = 0; i < weights.length; i++){
      weights[i] = random(-1, 1);
    }
  }
  
  float guess(float[] inputs){
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
  
  float train(float[] inputs, int target){
      float guess = guess(inputs);
      float error = target - guess;
      
      for(int i = 0; i < weights.length; i++){
        weights[i] += error*inputs[i]*learningrate;
      }
      
      return error;
  }
}
