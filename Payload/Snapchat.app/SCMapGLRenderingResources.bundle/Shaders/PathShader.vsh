precision highp int;
precision highp float;

attribute vec4 a_pos;

varying float v_pixel_x;
varying float v_pixel_y;

void main() {
    gl_Position = vec4(a_pos.xy, 0 , 1);
    v_pixel_x = a_pos.z;
    v_pixel_y = a_pos.w;
}
