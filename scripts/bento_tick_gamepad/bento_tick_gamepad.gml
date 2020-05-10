/// @param element
/// @param axisH
/// @param axisV
/// @param threshold
/// @param moveDelay
/// @param selectState

function bento_tick_gamepad()
{
    var _element      = argument[0];
    var _dx           = argument[1];
    var _dy           = argument[2];
    var _threshold    = argument[3];
    var _move_delay   = argument[4];
    var _select_state = argument[5];
    
    if (_dx*_dx + _dy*_dy < _threshold*_threshold)
    {
        _dx = 0;
        _dy = 0;
    }
    
    if (BENTO_WARNING_NOT_ROOT_ELEMENT && (_element.root != _element))
    {
        throw "Bento: bento_tick_gamepad() given a non-root element";
    }
    
    global.__bento_clip_drawing = false;
    
    __bento_clip_reset(-999999, -999999, 999999, 999999);
    
    with(_element)
    {
        element_over_distance = 999999999;
        if (!variable_struct_exists(self, "element_over")) element_over = undefined;
        old_element_over = element_over;
        
        if (!variable_struct_exists(self, "gamepad_handle_state")) gamepad_handle_state = false;
        var _root_select_pressed  = (!gamepad_handle_state &&  _select_state);
        var _root_select_released = ( gamepad_handle_state && !_select_state);
        gamepad_handle_state = _select_state;
        
        if (_root_select_pressed) show_debug_message("pressed");
        
        if (!variable_struct_exists(self, "last_move")) last_move = -current_time;
        if (current_time - last_move < _move_delay)
        {
            _dx = 0;
            _dy = 0;
        }
        
        if (instanceof(element_over) != "bento_element_class")
        {
            var _i = 0;
            repeat(array_length(children))
            {
                var _child = children[_i];
                if (_child.style.interactive)
                {
                    element_over = children[_i];
                    break;
                }
                
                ++_i;
            }
        }
        
        if (instanceof(element_over) == "bento_element_class")
        {
            var _focus_x = (element_over.properties.bbox_content.l + element_over.properties.bbox_content.r)/2;
            var _focus_y = (element_over.properties.bbox_content.t + element_over.properties.bbox_content.b)/2;
            __bento_tick_gamepad_inner(_focus_x, _focus_y, 999999*_dx, 999999*_dy);
        }
        else
        {
            __bento_tick_gamepad_inner(0, 0, 0, 0);
        }
        
        if (instanceof(element_over) != "bento_element_class")
        {
            element_over = old_element_over;
        }
        
        if (instanceof(element_over) == "bento_element_class")
        {
            if ((instanceof(old_element_over) == "bento_element_class") && (old_element_over != element_over))
            {
                with(old_element_over)
                {
                    //If the mouse isn't over us but it was last frame then trigger a "leave" event
                    properties.mouse.over  = false;
                    properties.mouse.state = false;
                    __bento_mouse_event("leave");
                }
                
                last_move = current_time;
            }
            
            with(element_over)
            {
                var _prev_over  = properties.mouse.over;
                var _prev_state = properties.mouse.state;
                
                if (!_prev_over)
                {
                    properties.mouse.over = true;
                    __bento_mouse_event("enter");
                }
                else
                {
                    __bento_mouse_event("over");
                }
                
                if (_prev_state == _select_state)
                {
                    if (_select_state && properties.mouse.over) __bento_mouse_event("down");
                }
                else
                {
                    if (_root_select_pressed)
                    {
                        properties.mouse.state = true;
                        properties.mouse.pressed_dx = properties.bbox_margin.l - _focus_x;
                        properties.mouse.pressed_dy = properties.bbox_margin.t - _focus_y;
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

function __bento_tick_gamepad_inner(_focus_x, _focus_y, _focus_dx, _focus_dy)
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
    __bento_call_method(callback.tick);
    
    var _gamepad_distance = undefined;
    
    //Find out if our element, or any of its children, are under the mouse
    if (style.interactive)
    {
        var _gamepad_check_function = callback.gamepad_check;
        if (is_method(_gamepad_check_function))
        {
            _gamepad_distance = _gamepad_check_function(_focus_x, _focus_y, _focus_dx, _focus_dy);
        }
        else if (_gamepad_check_function == undefined)
        {
            _gamepad_distance = __bento_gamepad_check_aabb(_focus_x, _focus_y, _focus_dx, _focus_dy);
        }
        else
        {
            _gamepad_distance = script_execute(_gamepad_check_function, _focus_x, _focus_y, _focus_dx, _focus_dy);
        }
    }
    
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
                    __bento_tick_gamepad_inner(_focus_x, _focus_y, _focus_dx, _focus_dy);
                }
            }
        }
        
        ++_i;
    }
    
    //Pop our clipping frame
    if (_do_clip) __bento_clip_pop();
    
    if ((_gamepad_distance < root.element_over_distance) && (root.old_element_over != self))
    {
        //If the mouse is over us, add ourselves to the root's array
        root.element_over = self;
        root.element_over_distance = _gamepad_distance;
    }
    
    return _gamepad_distance;
}

/// @function __bento_gamepad_check_aabb(originX, originY, dX, dY)
/// @param originX
/// @param originY
/// @param dX
/// @param dY
function __bento_gamepad_check_aabb(_x1, _y1, _dx, _dy)
{
    if ((_dx == 0) && (_dy == 0)) return undefined;
    
    var _bbox = properties.bbox_padding;
    var _l = max(_bbox.l, bento_clip.l);
    var _t = max(_bbox.t, bento_clip.t);
    var _r = min(_bbox.r, bento_clip.r);
    var _b = min(_bbox.b, bento_clip.b);
    
    var _flo = 0;
    var _fhi = 1;
    
    var _f0x = (_l - _x1) / _dx;
    var _f1x = (_r - _x1) / _dx;
    
    if (_f0x > _f1x)
    {
        var _temp = _f0x;
        _f0x = _f1x;
        _f1x = _temp;
    }
    
    if (_f1x > _flo)
    {
        if (_f0x < _fhi)
        {
            _flo = max(_flo, _f0x);
            _fhi = min(_fhi, _f1x);
            
            if (_flo < _fhi)
            {
                var _f0y = (_t - _y1) / _dy;
                var _f1y = (_b - _y1) / _dy;
                
                if (_f0y > _f1y)
                {
                    var _temp = _f0y;
                    _f0y = _f1y;
                    _f1y = _temp;
                }
                
                if (_f1y > _flo)
                {
                    if (_f0y < _fhi)
                    {         
                        _flo = max(_flo, _f0y);
                        _fhi = min(_fhi, _f1y);
                        
                        if (_flo < _fhi)
                        {
                            // Nearest intersection
                            var _ix =  _flo*_dx;
                            var _iy =  _flo*_dy;
                            
                            return sqrt(_ix*_ix + _iy*_iy);
                        }
                    }
                }
            }
        }
    }
    
    return undefined;
}