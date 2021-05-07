#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

const int pointCount = 200;

uniform vec2 dimentions;
uniform float[pointCount * 3] points;
uniform float depth;
uniform vec3 colorDiv;

varying vec4 vertColor;

float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

void main() {
  vec4 color = vertColor;
  vec2 fragOrd = vec2(gl_FragCoord.x, dimentions.y - gl_FragCoord.y);
  
  float currentDistance = dimentions.x * dimentions.y;
  for (int i = 0; i < pointCount * 3; i+=3) {
    float xDiff = abs(fragOrd.x - points[i]);
    float yDiff = abs(fragOrd.y - points[i+1]);
    float zDiff = abs(depth - points[i+2]);
    float dist = sqrt(pow(xDiff, 2) + pow(yDiff, 2) + pow(zDiff, 2)); 

    if (dist < currentDistance) {
      currentDistance = dist;
    }
  }

  color.r = currentDistance / colorDiv.r;
  color.g = currentDistance / colorDiv.g;
  color.b = currentDistance / colorDiv.b;

  color.r = map(color.r, 0, 1, 0.25, 1);
  color.g = map(color.g, 0, 1, 0.25, 1);
  color.b = map(color.b, 0, 1, 0.25, 1);

  gl_FragColor = color;
}