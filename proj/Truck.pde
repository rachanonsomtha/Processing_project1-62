class Truck {

  float lat_orig, lon_orig, lat_dest, lon_dest;
  float c_lon_temp, c_lat_temp;
  int zoom;
  float vx, vy;
  float x, y;
  float cx, cy;
  String time_start;
  String time_dest;
  int sec, min, hour;
  int _sec, _min, _hour;


  Truck (float _lat_orig, float _lat_dest, float _lon_orig, float _lon_dest, int _zoom, float _c_lat_temp, float _c_lon_temp, String _time_orig
    , int hour_orig, int min_orig, int sec_orig, String _time_dest, int hour_dest, int min_dest, int sec_dest) {
    lat_orig = _lat_orig;
    lon_orig = _lon_orig;
    lat_dest = _lat_dest;
    lon_dest = _lon_dest;
    zoom = _zoom;
    c_lat_temp = _c_lat_temp;
    c_lon_temp = _c_lon_temp;
    time_start = _time_orig;
    time_dest = _time_dest;


    sec = sec_orig;
    min = min_orig;
    hour = hour_orig;

    _sec = sec_dest;
    _min = min_dest;
    _hour = hour_dest;
    //println(hour + " "+ min +" " + sec);
  }




  void display() {
    if (checkTime_orig(parseInt(split(time_start, ":")[0]), parseInt(split(time_start, ":")[1]), parseInt(split(time_start, ":")[2])
      )) {
      fill(255, 255, 50, 200);
      stroke(255, 255, 255);
      strokeWeight(5/(zoom/0.8));
      ellipse(x_orig, y_orig, 2*zoom, 2*zoom);
    }
    if (checkTime_dest(parseInt(split(time_dest, ":")[0]), parseInt(split(time_dest, ":")[1]), parseInt(split(time_dest, ":")[2]))) {
      line(x_orig, y_orig, x_dest, y_dest);
      fill(255, 0, 255, 200);  //puple
      ellipse(x_dest, y_dest, 2*zoom, 2*zoom);
    }
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


  boolean checkTime_orig (int hour, int min, int sec) {
    //String check = Integer.toString(hour)+ Integer.toString(min) + Integer.toString(sec);
    //String now = Integer.toString(_hour())+ Integer.toString(_min()) + Integer.toString(_sec());
    //println(check, now);
    int cur_hour = _hour();
    int cur_min = _min();
    int cur_sec = _sec();

    int cur_totalsec;
    int check_totalsec;

    boolean get;
    println("-----------time-----------");
    println(hour + ":" + min + ":" + sec + " " +hour + ":" + min + ":" + sec );
    //if (cur_hour >= hour || cur_min >= min || cur_sec >= sec) {
    //  return true;
    //} else {
    //  return false;
    //}

    cur_hour *=3600;
    cur_min *=60;
    cur_totalsec = cur_hour + cur_min + cur_sec;

    hour *= 3600;
    min *= 60;

    check_totalsec = hour+min+sec;

    if (cur_totalsec >= check_totalsec) {
      return true;
    } else return false;

    //if (parseInt(now) >= parseInt(check)) {
    //  return true;
    //} else {
    //  return false;
    //}
  }

  boolean checkTime_dest(int hour, int min, int sec) {
    int cur_hour = _hour();
    int cur_min = _min();
    int cur_sec = _sec();

    int cur_totalsec;
    int check_totalsec;

    cur_hour *=3600;
    cur_min *=60;
    cur_totalsec = cur_hour + cur_min + cur_sec;

    hour *= 3600;
    min *= 60;

    check_totalsec = hour+min+sec;

    if (cur_totalsec >= check_totalsec) {
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
