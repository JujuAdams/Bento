/// @param rootElement

function bento_draw(_element)
{
    if (BENTO_WARNING_NOT_ROOT_ELEMENT && (_element.root != _element))
    {
        throw "Bento: bento_draw() given a non-root element";
    }
    
    //Store our draw state so we can reset it later
    var _old_color  = draw_get_color();
    var _old_alpha  = draw_get_alpha();
    var _old_halign = draw_get_halign();
    var _old_valign = draw_get_valign();
    var _old_shader = shader_current();
    
    shader_set(__shd_bento_clip);
    global.__bento_clip_drawing = true; //Make sure __bento_clip_set() knows we want to set the shader uniform
    __bento_clip_reset(-999999, -999999, 999999, 999999); //Render everything until we clip!
    with(_element) __bento_draw_inner();
    global.__bento_clip_drawing = false;
    
    //Reset the draw state!
    draw_set_color(_old_color);
    draw_set_alpha(_old_alpha);
    draw_set_halign(_old_halign);
    draw_set_valign(_old_valign);
    shader_set(_old_shader);
}


function __bento_draw_inner()
{
    //If we're not visible or we're deactivated/destroyed, don't draw us or our children
    if (!property.visible || property.deactivate || property.destroyed) exit;
    
    if (property.layout_dirty) layout_update();
    
    //Update our clipping frame
    var _do_clip = false;
    if (property.clip || property.clip_new_frame)
    {
        _do_clip = true;
        __bento_clip_push(property.bbox_content, property.clip_new_frame);
    }
    
    //Draw our element
    __bento_call_method(event.draw);
    
    //Draw our children
    var _i = 0;
    repeat(array_length(children))
    {
        var _child = children[_i];
        
        //If this member is a struct, and a Bento element, draw it
        if (instanceof(_child) == "bento_class_element") with(_child) __bento_draw_inner();
        
        ++_i;
    }
    
    //Pop our clipping frame
    if (_do_clip) __bento_clip_pop();
}