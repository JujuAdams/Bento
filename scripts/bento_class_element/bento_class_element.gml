/// This is the base Bento element constructor; all elements should start with this constructor
/// 
/// The struct that this constructor creates has the following member variables. Named children must not replace any of the default member variables:
/// 
/// style            : <struct>    Contains visual formatting rules for the element
/// properties       : <struct>    Logical values, including mouse state, position, and dimensions
/// event            : <struct>    Struct of methods that dictate various element behaviours, including mouse callbacks and how the element is drawn
/// root             : <struct>    Bento struct, instanceof() == "bento_class_element"
/// parent           : <struct>    Bento struct, instanceof() == "bento_class_element"
/// children         : <array>     Array of children in the order they are to be drawn. The first element to be drawn is at array index 0
/// 
/// position_update() : <function>    
/// destroy()         : <function>    Marks this element *and all child elements* for destruction. The element won't necessarily be destroyed immediately
/// anchor_l(element) : <function>    
/// anchor_t(element) : <function>    
/// anchor_r(element) : <function>    
/// anchor_b(element) : <function> 
/// toString()        : <function>    Used internally by GameMaker to stringify this struct. toString() returns the long name (automatically generated) of this element

function bento_class_element() constructor
{
    children = [];
    
    style = {
        clip           : false,
        clip_new_frame : false,
        interactive    : false,
        
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
    }
    
    properties = {
        name              : "<element" + string(global.__bento_element_count) + ">",
        long_name         : "",
        
        visible    : true,
        deactivate : false,
        destroyed  : false,
        
        text   : "",
        width  : 0,
        height : 0,
        
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
        
        anchor_l : {
            box    : undefined,
            anchor : "right",
            offset : 0,
        },
        
        anchor_t : {
            box    : undefined,
            anchor : "bottom",
            offset : 0,
        },
        
        anchor_r : {
            box    : undefined,
            anchor : "left",
            offset : 0,
        },
        
        anchor_b : {
            box    : undefined,
            anchor : "top",
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
    
        root_tick : {
            focus        : undefined,
            prev_focus   : undefined,
            select_state : false,
        },
        
        internal_mouse_event : undefined,
        internal_tick        : undefined,
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
        
        mouse_event    : undefined,
    };
    
    #region Relationships between elements
    
    if (instanceof(other) == "bento_class_element")
    {
        __bento_array_add(other.children, self);
        
        root   = other.root;
        parent = other;
        
        properties.long_name = parent.properties.long_name + "." + properties.name;
    }
    else
    {
        root   = self;
        parent = undefined;
        
        properties.long_name = properties.name;
    }
    
    ++global.__bento_element_count;
    
    #endregion
    
    #region Methods
    
    /// @function destroy()
    destroy = function()
    {
        //Mark us as destroyed
        properties.destroyed = true;
        
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
        return properties.long_name;
    }
    
    /// @function layout_newline()
    layout_newline = function()
    {
        __bento_array_add(children, "__bento_layout_newline");
        return self;
    }
    
    #region Anchoring
    
    /// @function anchor_l(boxStruct, anchorSide, offset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param parentOffset
    /// @param childOffset
    anchor_l = function(_box, _anchor, _offset)
    {
        with(properties.anchor_l)
        {
            box    = _box;
            anchor = _anchor;
            offset = _offset;
        }
    }
    
    /// @function anchor_t(boxStruct, anchorSide, offset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param parentOffset
    /// @param childOffset
    anchor_t = function(_box, _anchor, _offset)
    {
        with(properties.anchor_t)
        {
            box    = _box;
            anchor = _anchor;
            offset = _offset;
        }
    }
    
    /// @function anchor_r(boxStruct, anchorSide, offset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param offset
    anchor_r = function(_box, _anchor, _offset)
    {
        with(properties.anchor_r)
        {
            box    = _box;
            anchor = _anchor;
            offset = _offset;
        }
    }
    
    /// @function anchor_bottom(boxStruct, anchorSide, offset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param offset
    anchor_b = function(_box, _anchor, _offset)
    {
        with(properties.anchor_b)
        {
            box    = _box;
            anchor = _anchor;
            offset = _offset;
        }
    }
    
    #endregion
    
    #region Position
    
    /// @function update_bbox_from_margin()
    update_bbox_from_margin = function()
    {
        var _margin  = style.margin;
        var _padding = style.padding;
        
        with(properties)
        {
            if (!is_struct(_margin))
            {
                bbox_padding.l = bbox_margin.l + _margin;
                bbox_padding.t = bbox_margin.t + _margin;
                bbox_padding.r = bbox_margin.r - _margin;
                bbox_padding.b = bbox_margin.b - _margin;
            }
            else
            {
                bbox_padding.l = bbox_margin.l + _margin.l;
                bbox_padding.t = bbox_margin.t + _margin.t;
                bbox_padding.r = bbox_margin.r - _margin.r;
                bbox_padding.b = bbox_margin.b - _margin.b;
            }
            
            if (!is_struct(_padding))
            {
                bbox_content.l = bbox_padding.l + _padding;
                bbox_content.t = bbox_padding.t + _padding;
                bbox_content.r = bbox_padding.r - _padding;
                bbox_content.b = bbox_padding.b - _padding;
            }
            else
            {
                bbox_content.l = bbox_padding.l + _padding.l;
                bbox_content.t = bbox_padding.t + _padding.t;
                bbox_content.r = bbox_padding.r - _padding.r;
                bbox_content.b = bbox_padding.b - _padding.b;
            }
        }
    }
    
    /// @function update_bbox_from_padding()
    update_bbox_from_padding = function()
    {
        var _margin  = style.margin;
        var _padding = style.padding;
        
        with(properties)
        {
            if (!is_struct(_margin))
            {
                bbox_margin.l = bbox_padding.l - _margin;
                bbox_margin.t = bbox_padding.t - _margin;
                bbox_margin.r = bbox_padding.r + _margin;
                bbox_margin.b = bbox_padding.b + _margin;
            }
            else
            {
                bbox_margin.l = bbox_padding.l - _margin.l;
                bbox_margin.t = bbox_padding.t - _margin.t;
                bbox_margin.r = bbox_padding.r + _margin.r;
                bbox_margin.b = bbox_padding.b + _margin.b;
            }
            
            if (!is_struct(_padding))
            {
                bbox_content.l = bbox_padding.l + _padding;
                bbox_content.t = bbox_padding.t + _padding;
                bbox_content.r = bbox_padding.r - _padding;
                bbox_content.b = bbox_padding.b - _padding;
            }
            else
            {
                bbox_content.l = bbox_padding.l + _padding.l;
                bbox_content.t = bbox_padding.t + _padding.t;
                bbox_content.r = bbox_padding.r - _padding.r;
                bbox_content.b = bbox_padding.b - _padding.b;
            }
        }
    }
    
    /// @function update_bbox_from_padding()
    update_bbox_from_content = function()
    {
        var _margin  = style.margin;
        var _padding = style.padding;
        
        with(properties)
        {
            if (!is_struct(_padding))
            {
                bbox_padding.l = bbox_content.l - _padding;
                bbox_padding.t = bbox_content.t - _padding;
                bbox_padding.r = bbox_content.r + _padding;
                bbox_padding.b = bbox_content.b + _padding;
            }
            else
            {
                bbox_padding.l = bbox_content.l - _padding.l;
                bbox_padding.t = bbox_content.t - _padding.t;
                bbox_padding.r = bbox_content.r + _padding.r;
                bbox_padding.b = bbox_content.b + _padding.b;
            }
            
            if (!is_struct(_margin))
            {
                bbox_margin.l = bbox_padding.l - _margin;
                bbox_margin.t = bbox_padding.t - _margin;
                bbox_margin.r = bbox_padding.r + _margin;
                bbox_margin.b = bbox_padding.b + _margin;
            }
            else
            {
                bbox_margin.l = bbox_padding.l - _margin.l;
                bbox_margin.t = bbox_padding.t - _margin.t;
                bbox_margin.r = bbox_padding.r + _margin.r;
                bbox_margin.b = bbox_padding.b + _margin.b;
            }
        }
    }
    
    #endregion
    
    #endregion
}