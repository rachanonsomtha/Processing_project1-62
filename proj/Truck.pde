class Truck {

  float lat_orig, lon_orig, lat_dest, lon_dest;
  float c_lon_temp, c_lat_temp;
  int zoom;
  float vx, vy;
  float x, y;
  float cx, cy;
  String time_start;

  Truck (float _lat_orig, float _lat_dest, float _lon_orig, float _lon_dest, int _zoom, float _c_lat_temp, float _c_lon_temp, String _time_orig) {
    lat_orig = _lat_orig;
    lon_orig = _lon_orig;
    lat_dest = _lat_dest;
    lon_dest = _lon_dest;
    zoom = _zoom;
    c_lat_temp = _c_lat_temp;
    c_lon_temp = _c_lon_temp;
    time_start = _time_orig;
  }




  void display() {
    //if (checkTime()) {
      fill(255, 255, 50, 200);
      stroke(255, 0, 255);
      strokeWeight(5/(zoom/0.8));
      line(x_orig, y_orig, x_dest, y_dest);

      ellipse(x_orig, y_orig, 2*zoom, 2*zoom);
      fill(255, 0, 255, 200);  //puple

      ellipse(x_dest, y_dest, 2*zoom, 2*zoom);
    //}
  }

  void update () {

    cx = mercX(c_lat_temp);
    cy = mercY(c_lon_temp);
    //println(c_lat_temp);
    //println(c_lon_temp);

    x_orig = mercX(lon_orig) - cx;
    y_orig = mercY(lat_orig) - cy;
    x_dest = mercX(lon_dest) - cx;
    y_dest = mercY(lat_dest) - cy;
  }


  boolean checkTime (double hour, double min, double sec, String checker) {
    double _hour;
    double _min;
    double _sec;

    _hour =  Double.parseDouble(split(checker, ":")[0]);
    _min =  Double.parseDouble(split(checker, ":")[1]);
    _sec =   Double.parseDouble(split(checker, ":")[2]);

    if (hour == _hour && min ==_min && sec == _sec) {
      return true;
    } else return false;
  }



  void move() {
    float dx = x_dest - x_orig;
    float dy = y_dest - y_orig;

    float d = sqrt(dx*dx + dy*dy);
    //if (d < 1) d = 1;
    float m = randomGaussian() * 16;
    float f = sin(d * 0.04) * m / d;


    vx = vx * 0.5 + f * dx;
    vy = vy * 0.5 + f * dy;

    x += vx;
    y += vy;
    fill(255, 0, 255, 200);
    ellipse(x, y, 4, 4);
  }


  float mercX(float lon) {
    lon = radians(lon);
    float a = (256 / PI) * pow(2, zoom);
    float b = lon + PI;
    return a * b;
  }

  float mercY(float lat) {
    lat = radians(lat);
    float a = (256 / PI) * pow(2, zoom);
    float b = tan(PI / 4 + lat / 2);
    float c = PI - log(b);
    return a * c;
  }
}
