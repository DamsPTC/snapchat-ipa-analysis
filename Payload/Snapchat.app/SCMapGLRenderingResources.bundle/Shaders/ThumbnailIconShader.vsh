precision highp int;

precision highp float;

attribute vec2 a_pos;

varying vec2 v_unitCoord;
varying vec2 v_thumbCoord;
varying vec2 v_emojiCoord;

uniform vec2 u_scale;
uniform vec2 u_translate;

void main() {
    gl_Position = vec4(a_pos * u_scale + u_translate, 0, 1.0);

    v_unitCoord = (a_pos + 1.0) / 2.0;
    v_thumbCoord = v_unitCoord;
    v_emojiCoord = v_unitCoord;
}
