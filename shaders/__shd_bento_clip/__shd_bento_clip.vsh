attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vWorldPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 worldPosition = gm_Matrices[MATRIX_WORLD]*vec4(in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_PROJECTION]*gm_Matrices[MATRIX_VIEW]*worldPosition;
    
    v_vWorldPosition = worldPosition.xy;
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
