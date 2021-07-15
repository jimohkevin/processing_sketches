public class NeuralNetwork {
  public ArrayList<Layer> layers = new ArrayList<Layer>();
  public String name;

  public NeuralNetwork(String name) {
    this.name = name;
    String startMsg = "Neural Network %s has been initialized!";

    println(String.format(startMsg, this.name));
  }

  public void addLayer(int axions, int numNodes) {
    //adds layer. The order matters
    if (layers.size() != 0) {
      if (axions == layers.get(layers.size()-1).layer.size()) {
        layers.add(new Layer(numNodes, axions));
      } else {
        println("Error: New layers need the same number of axions as the number of nodes in the previous layer.");
      }
    } else {
      layers.add(new Layer(numNodes, axions));
    }
  }

  public float[] guess(float[] inputs) {
    float[] latest = inputs;

    for (int i = 0; i < layers.size(); i++) {
      latest = layers.get(i).guess(latest);
    }

    return latest;
  }

  public void setActivation(String type) {
    for (Layer l : this.layers) {
      l.setActivation(type);
    }
  }



  public float[] train(float[] inputs, float[] target) {
    float[] guesses = this.guess(inputs);

    float[] error = new float[target.length];


    if (target.length == guesses.length) {
      for (int i = 0; i < guesses.length; i++) {
        error[i] = target[i] - guesses[i];
      }
    } else {
      println("Error: The number of targets must match the number of output nodes in the output layer");
    }

    float[][] errorStorage = new float[15][50];

    for (int i = this.layers.size()-1; i >= 0; i--) {
      //errorStorage = new float[this.layers.size()][];

      for (int j = 0; j < this.layers.get(i).layer.size(); j++) {
        //errorStorage[this.layers.size()-1-i] = new float[this.layers.get(i).layer.size()];

        errorStorage[this.layers.size()-1-i][j] = 0;
      }
    }

    for (int i = this.layers.size()-1; i >= 0; i--) {

      for (int j = 0; j < this.layers.get(i).layer.size(); j++) {
        Perceptron p = this.layers.get(i).layer.get(j);
        float[] perceptronErrors;

        if (i == this.layers.size()-1) {
          errorStorage[i][j] = error[j];
          perceptronErrors = p.assignError(inputs, error[j]);
        } else {
          perceptronErrors = p.assignError(inputs, errorStorage[i][j]);
        }

        for (int k = 0; k < perceptronErrors.length; k++) {
          if (i >= 1) {
            errorStorage[i-1][k] += perceptronErrors[k];
          }
        }
      }
    }

    float[] latest = inputs;
    for (int i = 0; i < this.layers.size(); i++) {


      for (int j = 0; j < this.layers.get(i).layer.size(); j++) {
        Perceptron p = this.layers.get(i).layer.get(j);

        p.train(latest, errorStorage[i][j], "NN");
        
      }
      latest = layers.get(i).guess(latest);
    }


    return error;
  }
}
