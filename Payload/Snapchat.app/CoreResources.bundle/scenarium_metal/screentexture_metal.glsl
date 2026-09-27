//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifdef SC_TEXTURE_RECT
#extension GL_ARB_texture_rectangle : require
uniform sampler2DRect screenTexture;
#else
uniform sampler2D screenTexture;
#endif
uniform mat3 screenTextureTransform;

varying vec2 varTex0;

#ifdef VERTEX_SHADER
attribute vec2 position;
attribute vec2 texture0;

void main(void) {
    varTex0 = vec2(screenTextureTransform * vec3(texture0, 1.0));
    gl_Position = vec4(position, 0.0, 1.0);
}
#endif

#ifdef FRAGMENT_SHADER
void main(void) {
#ifdef SC_TEXTURE_RECT
    gl_FragColor = texture2DRect(texture2DRect, varTex0);
#else
    gl_FragColor = texture2D(screenTexture, varTex0);
#endif
}
#endif
