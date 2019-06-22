/// Double Pendulum - Tariq Saiyad ///


import controlP5.*;
ControlP5 cp5;

//gravity
float gravity=1;

//x and y offset.
float x_offset = 400;
float y_offset = 250;

//length of pendulums.
float r1 = 100;
float r2 = 100;

//mass/size of pendulum.
float mass1 = 20;
float mass2 = 10;

//angles of the pendulum.
float a1=(PI/2);
float a2=(PI/4);

//velocity of angles.
float a1_v = 0;
float a2_v = 0;

//acceleration of angles.
float a1_a=0;
float a2_a=0;


PGraphics canvas;


void setup() {
  cp5 = new ControlP5(this);
  addSliders();

  size(800, 800);

  canvas = createGraphics(800, 800);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}

void draw() {
  calculateAngles();

  //background(55);
  image(canvas, 0, 0);
  stroke(255);
  strokeWeight(2);
  // translate(400, 250);

  //calculate lines for pendulum.
  float x1 = r1*sin(a1);
  float y1 = r1*cos(a1);

  float x2 =x1+ r2*sin(a2);
  float y2 = y1+ r2*cos(a2);

  //draw the lines and pendulum.

  line(x_offset, y_offset, x1+x_offset, y1+y_offset);
  fill(255);
  ellipse(x1+x_offset, y1+y_offset, mass1, mass1);

  line(x1+x_offset, y1+y_offset, x2+x_offset, y2+y_offset);
  fill(255);
  ellipse(x2+x_offset, y2+y_offset, mass2, mass2);

  //change velocity by acceleration.
  a1_v += a1_a;
  a2_v+= a2_a;


  //change angles by velocity.
  a1+=a1_v;
  a2+=a2_v;
  
  //add dampening.
  a1_v *= (0.999);
  a2_v *= (0.999);
  



  //draw the trail lines left behind by the pendulum.
  float r = map(a1,-PI/2,PI/2, 0,255);
  float g = map(a2,-PI/2,PI/2, 0,255);

  
  canvas.beginDraw();
  canvas.translate(400, 250);
  canvas.strokeWeight(4);
  canvas.stroke(r+25,g+25,0);
  canvas.point(x2, y2);
  canvas.endDraw();
}


// this method will use the double pendulum formalae to calculate the angles.
void calculateAngles() {

  //angle 1.
  float num1 = -gravity*(2* mass1+mass2)*sin(a1);
  float num2=-mass2*gravity*sin(a1-2*a2);
  float num3=-2*sin(a1-a2)*mass2;
  float num4 = a2_v*a2_v*r2 + a1_v * a1_v*r1*cos(a1-a2);

  float den = r1*(2*mass1+mass2-mass2*cos(2*a1-2*a2));

  a1_a = (num1 + num2+num3*num4)/den;

  //angle 2.


  num1= 2*sin(a1-a2);
  num2 = (a1_v*a1_v*r1* (mass1+mass2));
  num3 = gravity*(mass1+mass2)*cos(a1);
  num4= a2_v*a2_v*r2*mass2*cos(a1-a2);

  den = r2*(2*mass1+mass2-mass2*cos(2*a1-2*a2));



  a2_a=(num1*(num2+num3+num4) )/ den;
}


void addSliders(){
  

  // add a vertical slider
  cp5.addSlider("mass1")
    .setPosition(10, 25)
    .setRange(10, 100).setWidth(200)
    .setValue(20);

  // reposition the Label for controller 'slider'
  cp5.getController("mass1").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("mass1").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);


  cp5.addSlider("mass2")
    .setPosition(10, 50)
    .setRange(10, 100)
    .setWidth(200)
    .setValue(15);

  // reposition the Label for controller 'slider'
  cp5.getController("mass2").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("mass2").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);


  cp5.addSlider("r1")
    .setPosition(10, 75)
    .setRange(10, 200)
    .setWidth(200)
    .setValue(100);

  // reposition the Label for controller 'slider'
  cp5.getController("r1").setLabel("Length 1");
  // reposition the Label for controller 'slider'
  cp5.getController("r1").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("r1").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);



  cp5.addSlider("r2")
    .setPosition(10, 100)
    .setRange(10, 200)
    .setWidth(200)
    .setValue(120);

  // reposition the Label for controller 'slider'
  cp5.getController("r2").setLabel("Length 2");
  // reposition the Label for controller 'slider'
  cp5.getController("r2").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("r2").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);



  // add a vertical slider
  cp5.addSlider("gravity")
    .setPosition(10, 125)
    .setRange(0, 10)
    .setWidth(200)
    .setValue(1);

  // reposition the Label for controller 'slider'
  cp5.getController("gravity").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("gravity").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}
