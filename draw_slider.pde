float[] slider_vals;
float[] slider_targets;
int[][] slider_positions;

void draw_horizontal_slider(int idx) {
  fill(bg_color);
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
  fill(1., .6);
  rect(x+(h-t)/2,y+(h-t)/2,w-h+t,t,t/2);
  
  
  fill(bg_color);
  float nj = h - 4*t;
  circle(xpos, y+h/2, nj + t);
  stroke(1., .6);
  strokeWeight(t);
  circle(xpos, y+h/2, nj - 2*t);
}

void draw_horizontal_slider_exp_tag(int idx, float min, float max) {
  fill(bg_color);
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
  fill(1., .6);
  rect(x+(h-t)/2,y+(h-t)/2,w-h+t,t,t/2);
  
  
  fill(bg_color);
  float nj = h - 4*t;
  circle(xpos, y+h/2, nj + t);
  stroke(1., .6);
  strokeWeight(t);
  circle(xpos, y+h/2, nj - 2*t);
  
  noStroke();
  fill(1., .6);
  textAlign(CENTER, CENTER);
  int labelNum = int(pow(10, min + slider_vals[idx] * (max - min)));
  if (labelNum < 1000) {
    textFont(notoLabels);
    text(Integer.toString(int(pow(10, min + slider_vals[idx] * (max - min)))), xpos+0.3, y+h/2-2.8);
  }
  else {
    textFont(notoFootnote);
    text(Integer.toString(int(pow(10, min + slider_vals[idx] * (max - min)))), xpos, y+h/2-2);
  }
}

void draw_horizontal_slider_rainbow_tag(int idx) {
  fill(bg_color);
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
  fill(1., .6);
  rect(x+(h-t)/2,y+(h-t)/2,w-h+t,t,t/2);
  
  
  fill(bg_color);
  float nj = h - 4*t;
  circle(xpos, y+h/2, nj + t);
  float rating = 9*slider_vals[idx] + 0.5;
  stroke(color(hue(colorFromRating(rating)), .6, 1., 0.9));
  strokeWeight(t);
  circle(xpos, y+h/2, nj - 2*t);
  
  noStroke();
  fill(1., .6);
  textAlign(CENTER, CENTER);
  textFont(notoLabels);
  text(String.format("%.2f", rating), xpos+0.5, y+h/2-3);
}
