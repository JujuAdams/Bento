varying vec2 v_vWorldPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_vClip;

void main()
{
    if ((v_vWorldPosition.x < u_vClip.x) || (v_vWorldPosition.x > u_vClip.z)
    ||  (v_vWorldPosition.y < u_vClip.y) || (v_vWorldPosition.y > u_vClip.w))
    {
        gl_FragColor = vec4(0.0);
    }
    else
    {
        gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    }
}
