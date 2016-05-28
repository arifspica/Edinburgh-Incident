//class for dots, represent an accident
class Location{
  //declares variables
  float latt;
  float longt;
  String severity;
  String weather;
  String mon;
  String date;
  String day;
  float x;
  float y;
  int size; //size for the dot
  color c; //color for the dot, will be determined later based on the severity
  PImage curr;
  
  //constructor
  Location(float latt_, float longt_, String sev_, String mon_, String wea_, String day_, String date_){
   latt=latt_;
   longt=longt_;
   severity=sev_;
   mon=mon_;
   weather=wea_;
   day=day_;
   date=date_;
  }
  
  //class methods
  void drawdots(){
   //map geolocation data to the map
   x= (((longt-minx)/(maxx-minx))*1255)+50;
   y= 628 - (((latt-miny)/(maxy-miny)) * 528);
   noStroke();//turn off the stroke
   if (severity.equals("Slight")){
     curr=loadImage("icon1.png");//accident icon https://openclipart.org/image/2400px/svg_to_png/178164/free-traffic-icons.png
     size=20;
   }
   else if(severity.equals("Serious")){
     curr=loadImage("icon2.png");
     size=21;
   }
   else if(severity.equals("Fatal")){
     curr=loadImage("icon3.png");
     size=22;
   }
   else {
      
   }
        
   if (x<1305&&x>50){
     if(y<628&&y>100){       
      if (mouseX >= x-(size/2) && mouseX <= x+(size/2) && 
      mouseY >= y-(size/2) && mouseY <= y+(size/2)){
        fill (color(0));
        rect (mouseX+15, mouseY-15, (day.length()+date.length())*8,20);
        fill(color(200));        
        text(day+", "+date, mouseX+17,mouseY);//||dot[i].x-mouseX==2||mouseY-dot[i].y==2||dot[i].y-mouseY==2
        
      }
       imageMode(CENTER);
       image(curr, x,y,size,size);
     }
   }
  }
}