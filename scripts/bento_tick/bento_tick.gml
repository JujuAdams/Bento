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
    
    with(_element.properties.root_tick)
    {
        //Update root properties
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
                    properties.mouse.focus = false;
                    properties.mouse.state = false;
                    __bento_mouse_event("leave");
                }
            }
        }
        
        //Now handle the state of the focused element
        if (instanceof(focus) == "bento_class_element")
        {
            with(focus)
            {
                var _prev_focus = properties.mouse.focus;
                var _prev_state = properties.mouse.state;
                
                if (mouse_wheel_up())   __bento_mouse_event("wheel_u");
                if (mouse_wheel_down()) __bento_mouse_event("wheel_d");
                
                if (!_prev_focus)
                {
                    properties.mouse.focus = true;
                    __bento_mouse_event("enter");
                }
                else
                {
                    __bento_mouse_event("focus");
                }
                
                if (_prev_state == _select_state)
                {
                    if (_select_state && properties.mouse.focus) __bento_mouse_event("down");
                }
                else
                {
                    if (_root_select_pressed)
                    {
                        properties.mouse.state = true;
                        properties.mouse.pressed_dx = properties.bbox_margin.l - _mouse_x;
                        properties.mouse.pressed_dy = properties.bbox_margin.t - _mouse_y;
                        __bento_mouse_event("pressed");
                    }
                    else if (_root_select_released)
                    {
                        properties.mouse.state = false;
                        __bento_mouse_event("released");
                    }
                }
                
                return self;
            }
        }
    }
    
    return undefined;
}

function __bento_tick_inner(_mouse_x, _mouse_y)
{
    //Deactivated/destroyed elements always return <false>
    if (properties.deactivate || properties.destroyed) return false;
    
    //Update our clipping frame
    var _do_clip = false;
    if (style.clip || style.clip_new_frame)
    {
        _do_clip = true;
        __bento_clip_push(properties.bbox_padding, style.clip_new_frame);
    }
    
    //Run custom tick method
    __bento_call_method(properties.internal_tick);
    __bento_call_method(event.tick);
    
    var _mouse_focus_me = false;
    
    //Find out if our element, or any of its children, are under the mouse
    if (style.interactive)
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
            if (_child.properties.destroyed)
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
        root.properties.root_tick.focus = self;
    }
    
    return (_mouse_focus_child || _mouse_focus_me);
}