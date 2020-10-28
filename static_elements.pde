// -- "Static" graphic elements

PGraphics bg_cloud;
PGraphics data_scales;
PGraphics text_area;

PFont notoText;
PFont notoLabels;
PFont notoTitle;
PFont notoFootnote;

PShape logo;

// -- Preparation methods

void prepare_background_cloud_FvCPV(int w, int h) {
  bg_cloud = createGraphics(w, h);
  bg_cloud.beginDraw();
  bg_cloud.noStroke();
  for (int i = 0; i < st_podatkov; i++) {
    bg_cloud.fill(color(0, 0, 1., 0.3));
    bg_cloud.circle(circSize + (log_follows_per_view[i] - minFollowsPV) * (w - 2 * circSize) / (maxFollowsPV - minFollowsPV),
      h - circSize - (log_comments_per_view[i] - minCommentsPV) * (h - 2 * circSize) / (maxCommentsPV - minCommentsPV),
      smallCircSize);
  }
  bg_cloud.endDraw();
}

void prepare_background_cloud_FvRPV(int w, int h) {
  bg_cloud = createGraphics(w, h);
  bg_cloud.beginDraw();
  bg_cloud.noStroke();
  for (int i = 0; i < st_podatkov; i++) {
    bg_cloud.fill(color(0, 0, 1., 0.15));
    bg_cloud.circle(circSize + (log_follows_per_view[i] - minFollowsPV) * (w - 2 * circSize) / (maxFollowsPV - minFollowsPV),
      h - circSize - (log_ratings_per_view[i] - minNumRatingsPV) * (h - 2 * circSize) / (maxNumRatingsPV - minNumRatingsPV),
      smallCircSize);
  }
  bg_cloud.endDraw();
}

void prepare_data_scales(int w, int h) {
  data_scales = createGraphics(w, h);
  data_scales.beginDraw();
  data_scales.noStroke();
  data_scales.fill(color(0, 0, 1., 1.));
  data_scales.textFont(notoLabels);
  
  // x scale
  data_scales.textAlign(CENTER, TOP);
  for (int i = ceil(scales[0]); i <= floor(scales[1]); i++) {
    data_scales.rect(
      circSize + drawPad + (drawSize - 2*circSize) * (i - scales[0]) / (scales[1] - scales[0]),
      h - drawPad,
      1,
      10);
    data_scales.text(
      String.format("%3.1g", pow(10, i)),
      circSize + drawPad + (drawSize - 2*circSize) * (i - scales[0]) / (scales[1] - scales[0]),
      h - drawPad + 12);
  }
  
  // y scale
  data_scales.textAlign(RIGHT, BOTTOM);
  for (int i = ceil(scales[2]); i <= floor(scales[3]); i++) {
    data_scales.rect(
      drawPad - 10,
      w - drawPad - circSize - (drawSize - 2*circSize) * (i - scales[2]) / (scales[3] - scales[2]),
      10,
      1);
    data_scales.text(
      String.format("%3.1g", pow(10, i)),
      drawPad,
      w - drawPad - circSize - (drawSize - 2*circSize) * (i - scales[2]) / (scales[3] - scales[2]) - 2);
  }
  
  data_scales.endDraw();
}

void prepare_text_area() {
  text_area = createGraphics(descriptionWidth, height);
  text_area.beginDraw();
  
  // Title
  text_area.shape(logo, logoPad, logoPad, logoWidth, logoWidth*130/150);
  text_area.textAlign(LEFT, CENTER);
  text_area.textFont(notoTitle);
  text_area.textLeading(text_area.textSize + 3);
  text_area.text("Pogovori\no stripih", titleX, titleY);
  
  // Explanation
  text_area.textAlign(LEFT, TOP);
  text_area.textFont(notoText);
  text_area.textLeading(text_area.textSize + 3);
  text_area.text(
    "Ali dobra zgodba zaneti pogovor? Iz podatkov skoraj 25 tisoč stripov azijskega porekla s portala MangaDex " +
    "smo izluščili število število ogledov, komentarjev, oznak zanimanja in ocen, poleg tega pa še povprečno oceno vsakega " +
    "stripa.\n\nVsaka pika predstavlja strip, njena koordinata x razmerje med številom oznak zanimanja in ogledi, koordinata y pa " +
    "razmerje med številom ocen in ogledi. Barva pike predstavlja povprečno oceno stripa.\n\nZgornji drsnik nastavlja prikazano " +
    "območje ocen, spodnji pa prikazano območje števila komentarjev.",
    textPad,
    logoPad + logoWidth*130/150 + textPad,
    descriptionWidth - 2*textPad,
    canvasSize);
  
  // Credits
  text_area.textAlign(LEFT, BOTTOM);
  text_area.textFont(notoFootnote);
  text_area.textLeading(text_area.textSize + 5);
  text_area.text(
    "Blaž Rojc, br4754@student.uni-lj.si, 2020\nVir podatkov: https://mangadex.org/, podatki zajeti 13. oktobra 2020.",
    textPad,
    logoPad + logoWidth*130/150 + textPad,
    descriptionWidth - 2*textPad,
    canvasSize);
  
  text_area.endDraw();
}

// -- Draw methods

void draw_bg_cloud(int x, int y) {
  tint(color(0., 0., 1., .2));
  image(bg_cloud, x, y);
  noTint();
}

void draw_data_scales(int x, int y) {
  tint(color(0., 0., 1., .6));
  image(data_scales, x, y);
  noTint();
}

void draw_text_area(int x, int y) {
  tint(color(0., 0., 1., .8));
  image(text_area, x, y);
  noTint();
}
