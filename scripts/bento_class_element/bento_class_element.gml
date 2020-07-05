/// This is the base Bento element constructor; all elements should start with this constructor

function bento_class_element() constructor
{
    children = [];
    
    property = {
        name      : "",
        long_name : "",
        
        visible    : true,
        deactivate : false,
        destroyed  : false,
        
        clip           : false,
        clip_new_frame : false,
        interactive    : false,
        
        layout_dirty : true,
        
        source_width      : 0,
        source_height     : 0,
        lock_aspect_ratio : false,
        
        color  : c_white,
        alpha  : 1.0,
        
        outer_space : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        inner_space : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        
        bbox_inner : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        bbox_base : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        bbox_outer : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        
        mouse : {
            focus      : false,
            state      : false,
            pressed    : false,
            released   : false,
            pressed_dx : 0,
            pressed_dy : 0,
        },
    
        __bento_root__ : {
            focus        : undefined,
            prev_focus   : undefined,
            select_state : false,
        },
        
        fixed_mouse_event : undefined,
        fixed_tick        : undefined,
    };
    
    alignment = {
        l : {
            target : undefined,
            offset : 0,
        },
        t : {
            target : undefined,
            offset : 0,
        },
        r : {
            target : undefined,
            offset : 0,
        },
        b : {
            target : undefined,
            offset : 0,
        },
        children : [],
    };
        
    event = {
        tick           : undefined,
        draw           : undefined, //After clipping, before children
        mouse_enter    : undefined,
        mouse_focus    : undefined,
        mouse_leave    : undefined,
        mouse_pressed  : undefined,
        mouse_down     : undefined,
        mouse_released : undefined,
        mouse_wheel_u  : undefined,
        mouse_wheel_d  : undefined,
    };
    
    property.name = "<element" + string(global.__bento_element_count) + ">";
    ++global.__bento_element_count;
    
    if (instanceof(other) == "bento_class_element")
    {
        __bento_array_add(other.children, self);
        
        root   = other.root;
        parent = other;
        
        property.long_name = parent.property.long_name + "." + property.name;
    }
    else
    {
        root   = self;
        parent = undefined;
        
        property.long_name = property.name;
    }
    
    global.__bento_prev2 = global.__bento_prev;
    global.__bento_prev  = self;
    
    #region Methods
    
    /// @function layout_update()
    layout_update = function()
    {
        var _aspect_ratio = property.source_width/property.source_height;
        
        var _outer_w = property.source_width  + property.outer_space.l + property.outer_space.r;
        var _outer_h = property.source_height + property.outer_space.t + property.outer_space.b;
        
        var _root_content = root.property.bbox_inner;
        var _root_w = 1 + _root_content.r - _root_content.l;
        var _root_h = 1 + _root_content.r - _root_content.l;
        
        #region Collect alignment data and handle destroyed targets
        
        var _align_l  = alignment.l;
        var _align_t  = alignment.t;
        var _align_r  = alignment.r;
        var _align_b  = alignment.b;
        
        var _target_l = _align_l.target;
        var _target_t = _align_t.target;
        var _target_r = _align_r.target;
        var _target_b = _align_b.target;
        
        var _target_l_valid = is_struct(_target_l);
        var _target_t_valid = is_struct(_target_t);
        var _target_r_valid = is_struct(_target_r);
        var _target_b_valid = is_struct(_target_b);
        
        if (is_struct(_target_l))
        {
            if (instanceof(_target_l) == "bento_class_element")
            {
                if (_target_l.property.destroyed)
                {
                    _target_l = undefined;
                    _target_l_valid = false;
                    _align_l.target = undefined;
                }
            }
        }
        
        if (is_struct(_target_t))
        {
            if (instanceof(_target_t) == "bento_class_element")
            {
                if (_target_t.property.destroyed)
                {
                    _target_t = undefined;
                    _target_t_valid = false;
                    _align_t.target = undefined;
                }
            }
        }
        
        if (is_struct(_target_r))
        {
            if (instanceof(_target_r) == "bento_class_element")
            {
                if (_target_r.property.destroyed)
                {
                    _target_r = undefined;
                    _target_r_valid = false;
                    _align_r.target = undefined;
                }
            }
        }
        
        if (is_struct(_target_b))
        {
            if (instanceof(_target_b) == "bento_class_element")
            {
                if (_target_b.property.destroyed)
                {
                    _target_b = undefined;
                    _target_b_valid = false;
                    _align_b.target = undefined;
                }
            }
        }
        
        #endregion
        
        #region If either of our axes have no alignment set up, find the size of our bbox automatically from the source width/height
        
        var _update_from_base = false;
        if (!_target_l_valid && !_target_r_valid)
        {
            property.bbox_base.r = property.bbox_base.l + property.source_width;
            _update_from_base = true;
        }
        
        if (!_target_t_valid && !_target_b_valid)
        {
            property.bbox_base.b = property.bbox_base.t + property.source_height;
            _update_from_base = true;
        }
        
        if (_update_from_base) update_from_bbox_base();
        
        #endregion
        
        #region Set the bounding box based on the alignments
        
        var _update_from_outer = false;
        
        if (_target_l_valid)
        {
            _update_from_outer = true;
            
            var _target = _target_l;
            if (instanceof(_target) == "bento_class_element")
            {
                //If the target is our parent then use the inner bbox
                _target = (parent == _target)? _target.property.bbox_inner : _target.property.bbox_outer
            }
            
            property.bbox_outer.l = _target.l +
                                    __bento_parse_offset(_outer_w,
                                                         1 + _target.r - _target.l,
                                                         _root_w,
                                                         global.bento_view_width,
                                                         _align_l.offset);
        }
        
        if (_target_t_valid)
        {
            _update_from_outer = true;
            
            var _target = _target_t;
            if (instanceof(_target) == "bento_class_element")
            {
                //If the target is our parent then use the inner bbox
                _target = (parent == _target)? _target.property.bbox_inner : _target.property.bbox_outer
            }
            
            property.bbox_outer.t = _target.t +
                                    __bento_parse_offset(_outer_h,
                                                         1 + _target.b - _target.t,
                                                         _root_h,
                                                         global.bento_view_height,
                                                         _align_t.offset);
        }
        
        if (_target_r_valid)
        {
            _update_from_outer = true;
            
            var _target = _target_r;
            if (instanceof(_target) == "bento_class_element")
            {
                //If the target is our parent then use the inner bbox
                _target = (parent == _target)? _target.property.bbox_inner : _target.property.bbox_outer
            }
            
            property.bbox_outer.r = _target.l +
                                    __bento_parse_offset(_outer_w,
                                                         1 + _target.r - _target.l,
                                                         _root_w,
                                                         global.bento_view_width,
                                                         _align_r.offset);
        }
        
        if (_target_b_valid)
        {
            _update_from_outer = true;
            
            var _target = _target_b;
            if (instanceof(_target) == "bento_class_element")
            {
                //If the target is our parent then use the inner bbox
                _target = (parent == _target)? _target.property.bbox_inner : _target.property.bbox_outer
            }
            
            property.bbox_outer.b = _target.t +
                                    __bento_parse_offset(_outer_h,
                                                         1 + _target.b - _target.t,
                                                         _root_h,
                                                         global.bento_view_height,
                                                         _align_b.offset);
        }
        
        #endregion
        
        if (_update_from_outer)
        {
            if (!_target_l_valid && _target_r_valid) property.bbox_outer.l = property.bbox_outer.r - _outer_w;
            if (!_target_t_valid && _target_b_valid) property.bbox_outer.t = property.bbox_outer.b - _outer_h;
            if (!_target_r_valid && _target_l_valid) property.bbox_outer.r = property.bbox_outer.l + _outer_w;
            if (!_target_b_valid && _target_t_valid) property.bbox_outer.b = property.bbox_outer.t + _outer_h;
            
            update_from_bbox_outer();
        }
        
        if (property.lock_aspect_ratio)
        {
            if (_target_l_valid && _target_r_valid) //Width is strictly bound
            {
                var _base_width  = property.bbox_base.r - property.bbox_base.l;
                var _base_height = _base_width / _aspect_ratio;
                
                if (!_target_b_valid) //Bottom is unbound (we don't care if the top is bound or not)
                {
                    property.bbox_base.b = property.bbox_base.t + _base_height;
                }
                else if (!_target_t_valid) //Bottom is bound but the top is unbound
                {
                    property.bbox_base.t = property.bbox_base.b - _base_height;
                }
                else //Top and bottom are bound
                {
                    //Do nothing!
                }
            }
            else if (_target_t_valid && _target_b_valid) //Height is strictly bound
            {
                var _base_height = property.bbox_base.b - property.bbox_base.t;
                var _base_width = _base_height * _aspect_ratio;
                
                if (!_target_r_valid) //Right is unbound (we don't care if the left is bound or not)
                {
                    property.bbox_base.r = property.bbox_base.l + _base_width;
                }
                else if (!_target_l_valid) //Right is bound but the left is unbound
                {
                    property.bbox_base.l = property.bbox_base.r - _base_width;
                }
                else //Left and right are bound
                {
                    //Do nothing!
                }
            }
            
            update_from_bbox_base();
        }
        
        if (_update_from_base || _update_from_outer)
        {
            var _array = alignment.children;
            var _i = 0;
            repeat(array_length(_array))
            {
                var _child = _array[_i];
                if (instanceof(_child) == "bento_class_element")
                {
                    with(_child) layout_update();
                    ++_i;
                }
                else
                {
                    show_debug_message("Deleting layout child " + string(_child));
                    __bento_array_delete(_array, _i);
                }
            }
        }
        
        property.layout_dirty = false;
    }
    
    /// @function destroy()
    destroy = function()
    {
        //Mark us as destroyed
        property.destroyed = true;
        
        //Mark our children as destroyed too
        var _i = 0;
        repeat(array_length(children))
        {
            var _child = children[_i];
            if (instanceof(_child) == "bento_class_element") _child.destroy();
            ++_i;
        }
    }
    
    /// string() behaviour
    toString = function()
    {
        return property.long_name;
    }
    
    #region Alignment
    
    /// @function align_l_to_target_l(target, [offset])
    /// @param target
    /// @param [offset]
    align_l_to_target_l = function()
    {
        __bento_align(alignment.l, argument[0], (argument_count > 1)? argument[1] : 0);
    }
    
    /// @function align_t_to_target_t(target, [offset])
    /// @param target
    /// @param [offset]
    align_t_to_target_t = function()
    {
        __bento_align(alignment.t, argument[0], (argument_count > 1)? argument[1] : 0);
    }
    
    /// @function align_r_to_target_r(target, [offset])
    /// @param target
    /// @param [offset]
    align_r_to_target_l = function()
    {
        __bento_align(alignment.r, argument[0], (argument_count > 1)? argument[1] : 0);
    }
    
    /// @function align_b_to_target_t(target, [offset])
    /// @param target
    /// @param [offset]
    align_b_to_target_t = function()
    {
        __bento_align(alignment.b, argument[0], (argument_count > 1)? argument[1] : 0);
    }
    
    /// @function align_l_to_target_r(target, [offset])
    /// @param target
    /// @param [offset]
    align_l_to_target_r = function()
    {
        align_l_to_target_l(argument[0], (argument_count > 1)? (string(argument[1]) + "+100%T") : "100%T");
    }
    
    /// @function align_t_to_target_b(target, [offset])
    /// @param target
    /// @param [offset]
    align_t_to_target_b = function()
    {
        align_t_to_target_t(argument[0], (argument_count > 1)? (string(argument[1]) + "+100%T") : "100%T");
    }
    
    /// @function align_r_to_target_l(target, [offset])
    /// @param target
    /// @param [offset]
    align_r_to_target_r = function()
    {
        align_r_to_target_l(argument[0], (argument_count > 1)? (string(argument[1]) + "+100%T") : "100%T");
    }
    
    /// @function align_b_to_target_b(target, [offset])
    /// @param target
    /// @param [offset]
    align_b_to_target_b = function()
    {
        align_b_to_target_t(argument[0], (argument_count > 1)? (string(argument[1]) + "+100%T") : "100%T");
    }
    
    /// @function align_x_to_target_x(target, [offset])
    /// @param target
    /// @param [offset]
    align_x_to_target_x = function()
    {
        var _offset = (argument_count > 1)? argument[1] : 0;
        align_l_to_target_l(argument[0], string(_offset) + "+50%T-50%");
        align_r_to_target_l(argument[0], string(_offset) + "+50%T+50%");
    }
    
    /// @function align_y_to_target_y(target, [offset])
    /// @param target
    /// @param [offset]
    align_y_to_target_y = function()
    {
        var _offset = (argument_count > 1)? argument[1] : 0;
        align_t_to_target_t(argument[0], string(_offset) + "+50%T-50%");
        align_b_to_target_t(argument[0], string(_offset) + "+50%T+50%");
    }
    
    #endregion
    
    #region Bounding box updates
    
    /// @function update_from_bbox_outer()
    update_from_bbox_outer = function()
    {
        with(property)
        {
            bbox_base.l = bbox_outer.l + outer_space.l;
            bbox_base.t = bbox_outer.t + outer_space.t;
            bbox_base.r = bbox_outer.r - outer_space.r;
            bbox_base.b = bbox_outer.b - outer_space.b;
            
            bbox_inner.l = bbox_base.l + inner_space.l;
            bbox_inner.t = bbox_base.t + inner_space.t;
            bbox_inner.r = bbox_base.r - inner_space.r;
            bbox_inner.b = bbox_base.b - inner_space.b;
        }
    }
    
    /// @function update_from_bbox_base()
    update_from_bbox_base = function()
    {
        with(property)
        {
            bbox_outer.l = bbox_base.l - outer_space.l;
            bbox_outer.t = bbox_base.t - outer_space.t;
            bbox_outer.r = bbox_base.r + outer_space.r;
            bbox_outer.b = bbox_base.b + outer_space.b;
            
            bbox_inner.l = bbox_base.l + inner_space.l;
            bbox_inner.t = bbox_base.t + inner_space.t;
            bbox_inner.r = bbox_base.r - inner_space.r;
            bbox_inner.b = bbox_base.b - inner_space.b;
        }
    }
    
    /// @function update_from_bbox_inner()
    update_from_bbox_inner = function()
    {
        with(property)
        {
            bbox_base.l = bbox_inner.l - inner_space.l;
            bbox_base.t = bbox_inner.t - inner_space.t;
            bbox_base.r = bbox_inner.r + inner_space.r;
            bbox_base.b = bbox_inner.b + inner_space.b;
            
            bbox_outer.l = bbox_base.l - outer_space.l;
            bbox_outer.t = bbox_base.t - outer_space.t;
            bbox_outer.r = bbox_base.r + outer_space.r;
            bbox_outer.b = bbox_base.b + outer_space.b;
        }
    }
    
    #endregion
    
    #endregion
}