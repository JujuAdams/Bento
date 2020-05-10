/// @param rootElement
/// @param axisH
/// @param axisV
/// @param selectState

function bento_tick_gamepad(_element, _dx, _dy, _select_state)
{
    if (_dx*_dx + _dy*_dy < BENTO_GAMEPAD_DEADZONE*BENTO_GAMEPAD_DEADZONE)
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
        //Update root properties
        with(properties.root_tick)
        {
            prev_focus     = focus;
            focus_distance = 999999;
            
            var _root_select_pressed  = (!select_state &&  _select_state);
            var _root_select_released = ( select_state && !_select_state);
            select_state = _select_state;
            
            if (current_time - last_change < BENTO_GAMEPAD_SCROLL_DELAY)
            {
                _dx = 0;
                _dy = 0;
            }
            
            //If our focused element isn't an element, find the first interactive child and use that
            if (instanceof(focus) != "bento_element_class")
            {
                var _children = _element.children;
                var _i = 0;
                repeat(array_length(_children))
                {
                    var _child = _children[_i];
                    if (_child.style.interactive)
                    {
                        focus = _children[_i];
                        break;
                    }
                    
                    ++_i;
                }
            }
            
            if (instanceof(focus) != "bento_element_class")
            {
                //If our focused element *still* isn't an element, still tick the DOM but don't try to move the selector
                with(_element) __bento_tick_gamepad_inner(0, 0, 0, 0);
            }
            else
            {
                var _bbox = focus.properties.bbox_content;
                var _focus_x = (_bbox.l + _bbox.r)/2;
                var _focus_y = (_bbox.t + _bbox.b)/2;
                with(_element) __bento_tick_gamepad_inner(_focus_x, _focus_y, _dx, _dy);
            }
            
            //If we couldn't find anything to focus, use the previous focus
            if (instanceof(focus) != "bento_element_class")
            {
                focus = prev_focus;
            }
            
            if (instanceof(focus) == "bento_element_class")
            {
                //If We've changed focus...
                if (prev_focus != focus)
                {
                    if (instanceof(prev_focus) == "bento_element_class")
                    {
                        with(prev_focus)
                        {
                            //Reset the element that lost focus
                            properties.mouse.over  = false;
                            properties.mouse.state = false;
                            __bento_mouse_event("leave");
                        }
                    }
                    
                    last_change = current_time;
                }
                
                //Handle interaction with the focused element
                with(focus)
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
    
    with(root.properties.root_tick)
    {
        if ((_gamepad_distance < focus_distance) && (prev_focus != other))
        {
            //If the mouse is over us, add ourselves to the root's array
            focus = other;
            focus_distance = _gamepad_distance;
        }
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
    var _fhi = 999999;
    
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
                            return _flo*sqrt(_dx*_dx + _dy*_dy);
                        }
                    }
                }
            }
        }
    }
    
    return undefined;
}