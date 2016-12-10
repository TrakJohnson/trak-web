// sierpinski game, michael schultz, october 2016

// little program implementing the sierpinski game
// start with 3 points
// calc the middle point between two points
// then alway calculate the middle point between the last point and one of the three starting points
// (randomly selected)

// 1:automatic, 0: recalc after sppace
int gmode = 1;

int PS = 3;
int MAXP = 25000;
int curp = 0;

PVector gp1, gp2;
// liste of all points
PVector points[] = new PVector[MAXP];
// 3 startpunkte: p1, p2 und p3
// 
PVector p1 = new PVector(10,10);
PVector p2 = new PVector(10,610);
PVector p3 = new PVector(610,610);
PVector mvec;

void setup() {
//  createCanvas(620, 620); 
  size(620,620);
  // define first point
  points[0] = PVector.lerp(p1, p2, 0.5);
  gp1 = p1; gp2 = p2;

  curp++;
// mvec = PVector.lerp(start, end, 0.5);
  stroke(255);

}

void draw() {
  background(50);
  fill(#FFFFFF);
  text(""+curp, 550, 20);

  ellipse(p1.x, p1.y, PS, PS);
  ellipse(p2.x, p2.y, PS, PS);
  ellipse(p3.x, p3.y, PS, PS);

//  ellipse(points[curp-1].x, points[curp-1].y, PS, PS);


  for(int i = 0; i < curp; i++) {
    if (i == curp - 1) {
      fill(#FF0505);
      line(gp1.x, gp1.y, gp2.x, gp2.y);
      ellipse(gp1.x, gp1.y, 2*PS, 2*PS);
      ellipse(gp2.x, gp2.y, 2*PS, 2*PS);
      fill(#3655FF);
      ellipse(points[i].x, points[i].y, 3*PS, 3*PS);
    } else {
      fill(#FFFFFF);
//      ellipse(points[i].x, points[i].y, PS, PS);
      point(points[i].x, points[i].y);
    }

//    point(points[i].x, points[i].y);
  }
  
  if (gmode == 1) {
    calcNext();
  }
}


// berechnete den nächsten punkt als mittelpunkt zwischen dem letzten punkt
// und dem zufälligen eckpunkte

void calcNext() {
  if (curp >= MAXP) return;
  
  PVector curVec = points[curp-1];
    PVector ecke = new PVector();
    int randNo = int(random(6)) + 1;
    switch (randNo) {
      case 1: case 2:
        ecke = p1;
        break;
      case 3: case 4:
        ecke = p2;
        break;
      case 5: case 6:
        ecke = p3;
        break;
    }
    // berechne den neuen punkt als mittelpunkt des letzten punkts und der ecke
    points[curp] = PVector.lerp(curVec, ecke, 0.5);
    // speichere die beiden punkte für die visualisierung
    gp1 = curVec; gp2 = ecke;
    curp++;


}


void keyPressed() {
  if (gmode == 0) {
    if (key == ' ') {
      calcNext();
    }
  }
}