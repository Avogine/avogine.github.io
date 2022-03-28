import processing.video.*;

Movie movie;
PrintWriter output;

float threshold = .5;

void setup() {
  movie = new Movie(this, "rick_low.mp4");
  movie.play();
  
  output = createWriter("rick_1bit.txt");
  output.print("int[][][] video = {");
}

void movieEvent(Movie movie) {
  movie.read();
}

void draw() {
  
  image(movie, 0, 0);
  
  output.print("{");
  for (int x=0; x<40; x++)
  {
    output.print("{");
    for (int y=0; y<30; y++)
    {
      float value = brightness(get(x, y)) / 255;
      boolean white = false;
      
      if (value > threshold)
      {
        white = true;
        set(x, y, color(255, 255, 255));
        output.print("1");
      } else {
        white = false;
        set(x, y, color(0, 0, 0));
        output.print("0");
      }
      
      output.print(",");
      
    }
    output.print("}");
  }
  output.print("}");
}

void keyPressed() {
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}
