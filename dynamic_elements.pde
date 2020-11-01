color colorFromRating(float rating) {
  return color(0.08 * rating + 0.1, .6, 1., 0.7);
  // return color(0, 1., 1., 0.2);
}

// -- Static displays

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

void follows_vs_comments_per_view(int x, int y, int w, int h) {
  noStroke();
  background(#000000);
  for (int i = 0; i < st_podatkov; i++) {
    fill(colorFromRating(mean[i]));
    //fill(colorFromRating(bayesian[i]));
    circle(x + circSize + (log_follows_per_view[i] - minFollowsPV) * (w - 2 * circSize) / (maxFollowsPV - minFollowsPV),
      y + h - circSize - (log_comments_per_view[i] - minCommentsPV) * (h - 2 * circSize) / (maxCommentsPV - minCommentsPV),
      circSize);
  }
  println("Done!");
}

// -- Dynamic displays

void hits_vs_follows_ranged(int x, int y, int w, int h, int slider_idx) {
  float range = .1;
  noStroke();
  
  fill(0.);
  rect(x,y,w,h);
  
  for (int i = 0; i < st_podatkov; i++) {
    float r = mean[i]-9*slider_vals[slider_idx]-0.5;
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
    float rr = mean[i] - 9*slider_vals[rating_slider_idx] - 0.5;
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

void hits_vs_follows_ranged_adjustable(int x, int y, int w, int h, int rating_slider_idx, int range_slider_idx) {
  noStroke();
  
  fill(0.);
  rect(x,y,w,h);
  
  for (int i = 0; i < st_podatkov; i++) {
    float r = mean[i]-9*slider_vals[rating_slider_idx]-0.5;
    if (abs(r) < slider_vals[range_slider_idx]) {
      r /= slider_vals[range_slider_idx];
      fill(colorFromRating(mean[i]));
      //fill(colorFromRating(bayesian[i]));
      circle(x + circSize + (log(views[i]) - minViews) * (w - 2 * circSize) / (maxViews - minViews),
        y + h - circSize - (log(follows[i]) - minFollows) * (h - 2 * circSize) / (maxFollows - minFollows),
        circSize * constrain(1 - r*r, 0., 1.));
    }
  }
}

void follows_vs_comments_per_view_ranged(int x, int y, int w, int h, int slider_idx) {
  float range = .1;
  noStroke();
  fill(0.);
  rect(x,y,w,h);
  
  for (int i = 0; i < st_podatkov; i++) {
    float r = mean[i]-9*slider_vals[slider_idx]-0.5;
    if (abs(r) < range) {
      r /= range;
      fill(colorFromRating(mean[i]));
      //fill(colorFromRating(bayesian[i]));
      circle(x + circSize + (log_follows_per_view[i] - minFollowsPV) * (w - 2 * circSize) / (maxFollowsPV - minFollowsPV),
        y + h - circSize - (log_comments_per_view[i] - minCommentsPV) * (h - 2 * circSize) / (maxCommentsPV - minCommentsPV),
        circSize);
    }
  }
}

void follows_vs_comments_per_view_ranged_r_c(int x, int y, int w, int h, int rating_slider_idx, int comment_slider_idx) {
  float rating_range = .3, comment_range = 3.;
  noStroke();
  
  for (int i = 0; i < st_podatkov; i++) {
    float rr = mean[i] - 9*slider_vals[rating_slider_idx] - 0.5;
    float rc = log_comments[i] - 8*slider_vals[comment_slider_idx] - 1;
    if (abs(rr) < rating_range && abs(rc) < comment_range) {
      rr /= rating_range;
      rc /= comment_range;
      fill(colorFromRating(mean[i]));
      //fill(colorFromRating(bayesian[i]));
      circle(x + circSize + (log_follows_per_view[i] - minFollowsPV) * (w - 2 * circSize) / (maxFollowsPV - minFollowsPV),
        y + h - circSize - (log_comments_per_view[i] - minCommentsPV) * (h - 2 * circSize) / (maxCommentsPV - minCommentsPV),
        circSize * constrain((1 - rr*rr)*(1 - rc*rc), 0., 1.));
    }
  }
}

void follows_vs_comments_per_view_ranged_rating_ratings(int x, int y, int w, int h, int rating_slider_idx, int num_ratings_slider_idx) {
  float rating_range = .3, num_range = .8;
  noStroke();
  
  for (int i = 0; i < st_podatkov; i++) {
    float rr = mean[i] - 9*slider_vals[rating_slider_idx] - 0.5;
    float rc = log_ratings[i] - (maxNumRatings - minNumRatings) * slider_vals[num_ratings_slider_idx] + minNumRatings;
    if (abs(rr) < rating_range && abs(rc) < num_range) {
      rr /= rating_range;
      rc /= num_range;
      fill(colorFromRating(mean[i]));
      //fill(colorFromRating(bayesian[i]));
      circle(x + circSize + (log_follows_per_view[i] - minFollowsPV) * (w - 2 * circSize) / (maxFollowsPV - minFollowsPV),
        y + h - circSize - (log_comments_per_view[i] - minCommentsPV) * (h - 2 * circSize) / (maxCommentsPV - minCommentsPV),
        circSize * constrain((1 - rr*rr)*(1 - rc*rc), 0., 1.));
    }
  }
}

void follows_vs_ratings_per_view__rating_comments(int x, int y, int w, int h,
  int rating_slider_idx1, int rating_slider_idx2, int num_ratings_slider_idx) {
  float rating_range = .3, comment_range = .6;
  noStroke();
  
  closestIdx = -1;
  rToClosest = Float.POSITIVE_INFINITY;
  
  for (int i = 0; i < st_podatkov; i++) {
    float rr1 = mean[i] - 9*slider_vals[rating_slider_idx1] - 0.5;
    float rr2 = mean[i] - 9*slider_vals[rating_slider_idx2] - 0.5;
    float rr = min(abs(rr1), abs(rr2));
    float rc = log_comments[i] - (maxComments - minComments) * slider_vals[num_ratings_slider_idx] + minComments;
    if (rr < rating_range && abs(rc) < comment_range) {
      rr /= rating_range;
      rc /= comment_range;
      fill(colorFromRating(mean[i]));
      //fill(colorFromRating(bayesian[i]));
      float circX = x + circSize + (log_follows_per_view[i] - minFollowsPV) * (w - 2 * circSize) / (maxFollowsPV - minFollowsPV);
      float circY = y + h - circSize - (log_ratings_per_view[i] - minNumRatingsPV) * (h - 2 * circSize) / (maxNumRatingsPV - minNumRatingsPV);
      float rToMouse = dist(mouseX, mouseY, circX, circY);
      if (rToMouse < rToClosest) {
        closestIdx = i;
        rToClosest = rToMouse;
        titlePopupX = circX;
        titlePopupY = circY;
      }
      circle(circX, circY, circSize * constrain((1 - rr*rr)*(1 - rc*rc), 0., 1.));
    }
  }
}

// -- Popups

void manga_title_popup() {
  if (mouseX >= descriptionWidth && mouseY < canvasSize && rToClosest <= circSize) {
    // println(podatki.getString(closestIdx, "title"));
    fill(bg_color);
    textFont(notoLabels);
    textAlign(RIGHT, CENTER);
    String s = podatki.getString(closestIdx, "title");
    float sw = textWidth(s);
    rect(titlePopupX - circSize - sw - 4, titlePopupY - 12, sw + 8, 22, 3);
    fill(1., .6);
    text(s, titlePopupX - circSize, titlePopupY - 3.5);
  }
}
