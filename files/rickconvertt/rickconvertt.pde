import processing.video.*;

Movie movie;
PrintWriter output;

String movie_path = "rick_low_v2.mp4";
String output_path = "rick_1bit_v3.bin";

int size_x = 40;
int size_y = 30;
int scale = 1;
int fps = 25; // setting this over the video fps will just do normal speed video, but faster
float length_sec = 0; 

byte[] to_write = {};
String bytes_to_convert = "";
float threshold = .5;

boolean exit = false;

void settings() {
  size(size_x*scale, size_y*scale);
}

void setup() {
  movie = new Movie(this, movie_path);
  movie.frameRate(fps);
  frameRate(fps);
  movie.play();
  
  length_sec = movie.duration();
}

void movieEvent(Movie movie) {
  movie.read();
}

void draw() {
  if (exit || movie.time() > length_sec) {
    print(to_write[243]);
    saveBytes(output_path, to_write);
    exit();
  }
  
  image(movie, 0, 0);
  
  for (int y=0; y<30; y++) {
    for (int x=0; x<40; x++) {
      float value = 1 - brightness(get(x, y)) / 255; // all values 255 means black, all 0 white -> 1-x
      
      boolean white = false;
      
      if (value < threshold) {
        white = false;
      } else {
        white = true;
      }
      
      set(x, y, color((1-int(white))*255));
      
      bytes_to_convert += str(int(!white));
      
      if (bytes_to_convert.length() >= 8) {
        println(byte(unbinary(bytes_to_convert)));
        to_write = append(to_write, byte(unbinary(bytes_to_convert)));
        bytes_to_convert = "";
      }
    }
  }
}

void keyPressed() {
  if (key == ENTER) {
    exit = true;
  }
}

void stop() {
  print(to_write[243]);
  saveBytes(output_path, to_write);
  exit();
}
