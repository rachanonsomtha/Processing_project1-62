class Truck {

  float x_orig, y_orig, x_dest, y_dest;

  Truck (float _x_orig, float _y_orig, float _x_dest, float _y_dest) {
    x_orig = _x_orig;
    y_orig = _y_orig;
    x_dest = _x_dest;
    y_dest = _y_dest;
  }


  float vx, vy;
  float x, y;

  void display() {

    fill(255, 255, 50, 200);
    stroke(255, 0, 255);
    strokeWeight(0.3);
    //line(x_orig, y_orig, x_dest, y_dest);

    ellipse(x_orig, y_orig, 2*zoom, 2*zoom);
    fill(255, 0, 255, 200); 

    ellipse(x_dest, y_dest, 2*zoom, 2*zoom);
  }

  void update () {

    x_orig+= 1 ;
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
