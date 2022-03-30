byte[] data;

//int pixel = 0;
int frame = 0;
int length = 5290;

int w = 40*10;
int h = 30*10;

int scale_x;
int scale_y;

int v_w = 40;
int v_h = 30;

int margin_x = 0;
int margin_y = 00;

PImage canvas = createImage(v_w, v_h, ALPHA);

void settings() {
  size(w, h);
  frameRate(25);
}

void setup() {
  data = loadBytes("rick_1bit_v3.bin");
  
  scale_x = w/v_w;
  scale_y = h/v_h;
  
  print("Length of video: ", data.length * 8 / 30 / 40, " frames. (Doesn't have to be right...)");
}


/*
void draw(){
  canvas.loadPixels();
  for (int x=0; x<v_w; x++) {
    for (int y=0; y<v_h; y++) {
      //int current_pixel = frame * v_w * v_h + pixel;
      int current_pixel = (frame * v_w * v_h) + (v_h*x + y); // i dont know why its not v_w*real_y + real_x, but it works =)
      //println(v_w*real_y + real_x, real_x, real_y);
      byte used_byte = data[current_pixel / 8];
      //println(current_pixel, used_byte);

      String used_byte_binary = binary(used_byte);

      char bit = used_byte_binary.charAt(current_pixel % 8);

      if (bit == '1') {
        canvas.pixels[x + margin_x + (y + margin_y)*width] = color(255);
      } else {
        canvas.pixels[x + margin_x + (y + margin_y)*width] = color(0);
      }
    }
  }
  canvas.updatePixels();

  frame ++;
  
  if (frame >= length) {
    frame = 0;
    print("RESET");
  }
}
*/



void draw(){
  loadPixels();
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      int real_x = floor(x / scale_x);
      int real_y = floor(y / scale_y);

      //int current_pixel = frame * v_w * v_h + pixel;
      int current_pixel = (frame * v_w * v_h) + (v_h*real_x + real_y); // i dont know why its not v_w*real_y + real_x, but it works =)
      //println(v_w*real_y + real_x, real_x, real_y);
      byte used_byte = data[current_pixel / 8];
      //println(current_pixel, used_byte);

      String used_byte_binary = binary(used_byte);

      char bit = used_byte_binary.charAt(current_pixel % 8);

      if (bit == '1') {
        pixels[x + margin_x + (y + margin_y)*width] = color(255);
      } else {
        pixels[x + margin_x + (y + margin_y)*width] = color(0);
      }

      //println(white, pixel);
      /*
      if ((real_x * real_y) % scale 
       pixel ++;
       if (pixel >= w*h) {
       pixel = 0;
       frame ++;
       }
       */
       
    }
  }
  updatePixels();

  frame ++;
  
  if (frame >= length) {
    frame = 0;
    print("RESET");
  }
}

*/
