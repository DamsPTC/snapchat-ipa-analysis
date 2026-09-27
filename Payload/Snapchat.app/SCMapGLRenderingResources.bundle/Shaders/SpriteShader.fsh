precision highp int;

precision highp float;

varying vec2 v_texCoord;

uniform sampler2D u_sprite_texture;
uniform float u_alpha;
uniform bool u_draw_debug_grid;

const vec4 black = vec4(0.0, 0.0, 0.0, 1.0);

vec4 mix_colors(vec4 src, vec4 dest) {
    return clamp(src + dest * (1.0 - src.a), 0.0, 1.0);
}

vec4 debug_grid(vec4 color) {
    float width = 0.01;
    vec2 v_unitCoord = (v_texCoord + 1.0) / 2.0;
    if (v_unitCoord.x < width || v_unitCoord.x > 1.0 - width) {
        return color;
    }

    if (v_unitCoord.y < width || v_unitCoord.y > 1.0 - width) {
        return color;
    }

    if (v_unitCoord.x > 0.5-width/2.0 && v_unitCoord.x < 0.5+width/2.0) {
        return color;
    }

    if (v_unitCoord.y > 0.5-width/2.0 && v_unitCoord.y < 0.5+width/2.0) {
        return color;
    }

    return vec4(0.0, 0.0, 0.0, 0.0);
}

void main() {
    if (u_draw_debug_grid) {
        gl_FragColor = debug_grid(black);
    } else {
        vec4 sprite = texture2D(u_sprite_texture, v_texCoord);
        gl_FragColor = sprite * u_alpha;
//        gl_FragColor = mix_colors(debug_grid(vec4(0.0, 0.0, 0.0, 1.0)), gl_FragColor);
    }
}
