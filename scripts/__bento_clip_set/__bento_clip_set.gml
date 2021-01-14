global.__bento_uniform_clip = shader_get_uniform(__shd_bento_clip, "u_vClip");

global.__bento_clip_drawing = false;

#macro bento_clip   global.__bento_clip
bento_clip = {
    l : -999999,
    t : -999999,
    r :  999999,
    b :  999999,
}

global.__bento_stack_clip_l = ds_stack_create();
global.__bento_stack_clip_t = ds_stack_create();
global.__bento_stack_clip_r = ds_stack_create();
global.__bento_stack_clip_b = ds_stack_create();

/// @function __bento_clip_set(left, top, right, bottom)
/// @param left
/// @param top
/// @param right
/// @param bottom
function __bento_clip_set(_left, _top, _right, _bottom)
{
    if (global.__bento_clip_drawing) shader_set_uniform_f(global.__bento_uniform_clip, _left, _top, _right, _bottom);
    
    bento_clip.l = _left;
    bento_clip.t = _top;
    bento_clip.r = _right;
    bento_clip.b = _bottom;
}