public class Perceptron {
  ArrayList<Float> weights = new ArrayList<Float>();
  float learningrate = 0.01;
  int bias = 1;
  String activationType;

  //constructor
  public Perceptron(float numInputs) {
    for (int i = 0; i < numInputs; i++) {
      weights.add(random(-1, 1));
    }
    this.activationType = "posOrNeg";

    //adds the weight for the bias at the end of the list
    weights.add(random(-1, 1));
  }

  float guess(float[] inputs) {
    float sum = 0;

    for (int i = 0; i < weights.size(); i++) {

      if (i < weights.size()-1) {
        sum += inputs[i]*weights.get(i);
      } else {
        //adds the weight for the bias to the sum
        sum += weights.get(weights.size()-1);
      }
    }

    float output = activate(sum);

    return output;
  }

  //activation function
  float activate(float n) {
    float output = 0;

    if (this.activationType == "sigmoid") {
      output = 1/(1+pow(exp(1), -n));
    } else if (this.activationType == "posOrNeg") {
      if (n > 0) {
        output = 1;
      } else { 
        output = -1;
      }
    } else if (this.activationType == "discreet") {
      if (n >= 0) {
        output = 1;
      } else {
        output = 0;
      }
    }

    return output;
  }

  float[] assignError(float[] inputs, float error) {
    //this.train(inputs, error, "NN");

    float[] outputs = new float[weights.size()];
    float totalWeight = 0;

    for (int i = 0; i < weights.size(); i++) {
      totalWeight += weights.get(i);
    }
    for (int i = 0; i < weights.size(); i++) {
      outputs[i] = weights.get(i)/totalWeight*error;
    }

    return outputs;
  }


  float train(float[] inputs, float target, String use) {
    if (use == "NN") {
      float error = target;

      for (int i = 0; i < weights.size(); i++) {
        if (i < weights.size()-1) {
          weights.set(i, weights.get(i) + error*inputs[i]*learningrate);
        } else {
          weights.set(i, weights.get(i) + error*learningrate);
        }
      }

      return error;
    } else {
      float guess = guess(inputs);
      float error = target - guess;

      for (int i = 0; i < weights.size(); i++) {

        if (i < weights.size()-1) {
          weights.set(i, weights.get(i) + error*inputs[i]*learningrate);
        } else {
          weights.set(i, weights.get(i) + error*learningrate);
        }
      }

      return error;
    }
  }
}
