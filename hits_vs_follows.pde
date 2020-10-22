void hits_vs_follows(int x, int y, int w, int h) {
  noStroke();
  background(#000000);
  for (int i = 0; i < st_podatkov; i++) {
    fill(colorFromRating(mean[i]));
    //fill(colorFromRating(bayesian[i]));
    circle(x + circSize + (log(views[i]) - minViews) * (w - 2 * circSize) / (maxViews - minViews),
      y + h - circSize - (log(follows[i]) - minFollows) * (h - 2 * circSize) / (maxFollows - minFollows),
      circSize);
  }
  println("Done!");
}

void hits_vs_follows_ranged(int x, int y, int w, int h, int slider_idx) {
  float range = .1;
  noStroke();
  
  fill(0.);
  rect(x,y,w,h);
  
  for (int i = 0; i < st_podatkov; i++) {
    float r = mean[i]-8*slider_vals[slider_idx]-1;
    if (abs(r) < range) {
      r /= range;
      fill(colorFromRating(mean[i]));
      //fill(colorFromRating(bayesian[i]));
      circle(x + circSize + (log(views[i]) - minViews) * (w - 2 * circSize) / (maxViews - minViews),
        y + h - circSize - (log(follows[i]) - minFollows) * (h - 2 * circSize) / (maxFollows - minFollows),
        circSize * constrain(1 - r*r, 0., 1.));
    }
  }
}

void hits_vs_follows_ranged_r_c(int x, int y, int w, int h, int rating_slider_idx, int comment_slider_idx) {
  float rating_range = .3, comment_range = 3.;
  noStroke();
  
  fill(0.);
  rect(x,y,w,h);
  
  for (int i = 0; i < st_podatkov; i++) {
    float rr = mean[i] - 8*slider_vals[rating_slider_idx] - 1;
    float rc = log_comments[i] - 8*slider_vals[comment_slider_idx] - 1;
    if (abs(rr) < rating_range && abs(rc) < comment_range) {
      rr /= rating_range;
      rc /= comment_range;
      fill(colorFromRating(mean[i]));
      //fill(colorFromRating(bayesian[i]));
      circle(x + circSize + (log(views[i]) - minViews) * (w - 2 * circSize) / (maxViews - minViews),
        y + h - circSize - (log(follows[i]) - minFollows) * (h - 2 * circSize) / (maxFollows - minFollows),
        circSize * constrain((1 - rr*rr)*(1 - rc*rc), 0., 1.));
    }
  }
}
