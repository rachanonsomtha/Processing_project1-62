class Truck {

  float lat_dest;
  float lat_orig;
  float lon_orig;
  float lon_dest;
  int zoom;
  float cx, cy;

  Truck (float _lat_orig, float _lon_orig, float _lat_dest, float _lon_dest, int _zoom, float _cx, float _cy) {

    lat_orig = _lat_orig;
    lon_orig = _lon_orig;
    lat_dest = _lat_dest;
    lon_dest = _lon_dest;
    zoom = _zoom;
    cx = _cx;
    cy = _cy;
  }


  void display() {


    x_orig = mercX(lon_orig) - cx;
    y_orig = mercY(lat_orig) - cy;


    x_dest = mercX(lon_dest) - cx;
    y_dest = mercY(lat_dest) - cy;

    fill(255, 255, 50, 200);
    stroke(255, 0, 255);
    strokeWeight(0.3);
    //line(x_orig, y_orig, x_dest, y_dest);

    ellipse(x_orig, y_orig, 2*zoom, 2*zoom);
    fill(255, 0, 255, 200); 

    ellipse(x_dest, y_dest, 2*zoom, 2*zoom);
  }
  
  //void update () {
    
  
  //}



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
