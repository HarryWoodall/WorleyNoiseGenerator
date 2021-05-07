#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

const int pointCount = 300;

uniform vec2 dimentions;
uniform float[pointCount * 3] points;
uniform float depth;
uniform vec3 color1;
uniform vec3 color2;

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

  vec4 firstColor = vec4(color1, 1.0f);
  vec4 secondColor = vec4(color2, 1.0f);

  firstColor.r = map(color1.r, 0, 255, 0, 1);
  firstColor.g = map(color1.r, 0, 255, 0, 1);
  firstColor.b = map(color1.b, 0, 255, 0, 1);

  secondColor.r = map(color2.r, 0, 255, 0, 1);
  secondColor.g = map(color2.r, 0, 255, 0, 1);
  secondColor.b = map(color2.b, 0, 255, 0, 1);

  color = mix(firstColor, secondColor, currentDistance / 200);

  gl_FragColor = color;
}