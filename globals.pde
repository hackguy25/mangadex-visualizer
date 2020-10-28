Table podatki;

int st_podatkov;
float circSize = 15.;
float smallCircSize = 4.;

int[] idx;
float[] views;
float[] log_views;
float[] mean;
float[] bayesian;
int[] ratings;
float[] log_ratings;
float[] log_ratings_per_view;
int[] follows;
float[] log_follows;
float[] log_follows_per_view;
int[] manga_comments;
int[] chapter_comments;
int[] total_comments;
float[] log_comments;
float[] log_comments_per_view;

float maxViews;
float minViews;
float maxFollows;
float minFollows;
float maxRating;
float minRating;
float maxComments;
float minComments;
float minFollowsPV;
float maxFollowsPV;
float minCommentsPV;
float maxCommentsPV;
float minNumRatings;
float maxNumRatings;
float minNumRatingsPV;
float maxNumRatingsPV;


int sliderHeight;
int canvasSize;
int canvasX;
int canvasY;
int drawPad;
int drawSize;
int drawX;
int drawY;
int descriptionWidth;
int logoWidth;
int logoPad;
int titleX;
int titleY;
int textPad;
float[] scales;

color bg_color;

float log10(float x) {
  return log(x) / log(10);
}

int closestIdx;
float rToClosest;
float titlePopupX;
float titlePopupY;
