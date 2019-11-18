import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;
import java.util.List;


Table table;
PImage mapImg;
PFont f;
int fontSize = 40;

int zoom = 3;
float cx, cy;
float lat, lon;
float x_orig, y_orig, x_dest, y_dest, lat_orig, lon_orig, lat_dest, lon_dest;
int count = 50;

int screenW = 1024;
int screenH = 512;


int sec=0;
int min = 0;
int hour=0;
int date =0;
Truck [] truck = new Truck[count];

String url;


int [] min_orig = new int[count];
int [] hour_orig= new int[count];
int [] sec_orig= new int[count];

int [] min_dest= new int[count];
int [] hour_dest= new int[count];
int [] sec_dest= new int[count];

//float c_lat = 51.213890;
//float c_lon = -102.462776;
//float c_lon_temp;

//float c_lat = 53.0;
//float c_lon = -113.0;
float c_lon_temp = 53;
float c_lat_temp = -110;


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


public int _min () {
  return min;
}

public int _sec () {
  return sec;
}
public int _hour () {
  return hour;
}




void setup() {

  f = createFont("Arial", fontSize);
  //size (1024, 512);
  surface.setSize(screenW, screenH);
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

  url ="https://api.mapbox.com/styles/v1/mapbox/dark-v9/static/"+c_lat_temp +","+c_lon_temp+"," +zoom +","+"0,0/"+screenW+"x"+screenH+"?access_token=pk.eyJ1IjoicmFjaGFub24iLCJhIjoiY2szMm1jMWd0MGR5cjNpbm9obXI0MXN2NSJ9.X4wUXhYDgDP_Rvcf2hq7eA";
  mapImg = loadImage(url, "png");
  //image(mapImg, 0, 0);
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

  //count += 10;
  //SomeClass[] items = (SomeClass[]) append(originalArray, element)
  if (key == 'o') {
    //truck = (Truck[])append(truck, new Truck(x_orig, y_orig, x_dest, y_dest, zoom));
  }

  //Truck [] truck = ()

  if (key == 'z') {

    zoom = 3;
    redraw();
  }

  cx = mercX(c_lat_temp);
  cy = mercY(c_lon_temp);

  //println("Zoom level: " + zoom + "Latitude: " + c_lat_temp + "Longitude: " + c_lon_temp + "Count: " +count);
  url ="https://api.mapbox.com/styles/v1/mapbox/dark-v9/static/"+c_lat_temp +","+c_lon_temp+"+"+"," +zoom +","+"0,0/"+screenW+"x"+screenH+"?access_token=pk.eyJ1IjoicmFjaGFub24iLCJhIjoiY2szMm1jMWd0MGR5cjNpbm9obXI0MXN2NSJ9.X4wUXhYDgDP_Rvcf2hq7eA";
  mapImg = loadImage(url, "png");

  image(mapImg, 0, 0);

  for (int i =0; i< count; i++) {
    //data fetching
    //if (i <=count) {
    TableRow row = table.getRow(i);    
    String date_orig = row.getString("date_orig");
    String date_dest = row.getString("date_dest");

    String time_orig = row.getString("time_orig");
    String time_dest = row.getString("time_dest");



    //use this lat long
    lat_orig = row.getFloat("Latitude_orig");
    lat_dest = row.getFloat("Latitude_dest");

    lon_orig = row.getFloat("Longitude_orig");
    lon_dest = row.getFloat("Longitude_dest");

    cx = mercX(c_lat_temp);
    cy = mercY(c_lon_temp);
    //println(c_lat_temp);
    //println(c_lon_temp);

    x_orig = mercX(lon_orig) - cx;
    y_orig = mercY(lat_orig) - cy;


    x_dest = mercX(lon_dest) - cx;
    y_dest = mercY(lat_dest) - cy;

    truck[i] = new Truck(lat_orig, lat_dest, lon_orig, lon_dest, zoom, c_lat_temp, c_lon_temp, time_orig, hour_orig[i], min_orig[i], sec_orig[i], time_dest, hour_dest[i], min_dest[i], sec_dest[i]);

    //print("eiei");
    //println(x, y);
    //println(time_orig);
  }

  for (int i =0; i<truck.length; i++) {
    truck[i].display();
    truck[i].update();
    //print("eeeeee");
  }  
  //line(x_orig, y_orig, x_dest, y_dest);
}


void draw() {

  translate(width / 2, height / 2);
  imageMode(CENTER);

  table = loadTable("truck1week.csv", "header");

  frameRate(1);


  if (sec ==60) {
    min++;
    sec =0;
  }
  if (min==60) {
    hour++;
    min =0;
  }

  if (hour ==24) {
    date++;
    hour=0;
  }

  sec++;





  if (_isInit) {

    for (int i =0; i< count; i++) {
      //data fetching
      //if (i <=count) {
      TableRow row = table.getRow(i);    
      String date_orig = row.getString("date_orig");
      String date_dest = row.getString("date_dest");

      String time_orig = row.getString("time_orig");
      String time_dest = row.getString("time_dest");

      //String[] sa2 = append(sa1, "MA"); 

      hour_orig[i] =  int(split(time_orig, ":")[0]);
      min_orig[i] =  int(split(time_orig, ":")[1]);
      sec_orig[i] =   int(split(time_orig, ":")[2]);
      hour_dest[i] =   int(split(time_dest, ":")[0]);
      min_dest[i] =   int(split(time_dest, ":")[1]);
      sec_dest[i] =  int(split(time_dest, ":")[2]);

      //println(sec_orig[0]);


      //use this lat long
      lat_orig = row.getFloat("Latitude_orig");
      lat_dest = row.getFloat("Latitude_dest");

      lon_orig = row.getFloat("Longitude_orig");
      lon_dest = row.getFloat("Longitude_dest");

      cx = mercX(c_lat_temp);
      cy = mercY(c_lon_temp);
      //println(c_lat_temp);
      //println(c_lon_temp);

      x_orig = mercX(lon_orig) - cx;
      y_orig = mercY(lat_orig) - cy;


      x_dest = mercX(lon_dest) - cx;
      y_dest = mercY(lat_dest) - cy;

      truck[i] = new Truck(lat_orig, lat_dest, lon_orig, lon_dest, zoom, c_lat_temp, c_lon_temp, time_orig, hour_orig[i], min_orig[i], sec_orig[i], time_dest, hour_dest[i], min_dest[i], sec_dest[i]);

      //print("eiei");


      //println(x, y);
      //println(time_orig);
    }
    //println(truck);
    //image(mapImg, 0, 0);
    //println(truck.length);

    _isInit = false;
  }
  image(mapImg, 0, 0);
  //println(c_lat_temp);
  //println(c_lon_temp);
  textFont(f);
  text("Day: "+ (date +1)+"\n"+ hour+ ":" + min +":"+ sec, -500, 180);
  for (int i =0; i<truck.length; i++) {
    truck[i].display();
    truck[i].update();
    //print("eeeeee");
  }  

  //}
}
