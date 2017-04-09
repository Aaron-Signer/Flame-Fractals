float curX, curY;
float Xold, Yold, r, s, C, F, theta;
float adj=0.0;
float adjtheta=0.0;
float mx = 0.5, my = .5;
float min;
fnc [] ARY = new fnc[10];
int fn = 1;
float cr, cg, cb, cr2, cg2, cb2;
int[][] H=new int[2161][1351];
int m, n;
boolean showsliders=true;
double [] temp = new double[10];

void setup() {
  size(2160, 1350);
  background(0);
  ARY[1] = new fnc(.4, .4, .5, 0, 0, color(255, 0, 0));
  ARY[2] = new fnc(.5, .5, 0, .5, 0, color(128, 0, 128));
  ARY[3] = new fnc(.5, .5, 0, .25, .5, color(0, 0, 255));
  for (int i=0; i<2161; ++i)
    for (int j=0; j<1351; ++j)
      H[i][j]=0;
}



// Move halfway from the current point to
// a randomly selected red point.
void draw() {
  fill(0); rect(0,1000,500,250);
  if (showsliders==true) {
    fill(255); 
    rect(0, 1000, 500, 50);
    fill(ARY[fn].clr); 
    rect(500*ARY[fn].r, 1000, 20, 50);
    
    fill(100); 
    rect(0, 1050, 500, 50);
    fill(ARY[fn].clr); 
    rect(500*ARY[fn].s, 1050, 20, 50);
    
    fill(150); 
    rect(0, 1100, 500, 50);
    fill(ARY[fn].clr); 
    rect(500*ARY[fn].theta, 1100, 20, 50);
    
    fill(175); 
    rect(0, 1150, 500, 50);
    fill(ARY[fn].clr); 
    rect(500*ARY[fn].C, 1150, 20, 50);
    
    fill(225); 
    rect(0, 1200, 500, 50);
    fill(ARY[fn].clr); 
    rect(500*ARY[fn].F, 1200, 20, 50);
  }
  //if (mouseY > 1000 && mouseY < 1050 && mouseX > 0 && mouseX < 500) 

  for (int i=1; i<= 300000; ++ i)
  {
    int pick = (int)random(3) + 1;
    r = ARY[pick].r;
    s = ARY[pick].s;
    theta = ARY[pick].theta;
    C = ARY[pick].C;
    F = ARY[pick].F;
    
    double modY1 = curY + .8*tan(4*curX*curX);
    temp[0] = modY1;
    double modX1 = curX + 0.8*sin(5*curY);
    temp[1] = modX1;
    
    Xold = curX;
    Yold = curY;
    //curX = r*(cos(theta))*Xold + s*sin(theta)*Yold + C;
   // curY = -r*(sin(theta))*Xold + s*cos(theta)*Yold + F;
    
    float r1 = sqrt((curX*curX) + (curY*curY));
    curX = curX*sin(r1*r1) - curY*cos(r1*r1);
    curY = curX*cos(r1*r1) + curY*sin(r1*r1);
    
    /*if(pick == 1)
      curY = curY + .8*tan(4*curX*curX);
    if(pick == 2) 
      curX = curX + 0.8*sin(5*curY);
    if(pick == 3) 
      curX = curY + 0.9*sqrt(atan(curX*curX));*/
    curX = curX + 0.3*sin(10*curY);
    m=int(500*curX + 600);
    n=int(500*curY + 600);
    if (m >= 0 && n >=0 && m <= 2160 && n <= 1350) {
      cr=red(get(int(500*curX + 600), int(500*curY + 600)));
      cg=green(get(int(500*curX + 600), int(500*curY + 600)));
      cb=blue(get(int(500*curX + 600), int(500*curY + 600)));
      cr2=red(ARY[pick].clr);
      cg2=green(ARY[pick].clr);
      cb2=blue(ARY[pick].clr);


      if (m>0&&m<2130&&n>0&&n<1350)H[m][n]++;
      set(m, n, color((H[m][n]*cr+cr2)/(H[m][n]+1), (H[m][n]*cg+cg2)/(H[m][n]+1), (H[m][n]*cb+cb2)/(H[m][n]+1)));
    }
  }

  fill(ARY[fn].clr);
  textSize(30); 
  text(fn, 100, 70); 
  text("r", 50, 100); 
  text("q=r+.05   w=r-.05", 200, 100);
  text(ARY[fn].r, 100, 100);
  text("s", 50, 130);
  text(ARY[fn].s, 100, 130);
  text("theta", 30, 160);
  text(ARY[fn].theta, 100, 160);
  text("F", 50, 190);
  text(ARY[fn].F, 100, 190);
  text("C", 50, 220);
  text(ARY[fn].C, 100, 220);
}

void mouseClicked()
{
  if (mouseY > 1000 && mouseY < 1050 && mouseX > 0 && mouseX < 500) ARY[fn].r = float(mouseX)/500.0; 
  fill(0); 
  rect(mouseX-50, 1000, 100, 50);
  if (mouseY > 1050 && mouseY < 1100 && mouseX > 0 && mouseX < 500) ARY[fn].s = float(mouseX)/500.0;
  if (mouseY > 1100 && mouseY < 1150 && mouseX > 0 && mouseX < 500) ARY[fn].theta = float(mouseX)/500.0;
  if (mouseY > 1150 && mouseY < 1200 && mouseX > 0 && mouseX < 500) ARY[fn].C = float(mouseX)/500.0;
  if (mouseY > 1200 && mouseY < 1250 && mouseX > 0 && mouseX < 500) ARY[fn].F = float(mouseX)/500.0;
  background(0);
}
void keyPressed()
{
  min=.05;
  if (key == '1') fn = 1;
  if (key == '2') fn = 2;
  if (key == '3') fn = 3;
  if (key == ' ') { saveFrame ("####.png"); println("Captured");}
  if (key == 's') showsliders = !showsliders;
  if (key == 'd') {
    println(curX);
    println(curY);
  }

  /*for (int i=0; i<2161; ++i)
    for (int j=0; j<1351; ++j)
      H[i][j]=0;*/

  //background(0);
}

class fnc {
  float r; 
  float s;
  float theta;
  float C;
  float F;
  color clr;
  //constructor
  fnc(float x1, float x2, float x3, float x4, float x5, color x6) {
    r = x1; 
    s = x2; 
    theta = x3; 
    C = x4; 
    F = x5; 
    clr = color(x6);
  }
}