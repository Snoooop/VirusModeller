//HScrollbar hs; // One scrollbar //<>// //<>//

class person {
  int s, x, y, xSpeed, ySpeed;
  int mobility, health;
}


class region {
  int s, x, y;
  String name;
  person[]population;
}

person[] travellers;

region[] regions = new region[9];

void setup() {   
  size(900, 900);
travellers=new person[0];
  noStroke();

  makeRegions();

  //hs = new HScrollbar(0, height/2-8, width, 16, 16);
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



void makeRegions() {
  for (int i=0; i<regions.length; i=i+1) {
    regions[i]=new region();
    regions[i].s=int(width/int(sqrt(regions.length)));
    regions[i].x=int(i%int(sqrt(regions.length))*width/sqrt(regions.length)+regions[i].s/2);
    regions[i].y=int(i/int(sqrt(regions.length))*width/sqrt(regions.length)+regions[i].s/2);  
    regions[i].population=new person [int(random(500)+100)];
    for (int j=0; j<regions[i].population.length; j=j+1) {
      regions[i].population[j]=new person();
      regions[i].population[j].x = int(regions[i].x+random(-regions[i].s/4, regions[i].s/4));
      regions[i].population[j].y = int(regions[i].y+random(-regions[i].s/4, regions[i].s/4));
      regions[i].population[j].s = int(random(7))-15;
      regions[i].population[j].xSpeed = int(random(-2, 2));
      regions[i].population[j].ySpeed = int(random(-2, 2));
      regions[i].population[j].mobility = int(random(50));
      regions[i].population[j].health = int(random(50));
    }
  }
}



void regionPeople() {
  println(travellers.length);
  for (int i=0; i<regions.length; i=i+1) {
    for (int j=0; j<regions[i].population.length; j=j+1) {

      regions[i].population[j].x=regions[i].population[j].x+regions[i].population[j].xSpeed;
      regions[i].population[j].y=regions[i].population[j].y+regions[i].population[j].ySpeed;
      if (random(1)<0.1 && (dist(regions[i].population[j].x, regions[i].population[j].y, regions[i].x, regions[i].y)<=regions[i].s /2 -5))  regions[i].population[j].xSpeed = int(random(-2, 2));
      if (random(1)<0.1 && (dist(regions[i].population[j].x, regions[i].population[j].y, regions[i].x, regions[i].y)<=regions[i].s /2 -5))  regions[i].population[j].ySpeed = int(random(-2, 2));
      fill(0);      
      ellipse(regions[i].population[j].x, regions[i].population[j].y, regions[i].population[j].s, regions[i].population[j].s);

      if (dist(regions[i].population[j].x, regions[i].population[j].y, regions[i].x, regions[i].y)>=regions[i].s /2 -5) {
        if (random(1)<0.001 || random(1)*random(1)*random(1)*random(regions[i].population[j].mobility)>20) {
          background(0);
          person traveller=regions[i].population[j]; //the person to put into the traveller array
          regions[i].population[j].x=regions[i].population[regions[i].population.length-1].x;
          regions[i].population[j].y=regions[i].population[regions[i].population.length-1].y;
          regions[i].population[j].s=regions[i].population[regions[i].population.length-1].s;
          regions[i].population[j].xSpeed=regions[i].population[regions[i].population.length-1].xSpeed;
          regions[i].population[j].ySpeed=regions[i].population[regions[i].population.length-1].ySpeed;
          regions[i].population[j].mobility=regions[i].population[regions[i].population.length-1].mobility;
          regions[i].population[j].health=regions[i].population[regions[i].population.length-1].health;
          regions[i].population=(person[])shorten(regions[i].population);
          
          //put a new traveller into the traveller array
          travellers=(person[])append(travellers,new person());
          travellers[travellers.length-1].x=traveller.x;
          //copy more fields....
          
        } else {
          regions[i].population[j].xSpeed=regions[i].population[j].xSpeed*-1;
          regions[i].population[j].ySpeed=regions[i].population[j].ySpeed*-1;
        }
      }
    }
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
      println(i);
      return i;
    }
  }
  return -1;
} 
