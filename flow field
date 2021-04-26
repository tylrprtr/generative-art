//Tyler Porter
//flow field art for the wall
//brian's idea
//thanks to brian allred and derek johnston
//also thanks to chris for existing.

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

//this is the thing that actually draws the lines
class Agent {
  PVector p, pOld;
  float stepSize, angle, strokeType;
  int selected_color;
  boolean isOutside = false;
  boolean close = false;

  Agent() {
    p = new PVector(random(0, width), random(0, height));
    //        p = new PVector(x,y);
    pOld = new PVector(p.x, p.y);
    stepSize = random(3*(width/2000), 10*(width/2000));
    selected_color = (int)(map(p.y, height, 0, 1.6, 5.4)+random(-1, 1));
  }

  void update() {
    //define color of this particular line
    switch(selected_color) {
    case 2:  
      stroke(c2); 
      break;
    case 3:  
      stroke(c3); 
      break;
    case 4:  
      stroke(c4); 
      break;
    case 5:  
      stroke(c5); 
      break;
    default: 
      stroke(c2); 
      break;
    }

    //reset z counter for use with line drawing loop
    int z_count = 0;

    //iterate through the flow field for one line
    //check to see if target point is off canvas and break
    //check the current point and 8 adjacent points in proximity array for previously
    //drawn lines. If so, set the break flag.
    //If everything's good, add the target point to the point buffer and move to the next point.
    
    for (int z = 0; z < steps; z++) {
      int test_x;
      int test_y;
      angle = noise(p.x/noiseScale, p.y/noiseScale, noiseSeed) * noiseStrength;
      p.x += cos(angle) * stepSize;
      p.y += sin(angle) * stepSize;

      test_x = (int)map(p.x, 0, width, 0, res_x);
      test_y = (int)map(p.y, 0, height, 0, res_y);
      println(test_x +" | " + test_y);

      if (p.x<0) isOutside = true;
      else if (p.x>width) isOutside = true;
      else if (p.y<0) isOutside = true;
      else if (p.y>height) isOutside = true;

      if (isOutside) {
        println("break at outside " + z);
        z_count = z;
        break;
      }

      if (prox[test_x][test_y] == true) close = true;

      if (test_x > 1 && test_y > 1) {
        if (prox[test_x-1][test_y-1] == true) close = true;
      }

      if (test_x > 1) {
        if (prox[test_x-1][test_y] == true) close = true;
      }

      if (test_x > 1 && test_y < res_y-1) {
        if (prox[test_x-1][test_y+1] == true) { 
          close = true;
        }
      }

      if (test_y > 1) {
        if (prox[test_x][test_y-1] == true) { 
          close = true;
        }
      }

      if (test_y < res_y-1) {
        if (prox[test_x][test_y+1] == true) { 
          close = true;
        }
      }

      if (test_x < res_x-1 && test_y > 1) {
        if (prox[test_x+1][test_y-1] == true) { 
          close = true;
        }
      }

      if (test_x < res_x-1) {
        if (prox[test_x+1][test_y] == true) { 
          close = true;
        }
      }

      if (test_x < res_x-1 && test_y < res_y-1) {
        if (prox[test_x+1][test_y+1] == true) { 
          close = true;
        }
      }

      if (close) {
        println("break at proximity " + z);
        z_count = z;
        break;
      }

      point_buffer_x[z]=p.x;
      point_buffer_y[z]=p.y;
    }


    //after the break flag has been set, iterate through the point buffer to draw
    //the new line. Check the points off in the proximity array by setting them to true.
    if (z_count > 3) {
      beginShape();
      for (int z=0; z<z_count; z++) {
        curveVertex(point_buffer_x[z], point_buffer_y[z]);
        int test_x = (int)map(point_buffer_x[z], 0, width, 0, res_x);
        int test_y = (int)map(point_buffer_y[z], 0, height, 0, res_y);
        prox[test_x][test_y] = true;
      }
      endShape();
    }
  }
}
