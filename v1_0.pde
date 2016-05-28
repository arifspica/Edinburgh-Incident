/*
Data Visualization about Vehicle Collision in Edinburgh (Jan-Jun 2013)
as my 1st assignment in Interactive Visual Design course

--Arif Budiarto--
*/

import controlP5.*;
PImage map, fine1, rain1, snow1, fog1;
Table table;
Location[] dot;

//for mapping dots
float minx=-3.328857421875;
float maxx=-3.114795684814453;
float miny=55.92362400231917;
float maxy=55.9733179176206;

//slider
ControlP5 cp5;
int month1 = 30;
int tickmark=1000;
int tickmarkrange=55;
boolean slide=false;

String mo; //month

//severity count
int slight=0;
int serious=0;
int fatal=0;

//button weather
button[] buts;
int iconx=530;
int iconGap=70;
String weatherFlag="Fine";
boolean fineswitch=true;
boolean rainswitch;
boolean snowswitch;
boolean fogswitch;

void setup(){
  size(1355,728);
  fill(0);
  cp5 = new ControlP5(this);
  map = loadImage("map.jpg"); //load background map from cartodb.com
  //weather icon from https://rfclipart.com/hand-drawn-sketchy-weather-icons-28430-vector-clipart.html
  fine1 = loadImage("fine.png");
  rain1 = loadImage("rain.png");
  snow1 = loadImage("snow.png");
  fog1 = loadImage("fog.png");
  
  //add slider controlP5 library http://www.sojamo.de/libraries/controlP5/
  cp5.addSlider("month1")
     .setPosition(1000,668)
     .setWidth(300)
     .setHeight(10)
     .setRange(1,6) // values can range from big to small as well
     .setValue(1)
     .setNumberOfTickMarks(6)
     .setSliderMode(Slider.FLEXIBLE)
     .setLabelVisible(false)
     ;    
  
  loaddata(); 
}

void draw(){
  slight=0;serious=0;fatal=0; //reset sev count  
  background (0); //set background color to black
  color c;
  tittle();
  imageMode(CORNERS);
  image(map, 50, 100); //displays background map on the screen  
  
  tickMarkLable();//slider lable 
  monthToString();//month number to string  
  
  sevCount();//severity count function
  legend(); //legend
  weather();//weather button 
  
  //call drawdots function
  for(int i=0; i < dot.length; i++){       
    if (weatherFlag.equals("No")&&dot[i].mon.equals(mo)){
      dot[i].drawdots();      
    }
    else{
      if (dot[i].mon.equals(mo)&&dot[i].weather.substring(0,4).equals(weatherFlag)){     
        dot[i].drawdots();                  
      }    
     }    
   }  
}


//load data from file
void loaddata(){
  table = loadTable("collision.csv","header"); //load data into object called table
  dot =  new Location[table.getRowCount()]; //create array object
  for (int i = 0; i < dot.length; i++) {
    String latlong = table.getRow(i).getString("Location"); //get the location data
    float[] arlatlong = float(split(latlong,",")); //split location data into lattitude and longitude
    float latt = arlatlong[0];
    float longt = arlatlong[1];
    String sev = table.getRow(i).getString("severity");
    String mon = table.getRow(i).getString("a_date_mon");
    String wea = table.getRow(i).getString("weather");
    String day = table.getRow(i).getString("a_day");
    String date = table.getRow(i).getString("a_date");
    dot[i] = new Location(latt,longt,sev,mon,wea, day, date); // instantiate new point
    }   
}


//function to write month lable
void tickMarkLable(){
  fill(255);
  textSize(12);
  text("MONTH",1127, 650);
  text("Jan", tickmark, 698);
  text("Feb", tickmark+(tickmarkrange*1), 698);
  text("Mar", tickmark+(tickmarkrange*2), 698);
  text("Apr", tickmark+(tickmarkrange*3)+2, 698);
  text("May", tickmark+(tickmarkrange*4)+5, 698);
  text("Jun", tickmark+(tickmarkrange*5)+13, 698);
}

