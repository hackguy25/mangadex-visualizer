float[] slider_vals;
float[] slider_targets;
int[][] slider_positions;
boolean prev_mouse_pressed;
int[] prev_mouse_coords;

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

void draw_horizontal_multislider_rainbow_tags(int idx1, int idx2) {
  fill(bg_color);
  noStroke();
  int x = slider_positions[idx1][0];
  int y = slider_positions[idx1][1];
  int w = slider_positions[idx1][2];
  int h = slider_positions[idx1][3];
  float t = 4;
  float nj = h - 3*t;
  float left_xpos = x + h/2 + slider_vals[idx1]*(w-h);
  float right_xpos = x + h/2 + slider_vals[idx2]*(w-h);
  
  
  if (mousePressed) {
    //if ((mouseX >= x+2*t) && (mouseX < x+w-2*t) && (mouseY >= y+2*t) && (mouseY < y+h-2*t)) {
    //  slider_vals[idx] = constrain(map(mouseX, x+h/2, x+w-h/2, 0., 1.), 0., 1.);
    //}
    if (slider_vals[idx1] >= 0 && (
      2 * dist(mouseX, mouseY, left_xpos, y + h/2) <= (nj - 3*t) ||
      2 * dist(pmouseX, pmouseY, left_xpos, y + h/2) <= (nj - 3*t))) {
      if (slider_vals[idx2] >= 0) {
        slider_vals[idx1] = constrain(map(min(mouseX, right_xpos - nj + 1), x+h/2, x+w-h/2, 0., 1.), 0., 1.);
      } else {
        slider_vals[idx1] = constrain(map(mouseX, x+h/2, x+w-h/2, 0., 1.), 0., 1.);
      }
      left_xpos = x + h/2 + slider_vals[idx1]*(w-h);
    }
    if (slider_vals[idx2] >= 0 && (
      2 * dist(mouseX, mouseY, right_xpos, y + h/2) <= nj - 3*t ||
      2 * dist(pmouseX, pmouseY, right_xpos, y + h/2) <= nj - 3*t)) {
      if (slider_vals[idx1] >= 0) {
        slider_vals[idx2] = constrain(map(max(mouseX, left_xpos + nj - 1), x+h/2, x+w-h/2, 0., 1.), 0., 1.);
      } else {
        slider_vals[idx2] = constrain(map(mouseX, x+h/2, x+w-h/2, 0., 1.), 0., 1.);
      }
      right_xpos = x + h/2 + slider_vals[idx2]*(w-h);
    }
    if (!prev_mouse_pressed) {
      prev_mouse_pressed = true;
      prev_mouse_coords[0] = mouseX;
      prev_mouse_coords[1] = mouseY;
    }
  } else {
    if (prev_mouse_pressed && mouseX == prev_mouse_coords[0] && mouseY == prev_mouse_coords[1]) {
      // miš se ni premaknila od pritiska do sprostitve => klik
      if (slider_vals[idx1] < 0) {
        if (slider_vals[idx2] < 0) {
          // no sliders => spawn left
          if ((mouseX >= x+2*t) && (mouseX < x+w-2*t) && (mouseY >= y+2*t) && (mouseY < y+h-2*t)) {
            slider_vals[idx1] = constrain(map(mouseX, x+h/2, x+w-h/2, 0., 1.), 0., 1.);
            left_xpos = x + h/2 + slider_vals[idx1]*(w-h);
          }
        } else {
          // only slider 2
          if ((mouseX >= x+2*t) && (mouseX < x+w-2*t) && (mouseY >= y+2*t) && (mouseY < y+h-2*t)) {
            if (mouseX < right_xpos - nj / 2) {
              // left of right slider => create left slider
              slider_vals[idx1] = constrain(map(min(mouseX, right_xpos - nj + 1), x+h/2, x+w-h/2, 0., 1.), 0., 1.);
              left_xpos = x + h/2 + slider_vals[idx1]*(w-h);
            } else if (mouseX > right_xpos + nj / 2){
              // right of right slider => move right slider to left, create right slider
              slider_vals[idx1] = slider_vals[idx2];
              left_xpos = right_xpos;
              slider_vals[idx2] = constrain(map(max(mouseX, left_xpos + nj - 1), x+h/2, x+w-h/2, 0., 1.), 0., 1.);
              right_xpos = x + h/2 + slider_vals[idx2]*(w-h);
            }
            // else: on right slider => do nothing
          }
        }
      } else {
        if (slider_vals[idx2] < 0) {
          // only slider 1
          if ((mouseX >= x+2*t) && (mouseX < x+w-2*t) && (mouseY >= y+2*t) && (mouseY < y+h-2*t)) {
            if (mouseX < left_xpos - nj / 2) {
              // left of left slider => move left slider to right, create left slider
              slider_vals[idx2] = slider_vals[idx1];
              right_xpos = left_xpos;
              slider_vals[idx1] = constrain(map(min(mouseX, right_xpos - nj + 1), x+h/2, x+w-h/2, 0., 1.), 0., 1.);
              left_xpos = x + h/2 + slider_vals[idx1]*(w-h);
            } else if (mouseX > left_xpos + nj / 2){
              // right of left slider => create right slider
              slider_vals[idx2] = constrain(map(max(mouseX, left_xpos + nj - 1), x+h/2, x+w-h/2, 0., 1.), 0., 1.);
              right_xpos = x + h/2 + slider_vals[idx2]*(w-h);
            }
            // else: on left slider => do nothing
          }
        } else {
          // both sliders
          if (2 * dist(mouseX, mouseY, left_xpos, y + h/2) <= nj - 3*t) {
            // delete left slider
            slider_vals[idx1] = -1;
          }
          if (2 * dist(mouseX, mouseY, right_xpos, y + h/2) <= nj - 3*t) {
            // delete right slider
            slider_vals[idx2] = -1;
          }
        }
      }
    }
    if (prev_mouse_pressed) {
      prev_mouse_pressed = false;
    }
  }
  
  
  rect(x,y,w,h);
  fill(1., .6);
  rect(x+(h-t)/2,y+(h-t)/2,w-h+t,t,t/2);
  float rating;
  
  
  // left slider
  if (slider_vals[idx1] >= 0) {
    fill(bg_color);
    circle(left_xpos, y+h/2, nj);
    rating = 9*slider_vals[idx1] + 0.5;
    stroke(color(hue(colorFromRating(rating)), .6, 1., 0.9));
    strokeWeight(t);
    circle(left_xpos, y+h/2, nj - 3*t);
    
    noStroke();
    fill(1., .6);
    textAlign(CENTER, CENTER);
    textFont(notoLabels);
    text(String.format("%.2f", rating), left_xpos+0.5, y+h/2-3);
  }
  
  
  // right slider
  if (slider_vals[idx2] >= 0) {
    fill(bg_color);
    circle(right_xpos, y+h/2, nj);
    rating = 9*slider_vals[idx2] + 0.5;
    stroke(color(hue(colorFromRating(rating)), .6, 1., 0.9));
    strokeWeight(t);
    circle(right_xpos, y+h/2, nj - 3*t);
    
    noStroke();
    fill(1., .6);
    textAlign(CENTER, CENTER);
    textFont(notoLabels);
    text(String.format("%.2f", rating), right_xpos+0.5, y+h/2-3);
  }
}
