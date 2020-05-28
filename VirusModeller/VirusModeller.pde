HScrollbar hs1; // One scrollbar

class person {
  int x, y, xSpeed, ySpeed;
  int mobility, health;
}

person[] persons=new person[100];

class region {
  int s1, x, y;
  String name;
  person[]population;
}

person[] travellers;

region[] regions = new region[9];

void setup() {   
  size(900, 900);

  noStroke();

  hs1 = new HScrollbar(0, height/2-8, width, 16, 16);
}

void draw() {
  background(225);
  makeRegions();
  drawRegions();
  fill(200, 100);
  rect(50, 100, 200, 100, 10);


  hs1.update(); 
  hs1.display();

  stroke(0);
  line(0, height/2, width, height/2);
}



void makeRegions() {
  for (int i=0; i<regions.length; i=i+1) {
    regions[i]=new region();
    regions[i].s1=int(width/int(sqrt(regions.length)));
    regions[i].x=int(i%int(sqrt(regions.length))*width/sqrt(regions.length)+regions[i].s1/2);
    regions[i].y=int(i/int(sqrt(regions.length))*width/sqrt(regions.length)+regions[i].s1/2);   //<>//
    regions[i].population=new person [int(random(50))];
    for (int j=0; j<regions[i].population.length; j=j+1) {
       regions[i].population[j]=new person();
       regions[i].population[j].x = int(random(50));
       regions[i].population[j].y = int(random(50));
       regions[i].population[j].xSpeed = int(random(50));
       regions[i].population[j].ySpeed = int(random(50));
       regions[i].population[j].mobility = int(random(50));
       regions[i].population[j].health = int(random(50)); //<>//
    }
  }
}

void drawRegions() {
  for (int i=0; i<regions.length; i=i+1) {
    fill(255);
    circle(regions[i].x, regions[i].y, regions[i].s1);
  }
}      

void sliders() {
}
