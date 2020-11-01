void setup() {
  // -- Set windows size
  
  // size(1200, 850);
  size(1200, 1000);
  // size(1920, 1080);
  // surface.setLocation(50, 200);
  // fullScreen();
  
  // -- Determine background color
  
  colorMode(HSB, 1.);
  bg_color = color(0, 0, 0.1, 1);
  background(bg_color);
  
  // -- Read data in
  
  // podatki = loadTable("scrape-no_0_fol.csv", "header");
  // podatki = loadTable("scrape-min_10_ratings.csv", "header");
  podatki = loadTable("scrape-min_10_ratings_titled.csv", "header");
  st_podatkov = podatki.getRowCount();
  
  println("Podatkov: " + st_podatkov);
  
  idx = new int[st_podatkov];
  views = new float[st_podatkov];
  log_views = new float[st_podatkov];
  mean = new float[st_podatkov];
  bayesian = new float[st_podatkov];
  ratings = new int[st_podatkov];
  log_ratings = new float[st_podatkov];
  log_ratings_per_view = new float[st_podatkov];
  follows = new int[st_podatkov];
  log_follows = new float[st_podatkov];
  log_follows_per_view = new float[st_podatkov];
  manga_comments = new int[st_podatkov];
  chapter_comments = new int[st_podatkov];
  total_comments = new int[st_podatkov];
  log_comments = new float[st_podatkov];
  log_comments_per_view = new float[st_podatkov];
  
  for (int i = 0; i < st_podatkov; i++) {
    idx[i] = podatki.getInt(i,"id");
    views[i] = podatki.getLong(i,"views");
    log_views[i] = log10(views[i]);
    mean[i] = podatki.getFloat(i,"mean_rating");
    bayesian[i] = podatki.getFloat(i,"bayesian_rating");
    ratings[i] = podatki.getInt(i,"ratings");
    log_ratings[i] = log10(ratings[i]);
    log_ratings_per_view[i] = log_ratings[i] - log_views[i];
    follows[i] = podatki.getInt(i,"follows");
    log_follows[i] = log10(follows[i]);
    log_follows_per_view[i] = log_follows[i] - log_views[i];
    manga_comments[i] = podatki.getInt(i,"manga_comments");
    chapter_comments[i] = podatki.getInt(i,"chapter_comments");
    total_comments[i] = manga_comments[i] + chapter_comments[i];
    log_comments[i] = max(log10(total_comments[i]), 0.);
    log_comments_per_view[i] = log_comments[i] - log_views[i];
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
  minFollowsPV = min(log_follows_per_view);
  maxFollowsPV = max(log_follows_per_view);
  minCommentsPV = min(log_comments_per_view);
  maxCommentsPV = max(log_comments_per_view);
  minNumRatings = min(log_ratings);
  maxNumRatings = max(log_ratings);
  minNumRatingsPV = min(log_ratings_per_view);
  maxNumRatingsPV = max(log_ratings_per_view);
  
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
  
  // -- Compute structure
  
  sliderHeight = 60;
  drawPad = 50;
  canvasSize = height - 2*sliderHeight - 5;
  drawSize = canvasSize - 2*drawPad;
  descriptionWidth = width - canvasSize;
  canvasX = descriptionWidth;
  canvasY = 0;
  drawX = canvasX + drawPad;
  drawY = canvasY + drawPad;
  logoWidth = 100;
  logoPad = 10;
  textPad = 17;
  titleX = logoWidth + int(3.*logoPad);
  titleY = logoPad + (logoWidth*13)/30;
  
  scales = new float[4];
  scales[0] = minFollowsPV;
  scales[1] = maxFollowsPV;
  scales[2] = minNumRatingsPV;
  scales[3] = maxNumRatingsPV;
  
  // -- Setup sliders
  
  slider_vals = new float[3];
  slider_vals[0] = random(0., 1.);
  slider_vals[1] = random(0., 1.);
  slider_vals[2] = -1;
  
  slider_positions = new int[2][4];
  // zgornji slider => ocena
  slider_positions[0][0] = descriptionWidth;
  slider_positions[0][1] = canvasSize;
  slider_positions[0][2] = canvasSize;
  slider_positions[0][3] = sliderHeight;
  // spodnji multislider => logaritem komentarjev
  slider_positions[1][0] = descriptionWidth;
  slider_positions[1][1] = canvasSize + sliderHeight;
  slider_positions[1][2] = canvasSize;
  slider_positions[1][3] = sliderHeight;
  
  prev_mouse_pressed = false;
  prev_mouse_coords = new int[2];
  
  // -- Prepare static elements
  
  notoText = createFont("NotoSans-Regular.ttf", 16);
  notoLabels = createFont("NotoSans-Regular.ttf", 14);
  notoFootnote = createFont("NotoSans-Regular.ttf", 10);
  notoTitle = createFont("NotoSans-Bold.ttf", 35);
  logo = loadShape("MD_logo.svg");
  println(logo.width, logo.height);
  
  prepare_text_area();
  prepare_data_scales(canvasSize, canvasSize);
  prepare_background_cloud_FvRPV(drawSize, drawSize);
  
  // hits_vs_follows(drawX, drawY, drawSize, drawSize);
  // follows_vs_comments_per_view(drawX, drawY, drawSize, drawSize);
  
  println("Loaded.");
}

void draw() {
  background(bg_color);
  draw_text_area(0, 0);
  // draw_horizontal_slider(0);
  // draw_horizontal_slider_rainbow_tag(0);
  draw_horizontal_multislider_rainbow_tags(0, 2);
  draw_horizontal_slider_exp_tag(1, minComments, maxComments);
  // draw_horizontal_slider(1);
  draw_horizontal_slider_exp_tag(1, minComments, maxComments);
  draw_data_scales(canvasX, canvasY);
  draw_bg_cloud(drawX, drawY);
  
  // hits_vs_follows_ranged(drawX,drawY, drawSize, drawSize, 0);
  // hits_vs_follows_ranged_adjustable(drawX, drawY, drawSize, drawSize, 0, 1);
  // hits_vs_follows_ranged_r_c(drawX, drawY, drawSize, drawSize, 0, 1);
  
  // follows_vs_comments_per_view_ranged(drawX, drawY, drawSize, drawSize, 0);
  // follows_vs_comments_per_view_ranged_r_c(drawX, drawY, drawSize, drawSize, 0, 1);
  // follows_vs_comments_per_view_ranged_rating_ratings(drawX, drawY, drawSize, drawSize, 0, 1);
  follows_vs_ratings_per_view__rating_comments(drawX, drawY, drawSize, drawSize, 0, 2, 1);
  
  manga_title_popup();
  
  // println(frameRate);
  // println(mouseX, mouseY);
}
