public class Perceptron {
  ArrayList<Float> weights = new ArrayList<Float>();
  float learningrate = 0.01;
  int bias = 1;

  //constructor
  public Perceptron(float numInputs) {
    for (int i = 0; i < numInputs; i++) {
      weights.add(random(-1, 1));
    }

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



    int output = activate(sum);

    return output;
  }

  //activation function
  int activate(float n) {
    if (n >= 0) {
      return 1;
    } else {

      return -1;
    }
  }

  float train(float[] inputs, int target) {
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
