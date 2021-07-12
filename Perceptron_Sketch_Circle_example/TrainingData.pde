public class TrainingData {
    public PVector pos;
    public int target;
    public float dist;
    
    TrainingData(PVector pos, float dist, int target){
      this.pos = pos;
      this.target = target;
      this.dist = dist;
    }
  };
