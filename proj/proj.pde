Table table;
PImage mapImg;
int zoom = 3;
float cx, cy;
float lat, lon;
float x_orig, y_orig, x_dest, y_dest, lat_orig, lon_orig, lat_dest, lon_dest;

String url;

//float c_lat = 51.213890;
//float c_lon = -102.462776;
//float c_lon_temp;

float c_lat = 53.0;
float c_lon = -113.0;
float c_lon_temp = 50;
float c_lat_temp = -99;

int count =20;

boolean _isInit = true;


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


void setup() {
  size (1024, 512);
  table = new Table();

  //if (c_lon < - width/2) {
  //  c_lon_temp += c_lon +width;
  //} else if (c_lon > width / 2) {
  //  c_lon_temp -= c_lon- width;
  //}

  //if (c_lat < - height/2) {
  //  c_lat_temp += c_lat +height;
  //} else if (c_lat > height / 2) {
  //  c_lat_temp -= c_lat- height;
  //}
  cx = mercX(c_lon_temp);
  cy = mercX(c_lat_temp);
  println("Zoom level: " + zoom + "Latitude: " + c_lat_temp + "Longitude: " + c_lon_temp);

  url ="https://api.mapbox.com/styles/v1/mapbox/dark-v9/static/"+c_lat_temp +","+c_lon_temp+"," +zoom +","+"0,0/1024x512?access_token=pk.eyJ1IjoicmFjaGFub24iLCJhIjoiY2szMm1jMWd0MGR5cjNpbm9obXI0MXN2NSJ9.X4wUXhYDgDP_Rvcf2hq7eA";
  mapImg = loadImage(url, "png");
}

//void mousePressed() {
//  zoom+=1;
//  url ="https://api.mapbox.com/styles/v1/mapbox/dark-v9/static/"+c_lat +","+c_lon_temp+"+"+"," +zoom +","+"0,0/1024x512?access_token=pk.eyJ1IjoicmFjaGFub24iLCJhIjoiY2szMm1jMWd0MGR5cjNpbm9obXI0MXN2NSJ9.X4wUXhYDgDP_Rvcf2hq7eA";
//}

void keyPressed() {

  if (key == 'r' ) {
    zoom += 1;
  }
  if (key == 'f' && zoom != 0) {
    zoom -=1;
  }
  if (key =='a') {
    c_lat_temp -=10/zoom;
  }  
  if (key =='d') {
    c_lat_temp += 10/zoom;
  }
  if (key =='w' ) {
    c_lon_temp += 10/zoom;
  }  
  if (key =='s') {
    c_lon_temp -= 10/zoom;
  }
  if (key == 'o') {
    count += 10;
  }
    if (key == 'z') {
    zoom = 1;
  }
  cx = mercX(c_lat_temp);
  cy = mercY(c_lon_temp);

  println("Zoom level: " + zoom + "Latitude: " + c_lat_temp + "Longitude: " + c_lon_temp + "Count: " +count);
  url ="https://api.mapbox.com/styles/v1/mapbox/dark-v9/static/"+c_lat_temp +","+c_lon_temp+"+"+"," +zoom +","+"0,0/1024x512?access_token=pk.eyJ1IjoicmFjaGFub24iLCJhIjoiY2szMm1jMWd0MGR5cjNpbm9obXI0MXN2NSJ9.X4wUXhYDgDP_Rvcf2hq7eA";
  mapImg = loadImage(url, "png");

  image(mapImg, 0, 0);
  //line(x_orig, y_orig, x_dest, y_dest);
}


void draw() {

  translate(width / 2, height / 2);
  imageMode(CENTER);

  table = loadTable("truck1week.csv", "header");
  if (_isInit) {
    image(mapImg, 0, 0);
  }


  //if (_isInit) {
  for (int i =0; i< count; i++) {
    //data fetching
    TableRow row = table.getRow(i);    
    String date_orig = row.getString("date_orig");
    String date_dest = row.getString("date_dest");

    String time_orig = row.getString("time_orig");
    String time_dest = row.getString("time_dest");


    //String timestamp = "2014-05-20 17:19:54.000";

    //String[] stamp_orig = match(time_orig, "^\\(d{2}):(\\d{2}):(\\d{2})");

    //int hours_orig = int(stamp_orig[1]);
    //int minutes_orig = int(stamp_orig[2]);
    //int seconds_orig = int(stamp_orig[3]);

    //float hours_stamp_orig = hours_orig*3600;
    //float minutes_stamp_orig = minutes_orig*60;      
    //float seconds_orig_orig = seconds_orig;


    //String[] stamp_dest = match(time_dest, "^\\d{4}-\\d{2}-\\d{2} \\(d{2}):(\\d{2}):(\\d{2})\\.\\d{3}$");

    //int hours_dest = int(stamp_dest[1]);
    //int minutes_dest = int(stamp_dest[2]);
    //int seconds_dest = int(stamp_dest[3]);

    //float hours_stamp_dest = hours_dest*3600;
    //float minutes_stamp_dest = minutes_dest*60;      
    //float seconds_orig_dest = seconds_dest;

    //println(hours_orig);


    //use this lat long
    lat_orig = row.getFloat("Latitude_orig");
    lat_dest = row.getFloat("Latitude_dest");

    lon_orig = row.getFloat("Longitude_orig");
    lon_dest = row.getFloat("Longitude_dest");

    x_orig = mercX(lon_orig) - cx;
    y_orig = mercY(lat_orig) - cy;


    x_dest = mercX(lon_dest) - cx;
    y_dest = mercY(lat_dest) - cy;

    if (x_orig < - width/2) {
      x_orig += width;
    } else if (x_orig > width / 2) {
      x_orig -= width;
    }

    if (x_dest < - width/2) {
      x_dest += width;
    } else if (x_dest > width / 2) {
      x_dest -= width;
    }

    //println(x, y);
    //println(time_orig);

    fill(255, 255, 50, 200);
    stroke(255, 0, 255);
    strokeWeight(0.3);
    //line(x_orig, y_orig, x_dest, y_dest);

    ellipse(x_orig, y_orig, 2*zoom, 2*zoom);
    fill(255, 0, 255, 200); 

    ellipse(x_dest, y_dest, 2*zoom, 2*zoom);
  }
  //}
}
