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
        
        width  : 0,
        height : 0,
        color  : c_white,
        alpha  : 1.0,
        
        margin : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        padding : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        
        bbox_content : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        bbox_padding : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        bbox_margin : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
        
        align_l : {
            target : undefined,
            offset : 0,
        },
        align_t : {
            target : undefined,
            offset : 0,
        },
        align_r : {
            target : undefined,
            offset : 0,
        },
        align_b : {
            target : undefined,
            offset : 0,
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
    bento_prev = self;
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
    
    #region Methods
    
    /// @function layout_update()
    layout_update = function()
    {
        var _static_margin_w = property.width  + property.margin.l + property.margin.r;
        var _static_margin_h = property.height + property.margin.t + property.margin.b;
        
        var _root_content = root.property.bbox_content;
        var _root_w = 1 + _root_content.r - _root_content.l;
        var _root_h = 1 + _root_content.r - _root_content.l;
        
        var _align = property.align_l;
        var _target = _align.target;
        if (is_struct(_target))
        {
            if (instanceof(_target) == "bento_class_element")
            {
                if (parent == _target)
                {
                    //If our parent is the target, use the content bbox
                    _target = _target.property.bbox_content;
                }
                else
                {
                    //If our parent is the target, use the margin bbox
                    _target = _target.property.bbox_margin;
                }
            }
            
            property.bbox_margin.l = _target.l +
                                     __bento_parse_offset(_static_margin_w,
                                                          1 + _target.r - _target.l,
                                                          _root_w, _align.offset);
        }
        
        var _align = property.align_t;
        var _target = _align.target;
        if (is_struct(_target))
        {
            if (instanceof(_target) == "bento_class_element")
            {
                if (parent == _target)
                {
                    //If our parent is the target, use the content bbox
                    _target = _target.property.bbox_content;
                }
                else
                {
                    //If our parent is the target, use the margin bbox
                    _target = _target.property.bbox_margin;
                }
            }
            
            property.bbox_margin.t = _target.t +
                                     __bento_parse_offset(_static_margin_h,
                                                          1 + _target.b - _target.t,
                                                          _root_h, _align.offset);
        }
        
        var _align = property.align_r;
        var _target = _align.target;
        if (is_struct(_target))
        {
            if (instanceof(_target) == "bento_class_element")
            {
                if (parent == _target)
                {
                    //If our parent is the target, use the content bbox
                    _target = _target.property.bbox_content;
                }
                else
                {
                    //If our parent is the target, use the margin bbox
                    _target = _target.property.bbox_margin;
                }
            }
            
            property.bbox_margin.r = _target.l +
                                     __bento_parse_offset(_static_margin_w,
                                                          1 + _target.r - _target.l,
                                                          _root_w, _align.offset);
        }
        else
        {
            property.bbox_margin.r = property.bbox_margin.l + _static_margin_w;
        }
        
        var _align = property.align_b;
        var _target = _align.target;
        if (is_struct(_target))
        {
            if (instanceof(_target) == "bento_class_element")
            {
                if (parent == _target)
                {
                    //If our parent is the target, use the content bbox
                    _target = _target.property.bbox_content;
                }
                else
                {
                    //If our parent is the target, use the margin bbox
                    _target = _target.property.bbox_margin;
                }
            }
            
            property.bbox_margin.b = _target.t +
                                     __bento_parse_offset(_static_margin_h,
                                                          1 + _target.b - _target.t,
                                                          _root_h, _align.offset);
        }
        else
        {
            property.bbox_margin.b = property.bbox_margin.t + _static_margin_h;
        }
        
        update_bbox_from_margin();
        
        var _i = 0;
        repeat(array_length(children))
        {
            var _child = children[_i];
            if (instanceof(_child) == "bento_class_element") with(_child) layout_update();
            ++_i;
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
    
    /// @function align_l_to_target_l(target, offset)
    /// @param target
    /// @param offset
    align_l_to_target_l = function(_target, _offset)
    {
        with(property.align_l)
        {
            target = _target;
            offset = _offset;
        }
    }
    
    /// @function align_l_to_target_r(target, offset)
    /// @param target
    /// @param offset
    align_l_to_target_r = function(_target, _offset)
    {
        with(property.align_l)
        {
            target = _target;
            offset = string(_offset) + "+100%T";
        }
    }
    
    /// @function align_t_to_target_t(target, offset)
    /// @param target
    /// @param offset
    align_t_to_target_t = function(_target, _offset)
    {
        with(property.align_t)
        {
            target = _target;
            offset = _offset;
        }
    }
    
    /// @function align_t_to_target_b(target, offset)
    /// @param target
    /// @param offset
    align_t_to_target_b = function(_target, _offset)
    {
        with(property.align_t)
        {
            target = _target;
            offset = string(_offset) + "+100%T";
        }
    }
    
    /// @function align_r_to_target_r(target, offset)
    /// @param target
    /// @param offset
    align_r_to_target_r = function(_target, _offset)
    {
        with(property.align_r)
        {
            target = _target;
            offset = _offset;
        }
    }
    
    /// @function align_r_to_target_l(target, offset)
    /// @param target
    /// @param offset
    align_r_to_target_l = function(_target, _offset)
    {
        with(property.align_r)
        {
            target = _target;
            offset = string(_offset) + "-100%T";
        }
    }
    
    /// @function align_b_to_target_b(target, offset)
    /// @param target
    /// @param offset
    align_b_to_target_b = function(_target, _offset)
    {
        with(property.align_b)
        {
            target = _target;
            offset = _offset;
        }
    }
    
    /// @function align_b_to_target_t(target, offset)
    /// @param target
    /// @param offset
    align_b_to_target_t = function(_target, _offset)
    {
        with(property.align_b)
        {
            target = _target;
            offset = string(_offset) + "-100%T";
        }
    }
    
    /// @function align_x_to_target_x(target, offset)
    /// @param target
    /// @param offset
    align_x_to_target_x = function(_target, _offset)
    {
        with(property.align_l)
        {
            target = _target;
            offset = string(_offset) + "+50%T-50%";
        }
        
        with(property.align_r)
        {
            target = _target;
            offset = string(_offset) + "+50%T+50%";
        }
    }
    
    /// @function align_y_to_target_y(target, offset)
    /// @param target
    /// @param offset
    align_y_to_target_y = function(_target, _offset)
    {
        with(property.align_t)
        {
            target = _target;
            offset = string(_offset) + "+50%T-50%";
        }
        
        with(property.align_b)
        {
            target = _target;
            offset = string(_offset) + "+50%T+50%";
        }
    }
    
    #endregion
    
    #region Bounding box updates
    
    /// @function update_bbox_from_margin()
    update_bbox_from_margin = function()
    {
        with(property)
        {
            bbox_padding.l = bbox_margin.l + margin.l;
            bbox_padding.t = bbox_margin.t + margin.t;
            bbox_padding.r = bbox_margin.r - margin.r;
            bbox_padding.b = bbox_margin.b - margin.b;
            
            bbox_content.l = bbox_padding.l + padding.l;
            bbox_content.t = bbox_padding.t + padding.t;
            bbox_content.r = bbox_padding.r - padding.r;
            bbox_content.b = bbox_padding.b - padding.b;
        }
    }
    
    /// @function update_bbox_from_padding()
    update_bbox_from_padding = function()
    {
        with(property)
        {
            bbox_margin.l = bbox_padding.l - margin.l;
            bbox_margin.t = bbox_padding.t - margin.t;
            bbox_margin.r = bbox_padding.r + margin.r;
            bbox_margin.b = bbox_padding.b + margin.b;
            
            bbox_content.l = bbox_padding.l + padding.l;
            bbox_content.t = bbox_padding.t + padding.t;
            bbox_content.r = bbox_padding.r - padding.r;
            bbox_content.b = bbox_padding.b - padding.b;
        }
    }
    
    /// @function update_bbox_from_padding()
    update_bbox_from_content = function()
    {
        with(property)
        {
            bbox_padding.l = bbox_content.l - padding.l;
            bbox_padding.t = bbox_content.t - padding.t;
            bbox_padding.r = bbox_content.r + padding.r;
            bbox_padding.b = bbox_content.b + padding.b;
            
            bbox_margin.l = bbox_padding.l - margin.l;
            bbox_margin.t = bbox_padding.t - margin.t;
            bbox_margin.r = bbox_padding.r + margin.r;
            bbox_margin.b = bbox_padding.b + margin.b;
        }
    }
    
    #endregion
    
    #endregion
}