void monthToString(){
 
  if (month1==1){
    mo="January";
  }
  else if (month1==2){
    mo="February";
  }
  else if (month1==3){
    mo="March";
  }
  else if (month1==4){
    mo="April";
  }
  else if (month1==5){
    mo="May";
  }
  else {    
    mo="June";
  }
}

//function to count number of accidents based on severity
void sevCount(){
  for(int i=0; i < dot.length; i++){
    if (dot[i].x<1305&&dot[i].x>50){
     if(dot[i].y<628&&dot[i].y>100){
       if(weatherFlag.equals("No")){
        if (dot[i].mon.equals(mo)&&dot[i].severity.equals("Slight")){
          slight++;
        }
        else if (dot[i].mon.equals(mo)&&dot[i].severity.equals("Serious")){
          serious++;
        }
        else if (dot[i].mon.equals(mo)&&dot[i].severity.equals("Fatal")){
          fatal++;
        }
       }
       else{
         if (dot[i].mon.equals(mo)&&dot[i].severity.equals("Slight")&&dot[i].weather.substring(0,4).equals(weatherFlag)){
          slight++;
        }
        else if (dot[i].mon.equals(mo)&&dot[i].severity.equals("Serious")&&dot[i].weather.substring(0,4).equals(weatherFlag)){
          serious++;
        }
        else if (dot[i].mon.equals(mo)&&dot[i].severity.equals("Fatal")&&dot[i].weather.substring(0,4).equals(weatherFlag)){
          fatal++;
        }
       }
     }
    }
  }
}

//function to make a tittle
void tittle(){
  textSize(25);
  fill(255);
  text("VEHICLE COLLISIONS IN EDINBURGH",470,50);
  text("JANUARY - JUNE 2013",540,80);
  textSize(8);
 text("Arif Budiarto © 2015", 1110,720);
 
}

//function to make legend (information about number of accidents)
void legend(){    
  String s="s";
  textSize(12);
  fill (255);
  text("Vehicle Collisions during "+mo+" 2013", 55, 650);
  
  fill(200,200,200);
  ellipse (55,665,5,5);
  fill (255);
  if (slight<=1){
    s=".";
  }
  else s="s.";
  text("Slight impact: "+slight+" accident"+s, 65, 670);
  
  fill(240,255,0);
  ellipse (55,685,7,7);
  fill (255);
  if (serious<=1){
    s=".";
  }
  else s="s.";
  text("Serious impact: "+serious+" accident"+s, 65, 690);
  
  fill(255,0,0);
  ellipse (55,705,9,9);
  fill (255);
  if (fatal<=1){
    s=".";
  }
  else s="s.";
  text("Fatal impact: "+fatal+" accident"+s, 65, 710);
}


//function to display weather buttons
void weather(){  
  buts=new button[4];
  for (int i=0;i<4;i++){
    buts[i]=new button(550+(iconGap*i),680);   
  }
  update (mouseX, mouseY);
   //for (int i=0;i<4;i++){    
    if(fineswitch){     
      fill(color(250));
    }
    else {
      fill(color(100)); 
    }    
    buts[0].drawButton();    
    
    if(rainswitch){     
      fill(color(250));
    }
    else {
      fill(color(100)); 
    }    
    buts[1].drawButton();    
    
    if(snowswitch){ 
      fill(color(250));
    }
    else {
      fill(color(100)); 
    }    
    buts[2].drawButton();    
    
    if(fogswitch){  
      fill(color(250));
    }
    else {
      fill(color(100)); 
    }    
    buts[3].drawButton();    
   
  fill(255);
  textSize(12);
  text("WEATHER", 625,650); 
  image(fine1, iconx,668); 
  image(rain1, iconx+iconGap,665);
  image(snow1, iconx+(iconGap*2),665);  
  image(fog1, (iconx+iconGap*3),669);
  text("Fine", iconx+8,715);
  text("Rain", iconx+iconGap+8,715);
  text("Snow", iconx+(iconGap*2)+5,715);
  text("Fog", (iconx+iconGap*3)+11,715);
}