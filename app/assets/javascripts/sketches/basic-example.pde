/* 
  PROCESSINGJS.COM - BASIC EXAMPLE
  Delayed Mouse Tracking  
  MIT License - Hyper-Metrix.com/F1LT3R
  Native Processing compatible 
*/  

// Global variables
float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 4;

// Setup the Processing Canvas
void setup(){
  size( $(window).width(), $(window).height() );
  strokeWeight( 10 );
  frameRate( 15 );
  X = width / 2;
  Y = width / 2;
  nX = X;
  nY = Y;
  PFont fontA = loadFont("courier");
  textFont(fontA, 14); 
}

// Main draw loop
void draw(){
  
  text("Hello Web!",20,20);

  radius = radius + sin( frameCount / 4 );
  
  // Track circle to new destination
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;
  
  // Fill canvas grey
  background( 100 );
  
  // Set fill-color to blue
  fill( 0, 121, 184 );
  
  // Set stroke-color white
  stroke(255); 
  
  // Draw circle
  ellipse( X, Y, radius, radius );                  
}


// Set circle's next destination
void mouseMoved(){
  nX = mouseX;
  nY = mouseY;  
}