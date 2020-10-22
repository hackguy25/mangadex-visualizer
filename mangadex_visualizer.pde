
color colorFromRating(float rating) {
  colorMode(HSB, 10.);
  return color(0.8 * rating + 1, 10., 10., 3.);
  // return color(0, 10., 10., 2.);
}

int st_podatkov;
float circSize = 2.;

int[] idx;
float[] views;
float[] mean;
float[] bayesian;
int[] ratings;
int[] follows;
int[] manga_comments;
int[] chapter_comments;

float maxViews;
float minViews;
float maxFollows;
float minFollows;
float maxRating;
float minRating;

void setup() {
  size(1000, 1000);
  surface.setLocation(100, 200);
  
  Table podatki = loadTable("scrape-no_0_fol.csv", "header");
  // Table podatki = loadTable("scrape-min_10_ratings.csv", "header");
  st_podatkov = podatki.getRowCount();
  
  println("Podatkov: " + st_podatkov);
  
  idx = new int[st_podatkov];
  views = new float[st_podatkov];
  mean = new float[st_podatkov];
  bayesian = new float[st_podatkov];
  ratings = new int[st_podatkov];
  follows = new int[st_podatkov];
  manga_comments = new int[st_podatkov];
  chapter_comments = new int[st_podatkov];
  
  for (int i = 0; i < st_podatkov; i++) {
    idx[i] = podatki.getInt(i,"id");
    views[i] = podatki.getLong(i,"views");
    mean[i] = podatki.getFloat(i,"mean_rating");
    bayesian[i] = podatki.getFloat(i,"bayesian_rating");
    ratings[i] = podatki.getInt(i,"ratings");
    follows[i] = podatki.getInt(i,"follows");
    manga_comments[i] = podatki.getInt(i,"manga_comments");
    chapter_comments[i] = podatki.getInt(i,"chapter_comments");
  }
  
  /*
  float maxViews = max(views);
  float minViews = min(views);
  float maxFollows = max(follows);
  float minFollows = min(follows);
  */
  maxViews = log(max(views));
  minViews = log(min(views));
  maxFollows = log(max(follows));
  minFollows = log(min(follows));
  maxRating = max(mean);
  minRating = min(mean);
  
  println("minViews: " + minViews + ", maxViews: " + maxViews);
  println("minFollows: " + minFollows + ", maxFollows: " + maxFollows);
  println("minRating: " + minRating + ", maxRating: " + maxRating);
  int viewless = 0;
  int followless = 0;
  int both = 0;
  
  for (int i = 0; i < st_podatkov; i++) {
    if (views[i] == 0) {
      viewless++;
      if (follows[i] == 0) {
        both++;
      }
    }
    if (follows[i] == 0) {
      followless++;
    }
  }
  
  println("Viewless: " + viewless + ", followless: " + followless + ", both: " + both);
  
  noStroke();
  background(#000000);
  for (int i = 0; i < st_podatkov; i++) {
    fill(colorFromRating(mean[i]));
    //fill(colorFromRating(bayesian[i]));
    /*circle(circSize + log(views[i] + random(-0.5, 0.5)) * (width - 2 * circSize) / maxViews,
      height - circSize - log(follows[i] + random(-0.5, 0.5)) * (height - 2 * circSize) / maxFollows,
      circSize);*/
    circle(circSize + (log(views[i]) - minViews) * (width - 2 * circSize) / (maxViews - minViews),
      height - circSize - (log(follows[i]) - minFollows) * (height - 2 * circSize) / (maxFollows - minFollows),
      circSize);
  }
  println("Done!");
}

void draw() {
  // println(frameRate);
}
