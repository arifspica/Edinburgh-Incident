//class for weather buttons https://processing.org/examples/button.html
class button{
  //declares variables
  boolean overFlag = false;
  boolean swit;
  int x,y;
  int size=45;
  
  //constructor
  button(int x_, int y_){
   x=x_;
   y=y_;   
  }
  
  //class methods
  void drawButton(){    
    ellipse(x,y,size,size); 
  }
  
  boolean over(int xx, int yy, int diameter) {
    float disX = xx - mouseX;
    float disY = yy - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } else {
      return false;
    }
  }   
}

 void update(int x, int y) {
   for(int i=0;i<4;i++){
      if ( buts[i].over(buts[i].x, buts[i].y, buts[i].size) ) {
        buts[i].overFlag = true;        
      } 
   }
  
} 

//function as a swict button
void mousePressed() {  
     if (buts[0].overFlag){
        weatherFlag="Fine";
        fineswitch=true;
        rainswitch=false;
        snowswitch=false;
        fogswitch=false;
      }
      else if (buts[1].overFlag){
         weatherFlag="Rain"; 
         fineswitch=false;
        rainswitch=true;
        snowswitch=false;
        fogswitch=false;
      }
      else if (buts[2].overFlag){
         weatherFlag="Snow";
         fineswitch=false;
        rainswitch=false;
        snowswitch=true;
        fogswitch=false;
      }
      else if (buts[3].overFlag){
         weatherFlag="Fog "; 
        fineswitch=false;
        rainswitch=false;
        snowswitch=false;
        fogswitch=true;
      }
     
  
}