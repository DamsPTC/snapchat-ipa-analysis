#ifdef GL_OES_standard_derivatives
#   extension GL_OES_standard_derivatives : enable
#endif

precision highp int;
precision highp float;

varying vec2 v_unitCoord;
varying vec2 v_thumbCoord;
varying vec2 v_emojiCoord;

uniform sampler2D u_thumbnail_texture;
uniform sampler2D u_label_texture;
uniform sampler2D u_emoji_texture;
uniform float u_alpha;
uniform int u_shape_type;
uniform float u_border_scale;
uniform bool u_should_draw_label;
uniform bool u_should_draw_thumbnail;
uniform float u_loading_radians;
uniform float u_loading_spinner_alpha;
uniform bool u_should_draw_base_drop_shadow;
uniform bool u_is_direct_render;
uniform bool u_is_dark_mode;

// label cut away uniforms
uniform vec2 u_circle_stretch;
uniform vec2 u_circle_translate;

// shape constants shared with host program
uniform float u_outer_circle_radius;
uniform float u_border_width;

// colors
const vec4 dropShadowColor = vec4(0.0, 0.0, 0.0, 1.0);
const vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
const vec4 clear = vec4(0.0, 0.0, 0.0, 0.0);
const vec4 lightRed = vec4(1.0, 0.8, 0.8, 1.0);
const vec4 purple = vec4(0.933, 0.5, 0.933, 1.0);
const vec4 innerCircleGray = vec4(0.88, 0.88, 0.88, 0.95);

// rect constants
const float stretch_gaussian = 3.0; // into the -1 to 1 space

float f_delta(float x) {
    #ifdef GL_OES_standard_derivatives
        return fwidth(x);
    #else
        return 0.0;
    #endif
}

vec4 mix_colors(vec4 src, vec4 dest) {
    return clamp(src + dest * (1.0 - src.a), 0.0, 1.0);
}

float inv_smoothstep(float a, float b, float d) {
    return 1.0 - smoothstep(a, b, d);
}

float unit_circle_drop_shadow_alpha(float dist) {
    return clamp((exp(-dist * dist / 0.32) - 0.044) * 3.0, 0.0, 1.0);
}

vec2 to_vertex_coord(vec2 tex_coord) {
    return tex_coord * 2.0 - 1.0;
}

vec2 to_tex_coord(vec2 vertex_coord) {
    return (vertex_coord + 1.0) / 2.0;
}

vec4 color_for_base_drop_shadow(vec2 vertexCoord) {
    vec2 stretchedCoord = vec2(vertexCoord.x / 4.0, vertexCoord.y);
    float dist = distance(stretchedCoord, vec2(0.0, -0.85));
    float normalizedDist = dist / 0.15;
    return unit_circle_drop_shadow_alpha(normalizedDist) * dropShadowColor * 0.5;
}

vec4 color_for_loading_spinner(vec2 coord, float outerCircleAlpha, float innerCircleAlpha) {
    vec2 radarCoord = vec2(cos(2.0 * 3.14159 - u_loading_radians), sin(2.0 * 3.14159 - u_loading_radians));
    float dotPrd = radarCoord.x * coord.x + radarCoord.y * coord.y;
    float det = coord.x * radarCoord.y - coord.y * radarCoord.x;
    float angle = atan(det, dotPrd);
    float angleAlpha = (angle + 3.14159) / 2.0 / 3.14159;
    float loadingAlpha = clamp((outerCircleAlpha * angleAlpha * u_loading_spinner_alpha) - innerCircleAlpha, 0.0, 1.0);
    return purple * loadingAlpha;
}

