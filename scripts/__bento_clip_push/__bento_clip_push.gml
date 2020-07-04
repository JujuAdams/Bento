/// @function __bento_clip_push(bboxStruct, newFrame)
/// @param bboxStruct
/// @param newFrame
function __bento_clip_push(_bbox, _new_frame)
{
    if (_new_frame)
    {
        var _l = _bbox.l;
        var _t = _bbox.t;
        var _r = _bbox.r;
        var _b = _bbox.b;
    }
    else
    {
        var _l = max(bento_clip.l, _bbox.l);
        var _t = max(bento_clip.t, _bbox.t);
        var _r = min(bento_clip.r, _bbox.r);
        var _b = min(bento_clip.b, _bbox.b);
    }
    
    ds_stack_push(global.__bento_stack_clip_l, _l);
    ds_stack_push(global.__bento_stack_clip_t, _t);
    ds_stack_push(global.__bento_stack_clip_r, _r);
    ds_stack_push(global.__bento_stack_clip_b, _b);
    
    __bento_clip_set(_l, _t, _r, _b);
}