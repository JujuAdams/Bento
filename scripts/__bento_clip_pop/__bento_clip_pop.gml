function __bento_clip_pop()
{
    ds_stack_pop(global.__bento_stack_clip_l);
    ds_stack_pop(global.__bento_stack_clip_t);
    ds_stack_pop(global.__bento_stack_clip_r);
    ds_stack_pop(global.__bento_stack_clip_b);
    
    var _l = ds_stack_top(global.__bento_stack_clip_l);
    var _t = ds_stack_top(global.__bento_stack_clip_t);
    var _r = ds_stack_top(global.__bento_stack_clip_r);
    var _b = ds_stack_top(global.__bento_stack_clip_b);
    
    __bento_clip_set(_l, _t, _r, _b);
}