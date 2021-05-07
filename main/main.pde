PShape can;
float angle;
PShader colorShader;

int pointAmmount = 400;
float[] points = new float[pointAmmount * 3];
int depth = 5000;
float currentDepth = 0;

color color1 = color(0, 0, 0);
color color2 = color(0, 0, 0);

float[] color1Deltas = {random(0.004, 0.007), random(0.004, 0.007), random(0.004, 0.007)};
float[] color2Deltas = {random(0.004, 0.007), random(0.004, 0.007), random(0.004, 0.007)};

float[] color1CurrentOffset = {random(0, TWO_PI), random(0, TWO_PI), random(0, TWO_PI)};
float[] color2CurrentOffset = {random(0, TWO_PI), random(0, TWO_PI), random(0, TWO_PI)};

enum ColorType {
  DARK,
  LIGHT
}
// float redDivider = random(350, 550);
// float greenDivider = random(350, 550);
// float blueDivider = random(350, 550);

// float deltaRed = random(0.007);
// float deltaGreen = random(0.007);
// float deltaBlue = random(0.007);

void setup() {
  fullScreen(P3D);
  //size(640, 360, P3D);
  colorShader = loadShader("fragment.shader", "vertex.shader");
  shader(colorShader);
  
  background(0);
  beginShape();
  vertex(0, 0);
  vertex(width, 0);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  
  for (int i = 0; i < pointAmmount * 3; i+=3) {
    points[i] = random(width);
    points[i+1] = random(height);
    points[i+2] = random(depth);
  }
  
  
  colorShader.set("dimentions", float(width), float(height));
  colorShader.set("points", points);
}

void draw() {
  background(0);
  stroke(0, 0, 0, 0);
  beginShape();
  vertex(0, 0);
  vertex(width, 0);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  
  currentDepth += 0.001;
  color1 = changeColor(color1Deltas, color1CurrentOffset, ColorType.DARK);
  color2 = changeColor(color2Deltas, color2CurrentOffset, ColorType.LIGHT);
  
  colorShader.set("dimentions", float(width), float(height));
  colorShader.set("points", points);
  colorShader.set("depth", ((sin(currentDepth) + 1) / 2) * depth);
  colorShader.set("color1", red(color1), green(color1), blue(color1));
  colorShader.set("color2", red(color2), green(color2), blue(color2));
  
  println("color1- Red: " + red(color1) + " blue: " + blue(color1) + " green: " + green(color1));
  println("color2- Red: " + red(color2) + " blue: " + blue(color2) + " green: " + green(color2));
  println("deltas" + color1Deltas[0]);
  //println(frameRate);
  //noLoop();
}

color changeColor(float[] deltas, float[] currentOffset, ColorType type) {
  float minValue;
  float maxValue;

  switch(type) {
    case DARK:
      minValue = 10;
      maxValue = 90;
      break;
    case LIGHT:
      minValue = 100;
      maxValue = 255;
      break;
    default :
      minValue = 50;
      maxValue = 255;
    break;	
  }

  for (int i = 0; i < deltas.length; i++) {
    currentOffset[i] += deltas[i];
  }
  
  float newRed = (maxValue - minValue) * ((sin(currentOffset[0]) + 1) / 2) + minValue;
  float newGreen = (maxValue - minValue) * ((sin(currentOffset[1]) + 1) / 2) + minValue;
  float newBlue = (maxValue - minValue) * ((sin(currentOffset[2]) + 1) / 2) + minValue;

  return color(newRed, newGreen, newBlue);
}
