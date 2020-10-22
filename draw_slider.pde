float[] slider_vals;
float[] slider_targets;
int[][] slider_positions;

void draw_horizontal_slider(int idx) {
  fill(0);
  noStroke();
  int x = slider_positions[idx][0];
  int y = slider_positions[idx][1];
  int w = slider_positions[idx][2];
  int h = slider_positions[idx][3];
  float t = 4;
  float xpos = x + h/2 + slider_vals[idx]*(w-h);
  
  if (mousePressed && (mouseX >= x+2*t) && (mouseX < x+w-2*t) && (mouseY >= y+2*t) && (mouseY < y+h-2*t)) {
    slider_vals[idx] = constrain(map(mouseX, x+h/2, x+w-h/2, 0., 1.), 0., 1.);
  }
  
  rect(x,y,w,h);
  fill(1., .3);
  rect(x+(h-t)/2,y+(h-t)/2,w-h+t,t,t/2);
  
  
  fill(0);
  float nj = h - 4*t;
  circle(xpos, y+h/2, nj);
  stroke(1., .3);
  strokeWeight(t);
  circle(xpos, y+h/2, nj - 3*t);
}