vec4 color_for_circle(float scaled_border_width) {
    vec2 coord = to_vertex_coord(v_unitCoord);

    float dist = distance(coord, vec2(0.0, 0.0));
    float delta = f_delta(dist);
    float innerCircleRadius = u_outer_circle_radius - scaled_border_width;

    float thumbAlpha = inv_smoothstep(innerCircleRadius - delta, innerCircleRadius, dist);
    // account for circle size to get as much of the texture in the circle as possible
    vec2 samplingCoord = to_tex_coord(to_vertex_coord(v_thumbCoord) / innerCircleRadius);
    vec4 thumbColor = texture2D(u_thumbnail_texture, samplingCoord) * thumbAlpha;

    float backingAlpha = inv_smoothstep(u_outer_circle_radius - delta, u_outer_circle_radius, dist);

    vec4 loadingColor = color_for_loading_spinner(coord, backingAlpha, thumbAlpha);
    vec4 outerRingColor = white * clamp(backingAlpha - thumbAlpha, 0.0, 1.0);
    if(u_is_dark_mode){
        outerRingColor = black * clamp(backingAlpha - thumbAlpha, 0.0, 1.0);
    }
    vec4 innerBackingColor = innerCircleGray * backingAlpha;
    vec4 backingColor = mix_colors(loadingColor, mix_colors(outerRingColor, innerBackingColor));

    float dropShadowAlpha = clamp(unit_circle_drop_shadow_alpha(dist) - thumbAlpha, 0.0, 1.0);

    vec4 iconColor = u_should_draw_thumbnail ? mix_colors(thumbColor, backingColor) : clamp(backingColor, 0.0, 1.0);
    
    vec4 baseDropShadow = color_for_base_drop_shadow(coord);

    vec4 colorWithShadow = mix_colors(iconColor, dropShadowColor * dropShadowAlpha);

    return u_should_draw_base_drop_shadow ? mix_colors(colorWithShadow, baseDropShadow) : clamp(colorWithShadow, 0.0, 1.0);
}

vec4 color_for_label() {
    vec2 coord = to_vertex_coord(v_unitCoord);
    vec4 color = texture2D(u_label_texture, v_unitCoord);

    // find the cut-away for the circle shape
    vec2 circleCenter = vec2(0.0, 0.0);

    float distFromCircle = distance(circleCenter, vec2((coord.x - u_circle_translate.x) * u_circle_stretch.x, (coord.y - u_circle_translate.y) * u_circle_stretch.y));
    float delta = f_delta(distFromCircle) * 2.0; // a little extra to avoid a gap

    return color * smoothstep(1.0 - delta, 1.0, distFromCircle);
}

float when_lte(float x, float y) {
    return min(sign(y - x) + 1.0, 1.0);
}

float and(float x, float y) {
    return sign(floor(x) + floor(y) - 2.0) + 1.0;
}

vec4 color_for_emoji(float scaled_border_width) {
    vec2 coord = to_vertex_coord(v_unitCoord);

    float dist = distance(coord, vec2(0.0, 0.0));
    float delta = f_delta(dist);

    vec2 expanded = to_vertex_coord(v_emojiCoord);
    // stretch sampling to fit emoji in to the square
    vec2 samplingCoords = (v_emojiCoord - 0.5) * 1.4 + 0.5;

    // drop alpha at edges to avoid edge sampling artifacts
    float topAndRightAlpha = and(when_lte(samplingCoords.x, 1.0), when_lte(samplingCoords.y, 1.0));
    float bottomAndLeftAlpha = and(when_lte(0.0, samplingCoords.x), when_lte(0.0, samplingCoords.y));
    float emojiAlpha = and(topAndRightAlpha, bottomAndLeftAlpha);

    float innerCircle = u_outer_circle_radius - scaled_border_width;
    float innerAlpha = inv_smoothstep(innerCircle - delta, innerCircle, dist);
    float outerAlpha = inv_smoothstep(u_outer_circle_radius - delta, u_outer_circle_radius, dist);

    vec4 loadingColor = color_for_loading_spinner(coord, outerAlpha, innerAlpha);
    vec4 emojiColor = texture2D(u_emoji_texture, samplingCoords) * emojiAlpha;
    vec4 backingColor = white * outerAlpha;
    vec4 dropShadow = unit_circle_drop_shadow_alpha(dist) * dropShadowColor;

    return mix_colors(mix_colors(emojiColor, mix_colors(loadingColor, backingColor)), dropShadow);
}

vec4 debug_grid(vec4 color) {
    float width = 0.02;
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

    return clear;
}

vec4 pre_alpha_color() {
    if (u_is_direct_render) {
        return texture2D(u_thumbnail_texture, v_thumbCoord);
    }
    
    if (u_should_draw_label) {
        vec4 labelColor = color_for_label();
        return clamp(labelColor, 0.0, 1.0);
    }
    
    float scaled_border_width = u_border_scale * u_border_width;
    vec4 circleColor = color_for_circle(scaled_border_width);
    return clamp(circleColor, 0.0, 1.0);
}

void main() {
    gl_FragColor = pre_alpha_color() * u_alpha;
//    gl_FragColor = mix_colors(debug_grid(black)*0.5, gl_FragColor);
}
