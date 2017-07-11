uniform mat4 transform;
 
attribute vec4 vertex;
attribute vec4 color;
 
varying vec4 vertColor;
varying vec4 verTexCoord;
 
void main() {
    gl_Position = transform * vertex;
    vertColor = color;
}