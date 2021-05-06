PShape can;
float angle;
PShader colorShader;

int pointAmmount = 200;
float[] points = new float[pointAmmount * 3];
int depth = 2000;
float currentDepth = 0;

float redDivider = random(350, 550);
float greenDivider = random(350, 550);
float blueDivider = random(350, 550);

float deltaRed = random(0.007);
float deltaGreen = random(0.007);
float deltaBlue = random(0.007);

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
  
  currentDepth += 0.002;
  redDivider += deltaRed;
  greenDivider += deltaGreen;
  blueDivider += deltaGreen;

  float redValue = 200 * (sin(redDivider) + 1 / 2) + 350;
  float greenValue = 200 * (sin(greenDivider) + 1 / 2) + 350;
  float blueValue = 200 * (sin(blueDivider) + 1 / 2) + 350;
  
  colorShader.set("dimentions", float(width), float(height));
  colorShader.set("points", points);
  colorShader.set("depth", ((sin(currentDepth) + 1) / 2) * depth);
  colorShader.set("colorDiv", redValue, greenValue, blueValue);
  
  println(frameRate);
  //noLoop();
}
