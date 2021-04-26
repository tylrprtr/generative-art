//Tyler Porter
//art for the wall
//brian's idea

//libraries
import processing.pdf.*;

//variables
int offset_x, offset_y, num_cols, num_rows, num_steps, step_length;
float default_angle, angle, noiseSeed = 0;
boolean count = false;

int i = 0;
int resolution = 4;

int res_x = 5000;
int res_y = 5000;
boolean[][] prox = new boolean[res_x][res_y];
float[] point_buffer_x = new float[steps];
float[] point_buffer_y = new float[steps];

int steps = 100;

// path agents
int agentsCount = width*height;
Agent[] agents = new Agent[agentsCount]; // create more ... to fit max slider agentsCount
float noiseScale = 400, noiseStrength = 5; 
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 0.3;

//scheme 1 - navy - red - yellow
color c1 = #3a3042;
color c2 = #437f97;
color c3 = #ff784f;
color c4 = #ffe19c;
color c5 = #edffd9;

//scheme 2 - green - to purple
//color c5 = #73628a;
//color c4 = #cbc5ea;
//color c3 = #95bf74;
//color c2 = #556f44;
//color c1 = #283f3b;



void setup() {
  size(3600, 2400);
  smooth(16);
  background(c1);
  noFill();
  strokeWeight(5);
  strokeCap(SQUARE);
  
  //define proximity array width and height based off resolution
  res_x = (int)(width/resolution);
  res_y = (int)(height/resolution);

  println("res_x = "+ res_x +" | res_y =" + res_y);

//set all values in proximity array to false
  for (int y=0; y < res_y; y++) {
    for (int x=0; x < res_x; x++) {
      prox[x][y] = false;
    }
  }
}

void draw() {
  agents[i] = new Agent();
  agents[i].update();
}

void keyReleased() {
  if (key=='s') save("art.jpg");
  if (key=='n') {
    background(c1);
    noiseSeed = random(1, 1000);
    for (int y=0; y < res_y; y++) {
      for (int x=0; x < res_x; x++) {
        prox[x][y] = false;
      }
    }
  }
}
