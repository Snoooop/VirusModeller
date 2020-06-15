class person { //fields for person //<>// //<>//
  int s, x, y, xSpeed, ySpeed;
  int mobility, health;
}

class region { //fields for region
  int s, x, y;
  String name;
  person[]population;
}

person [] travellers=new person[0]; //creating array of persons called travellers
region [] regions = new region[9];  //creating array of regions called regions

void setup() {   
  size(900, 900);
  noStroke();
  makeRegions();
}

void draw() {
  background(225);
  drawRegions();
  regionPeople();
  regionSelection();
  // fill(200, 100);
  // rect(50, 100, 200, 100, 10);

  fill(255, 0, 0);
  text(frameRate, 100, 100);
}

void makeRegions() { //gives regions and people in regions (regions popluation) properties
  for (int i=0; i<regions.length; i=i+1) {
    regions[i]=new region();
    regions[i].s=int(width/int(sqrt(regions.length)));
    regions[i].x=int(i%int(sqrt(regions.length))*width/sqrt(regions.length)+regions[i].s/2);
    regions[i].y=int(i/int(sqrt(regions.length))*width/sqrt(regions.length)+regions[i].s/2);  
    regions[i].population=new person [int(random(300)+100)];
    for (int j=0; j<regions[i].population.length; j=j+1) {
      regions[i].population[j]=new person();
      regions[i].population[j].x = int(regions[i].x+random(-regions[i].s/4, regions[i].s/4));
      regions[i].population[j].y = int(regions[i].y+random(-regions[i].s/4, regions[i].s/4));
      regions[i].population[j].s = int(random(7))+5;
      regions[i].population[j].xSpeed = int(random(-2, 2));
      regions[i].population[j].ySpeed = int(random(-2, 2));
      regions[i].population[j].mobility = int(random(50));
      regions[i].population[j].health = int(random(80));
    }
  }
}

void regionPeople() { //moves people (regions population) and also moves randoms on the edge of a region into travellers array
  for (int i=0; i<regions.length; i=i+1) {
    for (int j=0; j<regions[i].population.length; j=j+1) {
      regions[i].population[j].x=regions[i].population[j].x+regions[i].population[j].xSpeed;
      regions[i].population[j].y=regions[i].population[j].y+regions[i].population[j].ySpeed;
      if (random(1)<0.1 && (dist(regions[i].population[j].x, regions[i].population[j].y, regions[i].x, regions[i].y)<=regions[i].s/2 -5))  regions[i].population[j].xSpeed = int(random(-2, 2));
      if (random(1)<0.1 && (dist(regions[i].population[j].x, regions[i].population[j].y, regions[i].x, regions[i].y)<=regions[i].s/2 -5))  regions[i].population[j].ySpeed = int(random(-2, 2));
      fill(0);      
      ellipse(regions[i].population[j].x, regions[i].population[j].y, regions[i].population[j].s, regions[i].population[j].s);

      if (regions[i].population[j].health<1) {
        fill(0, 255, 0);
        ellipse(regions[i].population[j].x, regions[i].population[j].y, regions[i].population[j].s, regions[i].population[j].s);
      }

      if (dist(regions[i].population[j].x, regions[i].population[j].y, regions[i].x, regions[i].y)>=regions[i].s/2-5) {
        if (random(1)<0.001 || random(1)*random(1)*random(1)*random(regions[i].population[j].mobility)>20) {
          //the person to put into the traveller array
          person traveller=new person();
          traveller.x=regions[i].population[j].x;
          traveller.y=regions[i].population[j].y;
          traveller.s=regions[i].population[j].s;
          traveller.xSpeed=regions[i].population[j].xSpeed;
          traveller.ySpeed=regions[i].population[j].ySpeed;
          traveller.mobility=regions[i].population[j].mobility;
          traveller.health=regions[i].population[j].health;

          //moves the
          regions[i].population[j].x=regions[i].population[regions[i].population.length-1].x;
          regions[i].population[j].y=regions[i].population[regions[i].population.length-1].y;
          regions[i].population[j].s=regions[i].population[regions[i].population.length-1].s;
          regions[i].population[j].xSpeed=regions[i].population[regions[i].population.length-1].xSpeed;
          regions[i].population[j].ySpeed=regions[i].population[regions[i].population.length-1].ySpeed;
          regions[i].population[j].mobility=regions[i].population[regions[i].population.length-1].mobility;
          regions[i].population[j].health=regions[i].population[regions[i].population.length-1].health;
          regions[i].population=(person[])shorten(regions[i].population); 

          travellers=(person[])append(travellers, traveller);
          travellers[travellers.length-1].x=traveller.x;
          travellers[travellers.length-1].y=traveller.y;
          travellers[travellers.length-1].s=traveller.s;
          travellers[travellers.length-1].xSpeed=traveller.xSpeed;
          travellers[travellers.length-1].ySpeed=traveller.ySpeed;
          travellers[travellers.length-1].mobility=traveller.mobility;
          travellers[travellers.length-1].health=traveller.health;
          travellers=(person[])append(travellers, traveller);
        } else {
          regions[i].population[j].xSpeed=regions[i].population[j].xSpeed*-1;
          regions[i].population[j].ySpeed=regions[i].population[j].ySpeed*-1;
        }
      }
    }
  }
  for (int m=0; m<travellers.length; m=m+1) {
    travellers[m].x=travellers[m].x+travellers[m].xSpeed;
    travellers[m].y=travellers[m].y+travellers[m].ySpeed;
    //if (random(1)<0.1 && (dist(travellers[m].x, travellers[m].y, regions[i].x, regions[i].y)<=regions[i].s/2 -5))  travellers[m].xSpeed = int(random(-2, 2));
    //if (random(1)<0.1 && (dist(travellers[m].x, travellers[m].y, regions[i].x, regions[i].y)<=regions[i].s/2 -5))  travellers[m].ySpeed = int(random(-2, 2));
    if (travellers[m].x<0 || travellers[m].x>width) travellers[m].xSpeed=travellers[m].xSpeed*-1;
    if (travellers[m].y<0 || travellers[m].y>height) travellers[m].ySpeed=travellers[m].ySpeed*-1;
    fill(255, 0, 0);
    ellipse(travellers[m].x, travellers[m].y, travellers[m].s, travellers[m].s);
  }
}

void drawRegions() {
  for (int i=0; i<regions.length; i=i+1) {
    fill(255);
    circle(regions[i].x, regions[i].y, regions[i].s);
  }
}      

int regionSelection() {
  for (int i=0; i<regions.length; i=i+1) {
    if ((dist(mouseX, mouseY, regions[i].x, regions[i].y)<=regions[i].s /2)) {
      return i;
    }
  }
  return -1;
} 

void mousePressed() {
  //loop();
}
