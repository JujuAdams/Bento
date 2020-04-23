/// @param element
/// @param mouseX
/// @param mouseY
/// @param mouseState

function bento_tick_mouse(_element, _mouse_x, _mouse_y, _mouse_state)
{
    if (BENTO_WARNING_NOT_ROOT_ELEMENT && (_element.root != _element))
    {
        throw "Bento: bento_tick_mouse() given a non-root element";
    }
    
    global.__bento_clip_drawing = false;
    
    __bento_clip_reset(-999999, -999999, 999999, 999999);
    
    with(_element)
    {
        mouse_over_array = [];
        
        __bento_tick_mouse_inner(_mouse_x, _mouse_y);
        
        var _length = array_length(mouse_over_array);
        if (_length > 0)
        {
            //Iterate through the first few children that think the mouse is over them
            var _i = 0;
            repeat(_length-1)
            {
                with(mouse_over_array[_i])
                {
                    if (properties.mouse.over)
                    {
                        //If the mouse isn't over us but it was last frame then trigger a "leave" event
                        __bento_mouse_event("leave");
                    }
                    
                    properties.mouse.over  = false;
                    properties.mouse.state = false;
                }
                
                ++_i;
            }
            
            //Then handle the last element in the array
            var _top_over = mouse_over_array[_length-1];
            if (instanceof(_top_over) == "bento_element_class")
            {
                with(_top_over)
                {
                    var _prev_over  = properties.mouse.over;
                    var _prev_state = properties.mouse.state;
                    
                    if (mouse_wheel_up())   __bento_mouse_event("wheel_u");
                    if (mouse_wheel_down()) __bento_mouse_event("wheel_d");
                    
                    if (!_prev_over)
                    {
                        properties.mouse.over = true;
                        __bento_mouse_event("enter");
                    }
                    else
                    {
                        __bento_mouse_event("over");
                    }
                    
                    if (_prev_state == _mouse_state)
                    {
                        if (_mouse_state && properties.mouse.over) __bento_mouse_event("down");
                    }
                    else
                    {
                        properties.mouse.state = _mouse_state;
                    
                        if (_mouse_state)
                        {
                            __bento_mouse_event("pressed");
                            properties.mouse.pressed_dx = properties.bbox_margin.l - _mouse_x;
                            properties.mouse.pressed_dy = properties.bbox_margin.t - _mouse_y;
                        }
                        else
                        {
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

function __bento_tick_mouse_inner(_mouse_x, _mouse_y)
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
    __bento_call_method(callbacks.tick);
    
    var _mouse_over_me = false;
    
    //Find out if our element, or any of its children, are under the mouse
    if (style.interactive)
    {
        var _mouse_check_function = callbacks.mouse_check;
        if (is_method(_mouse_check_function))
        {
            _mouse_over_me = _mouse_check_function(_mouse_x, _mouse_y);
        }
        else if (_mouse_check_function == undefined)
        {
            _mouse_over_me = __bento_mouse_check_aabb(_mouse_x, _mouse_y);
        }
        else
        {
            _mouse_over_me = script_execute(_mouse_check_function, _mouse_x, _mouse_y);
        }
    }
    
    var _mouse_over_child = false;
    var _i = 0;
    repeat(array_length(children))
    {
        var _child = children[_i];
        if (instanceof(_child) == "bento_element_class")
        {
            if (_child.properties.destroyed)
            {
                //If our child is destroyed, remove it from this array permanently
                children = __bento_array_delete(children, _i);
                
                //Additionally, if needed, scan the struct member variables for references to the destroyed child and remove them
                if (BENTO_CLEAN_UP_DESTROYED_NAMED_CHILDREN)
                {
                    var _names_array = variable_struct_get_names(self);
                    var _j = 0;
                    repeat(array_length(_names_array))
                    {
                        var _name = _names_array[_j];
                        if (variable_struct_get(self, _name) == _child) variable_struct_set(self, _name, undefined);
                        ++_j;
                    }
                }
                
                --_i;
            }
            else
            {
                with(_child)
                {
                    //Tick the child too
                    _mouse_over_child |= __bento_tick_mouse_inner(_mouse_x, _mouse_y);
                }
            }
        }
        
        ++_i;
    }
    
    //Pop our clipping frame
    if (_do_clip) __bento_clip_pop();
    
    if (!_mouse_over_child && _mouse_over_me)
    {
        //If the mouse is over us, add ourselves to the root's array
        root.mouse_over_array[@ array_length(root.mouse_over_array)] = self;
    }
    else
    {
        if (properties.mouse.over)
        {
            //If the mouse isn't over us but it was last frame then trigger a "leave" event
            properties.mouse.over  = false;
            properties.mouse.state = false;
            __bento_mouse_event("leave");
        }
    }
    
    return (_mouse_over_child || _mouse_over_me);
}

/// @function __bento_mouse_check_aabb(mouseX, mouseY)
/// @param mouseX
/// @param mouseY
function __bento_mouse_check_aabb(_mouse_x, _mouse_y)
{
    //Use the clipping window and our AABB to determine if the mouse is over this element
    var _bbox = properties.bbox_padding;
    if (point_in_rectangle(_mouse_x, _mouse_y, bento_clip.l, bento_clip.t, bento_clip.r, bento_clip.b)
    &&  point_in_rectangle(_mouse_x, _mouse_y, _bbox.l, _bbox.t, _bbox.r, _bbox.b))
    {
        return true;
    }
    
    //Otherwise return nothing
    return false;
}