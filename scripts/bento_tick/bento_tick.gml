/// @param rootElement
/// @param mouseX
/// @param mouseY
/// @param selectState

function bento_tick(_element, _mouse_x, _mouse_y, _select_state)
{
    if (BENTO_WARNING_NOT_ROOT_ELEMENT && (_element.root != _element))
    {
        throw "Bento: bento_tick() given a non-root element";
    }
    
    global.__bento_clip_drawing = false;
    
    __bento_clip_reset(-999999, -999999, 999999, 999999);
    
    with(_element)
    {
        if (property.layout_dirty) resolve_alignment();
        
        with(property.__bento_root__)
        {
            //Update root property
            prev_focus = focus;
            focus      = undefined;
            
            var _root_select_pressed  = (!select_state &&  _select_state);
            var _root_select_released = ( select_state && !_select_state);
            select_state = _select_state;
            
            //Tick the element and children
            with(_element) __bento_tick_inner(_mouse_x, _mouse_y);
            
            //If We've changed focus...
            if (prev_focus != focus)
            {
                if (instanceof(prev_focus) == "bento_class_element")
                {
                    with(prev_focus)
                    {
                        //Reset the element that lost focus
                        property.mouse.focus = false;
                        property.mouse.state = false;
                        __bento_mouse_event("leave");
                    }
                }
            }
            
            //Now handle the state of the focused element
            if (instanceof(focus) == "bento_class_element")
            {
                with(focus)
                {
                    var _prev_focus = property.mouse.focus;
                    var _prev_state = property.mouse.state;
                    
                    if (mouse_wheel_up())   __bento_mouse_event("wheel_u");
                    if (mouse_wheel_down()) __bento_mouse_event("wheel_d");
                    
                    if (!_prev_focus)
                    {
                        property.mouse.focus = true;
                        __bento_mouse_event("enter");
                    }
                    else
                    {
                        __bento_mouse_event("focus");
                    }
                
                    if (_prev_state == _select_state)
                    {
                        if (_select_state && property.mouse.focus) __bento_mouse_event("down");
                    }
                    else
                    {
                        if (_root_select_pressed)
                        {
                            property.mouse.state = true;
                            property.mouse.pressed_dx = property.bbox_outer.l - _mouse_x;
                            property.mouse.pressed_dy = property.bbox_outer.t - _mouse_y;
                            __bento_mouse_event("pressed");
                        }
                        else if (_root_select_released)
                        {
                            property.mouse.state = false;
                            __bento_mouse_event("released");
                        }
                    }
                    
                    return self;
                }
            }
        }
    }
    
    return undefined;
}

function __bento_tick_inner(_mouse_x, _mouse_y)
{
    //Deactivated/destroyed elements always return <false>
    if (property.deactivate || property.destroyed) return false;
    
    if (property.layout_dirty) resolve_alignment();
    
    //Update our clipping frame
    var _do_clip = false;
    if (property.clip || property.clip_new_frame)
    {
        _do_clip = true;
        __bento_clip_push(property.bbox_base, property.clip_new_frame);
    }
    
    //Run custom tick method
    __bento_call_method(property.fixed_tick);
    __bento_call_method(event.tick);
    
    var _mouse_focus_me = false;
    
    //Find out if our element, or any of its children, are under the mouse
    if (property.interactive)
    {
        _mouse_focus_me = __bento_point_in_aabb(_mouse_x, _mouse_y);
    }
    
    var _mouse_focus_child = false;
    var _i = 0;
    repeat(array_length(children))
    {
        var _child = children[_i];
        if (instanceof(_child) == "bento_class_element")
        {
            if (_child.property.destroyed)
            {
                //If our child is destroyed, remove it from this array permanently
                children = __bento_array_delete(children, _i);
                --_i;
            }
            else
            {
                with(_child)
                {
                    //Tick the child too
                    _mouse_focus_child |= __bento_tick_inner(_mouse_x, _mouse_y);
                }
            }
        }
        
        ++_i;
    }
    
    //Pop our clipping frame
    if (_do_clip) __bento_clip_pop();
    
    if (!_mouse_focus_child && _mouse_focus_me)
    {
        //If the mouse is focus on us, tell the root node we're in focus
        root.property.__bento_root__.focus = self;
    }
    
    return (_mouse_focus_child || _mouse_focus_me);
}