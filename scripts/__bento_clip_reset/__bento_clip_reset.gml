/// @function __bento_clip_reset(left, top, right, bottom)
/// @param left
/// @param top
/// @param right
/// @param bottom
function __bento_clip_reset(_left, _top, _right, _bottom)
{
    ds_stack_clear(global.__bento_stack_clip_l);
    ds_stack_clear(global.__bento_stack_clip_t);
    ds_stack_clear(global.__bento_stack_clip_r);
    ds_stack_clear(global.__bento_stack_clip_b);
    
    ds_stack_push(global.__bento_stack_clip_l, _left  );
    ds_stack_push(global.__bento_stack_clip_t, _top   );
    ds_stack_push(global.__bento_stack_clip_r, _right );
    ds_stack_push(global.__bento_stack_clip_b, _bottom);
    
    __bento_clip_set(_left, _top, _right, _bottom);
}