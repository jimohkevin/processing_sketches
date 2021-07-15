public class Matrix {
  public float[][] data;
  int rows, columns;

  public Matrix(int rows, int columns) {
    data = new float[rows][columns];

    this.rows = rows;
    this.columns = columns;

    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.columns; j++) {
        data[i][j] = 0;
      }
    }
  }

  public void randomize(float min, float max) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.columns; j++) {
        data[i][j] = round(random(min, max));
      }
    }
  }

  public Matrix mult(float val) {
    Matrix temp = new Matrix(this.rows, this.columns);
    temp.setData(this.data);
    
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.columns; j++) {
        temp.data[i][j] *= val;
      }
    }
    
    return temp;
  }

  public Matrix mult(Matrix m2) {
    Matrix temp = new Matrix(this.rows, this.columns);
    temp.setData(this.data);
    
    for (int i = 0; i < m2.columns; i++) {
      for (int j = 0; j < m2.rows; j++) {
        temp.data[i][j] *= m2.data[i][j];
      }
    }
    
    return temp;
  }

  public Matrix add(float val) {
    Matrix temp = new Matrix(this.rows, this.columns);
    temp.setData(this.data);
    
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.columns; j++) {
        temp.data[i][j] += val;
      }
    }
    
    return temp;
  }

  public Matrix add(Matrix m2) {
    Matrix temp = new Matrix(this.rows, this.columns);
    temp.setData(this.data);
    
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.columns; j++) {
        temp.data[i][j] += m2.data[i][j];
      }
    }
    
    return temp;
  }
  public Matrix dot(Matrix m2) {
    Matrix temp = new Matrix(this.rows, m2.columns);

    for (int i = 0; i < temp.rows; i++) {
      for (int j = 0; j < temp.columns; j++) {
        float indexVal = 0;

        for (int k = 0; k < this.columns; k++) {
          indexVal += this.data[i][k]*m2.data[k][j];
        }

        temp.data[i][j] = indexVal;
      }
    }

    return temp;
  }

  public Matrix transpose() {
    Matrix temp = new Matrix(this.columns, this.rows);

    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.columns; j++) {
        temp.data[j][i] = this.data[i][j];
      }
    }

    return temp;
  }

  public void setData(float[][] d) {
    if (d.length == this.rows && d[0].length == this.columns) {
      this.data = d;
    } else {
      println("Error: rows and columns size not equal");
    }
  }
  
  public void print() {
    Matrix m = this;
    for (int i = 0; i < m.rows; i++) {
      String msg = "";

      for (int j = 0; j < m.columns; j++) {
        msg += m.data[i][j];
        msg += " ";
      }
      println(msg);
    }
  }
}
