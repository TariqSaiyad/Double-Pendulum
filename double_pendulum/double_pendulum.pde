/// Double Pendulum - Tariq Saiyad ///

//gravity
float g=1;

//length of pendulums.
float r1 = 100;
float r2 = 100;

//mass/size of pendulum.
float mass1 = 20;
float mass2 = 10;

//angles of the pendulum.
float a1=(PI/2);
float a2=0;

//velocity of angles.
float a1_v = 0;
float a2_v = 0;

//acceleration of angles.
float a1_a=0;
float a2_a=0;


PGraphics canvas;


void setup() {
  size(800, 800);
  canvas = createGraphics(800, 800);
  canvas.beginDraw();
  canvas.background(155);
  canvas.endDraw();
}

void draw() {
  calculateAngles();

  //background(55);
  image(canvas, 0, 0);
  stroke(0);
  strokeWeight(2);
  translate(400, 250);

  //calculate lines for pendulum.
  float x1 = r1*sin(a1);
  float y1 = r1*cos(a1);

  float x2 =x1+ r1*sin(a2);
  float y2 = y1+ r1*cos(a2);

  //draw the lines and pendulum.
  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, mass1, mass1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, mass2, mass2);

  //change angles by velocity.
  a1+=a1_v;
  a2+=a2_v;

  //change velocity by acceleration.
  a1_v += a1_a;
  a2_v+= a2_a;


  //draw the trail lines left behind by the pendulum.
  canvas.beginDraw();
  canvas.translate(400, 250);
  canvas.strokeWeight(4);
  canvas.stroke(0);
  canvas.point(x2, y2);
  canvas.endDraw();
}


// this method will use the double pendulum formalae to calculate the angles.
void calculateAngles() {
  
  //angle 1.
  float num1 = -g*(2* mass1+mass2)*sin(a1);
  float num2=-mass2*g*sin(a1-2*a2);
  float num3=-2*sin(a1-a2)*mass2;
  float num4 = a2_v*a2_v*r2 + a1_v * a1_v*r1*cos(a1-a2);

  float den = r1*(2*mass1+mass2-mass2*cos(2*a1-2*a2));
  
  a1_a = (num1 + num2+num3*num4)/den;
  
  //angle 2.
  
  
  num1= 2*sin(a1-a2);
  num2 = (a1_v*a1_v*r1* (mass1+mass2));
  num3 = g*(mass1+mass2)*cos(a1);
  num4= a2_v*a2_v*r2*mass2*cos(a1-a2);
  
  den = r2*(2*mass1+mass2-mass2*cos(2*a1-2*a2));
  
  

  a2_a=(num1*num2+num3+num4) / den;
}
