
color colorFromRating(float rating) {
  return color(0.08 * rating + 0.1, .6, 1., 0.8);
  // return color(0, 1., 1., 0.2);
}

int st_podatkov;
float circSize = 10.;

int[] idx;
float[] views;
float[] log_views;
float[] mean;
float[] bayesian;
int[] ratings;
int[] follows;
float[] log_follows;
int[] manga_comments;
int[] chapter_comments;
int[] total_comments;
float[] log_comments;

float maxViews;
float minViews;
float maxFollows;
float minFollows;
float maxRating;
float minRating;
float maxComments;
float minComments;

void setup() {
  size(1000, 1120);
  surface.setLocation(100, 200);
  colorMode(HSB, 1.);
  background(0.);
  
  // Table podatki = loadTable("scrape-no_0_fol.csv", "header");
  Table podatki = loadTable("scrape-min_10_ratings.csv", "header");
  st_podatkov = podatki.getRowCount();
  
  println("Podatkov: " + st_podatkov);
  
  idx = new int[st_podatkov];
  views = new float[st_podatkov];
  log_views = new float[st_podatkov];
  mean = new float[st_podatkov];
  bayesian = new float[st_podatkov];
  ratings = new int[st_podatkov];
  follows = new int[st_podatkov];
  log_follows = new float[st_podatkov];
  manga_comments = new int[st_podatkov];
  chapter_comments = new int[st_podatkov];
  total_comments = new int[st_podatkov];
  log_comments = new float[st_podatkov];
  
  for (int i = 0; i < st_podatkov; i++) {
    idx[i] = podatki.getInt(i,"id");
    views[i] = podatki.getLong(i,"views");
    log_views[i] = log(views[i]);
    mean[i] = podatki.getFloat(i,"mean_rating");
    bayesian[i] = podatki.getFloat(i,"bayesian_rating");
    ratings[i] = podatki.getInt(i,"ratings");
    follows[i] = podatki.getInt(i,"follows");
    log_follows[i] = log(follows[i]);
    manga_comments[i] = podatki.getInt(i,"manga_comments");
    chapter_comments[i] = podatki.getInt(i,"chapter_comments");
    total_comments[i] = manga_comments[i] + chapter_comments[i];
    log_comments[i] = max(log(total_comments[i]), 0.);
  }
  
  /*
  float maxViews = max(views);
  float minViews = min(views);
  float maxFollows = max(follows);
  float minFollows = min(follows);
  */
  maxViews = max(log_views);
  minViews = min(log_views);
  maxFollows = max(log_follows);
  minFollows = min(log_follows);
  maxRating = max(mean);
  minRating = min(mean);
  maxComments = max(log_comments);
  minComments = min(log_comments);
  
  println("minViews: " + minViews + ", maxViews: " + maxViews);
  println("minFollows: " + minFollows + ", maxFollows: " + maxFollows);
  println("minRating: " + minRating + ", maxRating: " + maxRating);
  println("minComments: " + minComments + ", maxComments: " + maxComments);
  
  //int viewless = 0;
  //int followless = 0;
  //int both = 0;
  
  //for (int i = 0; i < st_podatkov; i++) {
  //  if (views[i] == 0) {
  //    viewless++;
  //    if (follows[i] == 0) {
  //      both++;
  //    }
  //  }
  //  if (follows[i] == 0) {
  //    followless++;
  //  }
  //}
  
  //println("Viewless: " + viewless + ", followless: " + followless + ", both: " + both);
  
  slider_vals = new float[2];
  slider_vals[0] = random(0., 1.);
  slider_vals[1] = random(0., 1.);
  
  slider_positions = new int[2][4];
  // zgornji slider => ocena
  slider_positions[0][0] = 0;
  slider_positions[0][1] = height - 120;
  slider_positions[0][2] = width;
  slider_positions[0][3] = 60;
  // spodnji slider => logaritem komentarjev
  slider_positions[1][0] = 0;
  slider_positions[1][1] = height - 60;
  slider_positions[1][2] = width;
  slider_positions[1][3] = 60;
  
  println("Loaded.");
  
  // hits_vs_follows(20, 20, 960, 960);
}

void draw() {
  draw_horizontal_slider(0);
  draw_horizontal_slider(1);
  hits_vs_follows_ranged_r_c(20, 20, 960, 960, 0, 1);
  
  // println(frameRate);
}
