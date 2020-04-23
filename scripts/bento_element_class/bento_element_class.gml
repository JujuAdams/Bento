/// @param [styleTemplateName]

/// This is the base Bento element constructor; all elements should start with this constructor
/// 
/// The struct that this constructor creates has the following member variables. Named children must not replace any of the default member variables:
/// 
/// style            : <struct>    Contains visual formatting rules for the element
/// properties       : <struct>    Logical values, including mouse state, position, and dimensions
/// callbacks        : <struct>    Struct of methods that dictate various element behaviours, including mouse callbacks and how the element is drawn
/// root             : <struct>    Bento struct, instanceof() == "bento_element_class"
/// parent           : <struct>    Bento struct, instanceof() == "bento_element_class"
/// children         : <array>     Array of children in the order they are to be drawn. The first element to be drawn is at array index 0
/// mouse_over_array : <array>     Array of child elements that the mouse is over. This array only exists on root elements
/// 
/// add(element)           : <function>    Attaches the specified element to this element as a child
/// add_at(element)        : <function>   
/// position_update()      : <function>    
/// destroy()              : <function>    Marks this element *and all child elements* for destruction. The element won't necessarily be destroyed immediately
/// anchor_left(element)   : <function>    
/// anchor_top(element)    : <function>    
/// anchor_right(element)  : <function>    
/// anchor_bottom(element) : <function> 
/// toString()             : <function>    Used internally by GameMaker to stringify this struct. toString() returns the long name (automatically generated) of this element

function bento_element_class() constructor
{
    #region Set style from template
    
    var _style = (argument_count > 0)? argument[0] : undefined;
    
    if (BENTO_STYLE_TEMPLATE_DEFAULT_BY_REFERENCE)
    {
        style = bento_style_template(_style);
    }
    else
    {
        style = bento_style_template_copy(_style);
    }
    
    #endregion
    
    #region Properties
    
    properties = {
        name              : "<element" + string(global.__bento_element_count) + ">",
        long_name         : "",
        bento_layout_auto : false,
        
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
        
        anchor_left : {
            box           : undefined,
            anchor        : "left",
            parent_offset : 0,
            child_offset  : 0,
        },
        
        anchor_top : {
            box           : undefined,
            anchor        : "top",
            parent_offset : 0,
            child_offset  : 0,
        },
        
        anchor_right : {
            box           : undefined,
            anchor        : "left",
            parent_offset : 0,
            child_offset  : 0,
        },
        
        anchor_bottom : {
            box           : undefined,
            anchor        : "top",
            parent_offset : 0,
            child_offset  : 0,
        },
        
        mouse : {
            over       : false,
            state      : false,
            pressed    : false,
            released   : false,
            pressed_dx : 0,
            pressed_dy : 0,
        },
    };
    
    #endregion
    
    #region Callbacks
    
    callbacks = {
        tick           : undefined, //TODO
        
        draw_begin     : undefined, //Before clipping frame is pushed (usually this means we're clipped to our parent's frame)
        draw           : undefined, //After clipping, before children
        draw_end       : undefined, //After children, before clipping frame is popped
        
        mouse_check    : undefined, //If this function is <undefined> then __bento_mouse_check_aabb() is used instead
                                    //To turn off mouse checking for an element, set properties.interactive to <false>
        
        mouse_enter    : undefined,
        mouse_over     : undefined,
        mouse_leave    : undefined,
        mouse_pressed  : undefined,
        mouse_down     : undefined,
        mouse_released : undefined,
        mouse_wheel_u  : undefined,
        mouse_wheel_d  : undefined,
        
        mouse_event    : undefined,
    };
    
    #endregion
    
    //Relationships between elements
    children = [];
    
    if (instanceof(other) == "bento_element_class")
    {
        other.children[@ array_length(other.children)] = self;
        
        root   = other.root;
        parent = other;
        if (other.style.layout != "none") properties.bento_layout_auto = true;
        
        properties.long_name = parent.properties.long_name + "." + properties.name;
        
        place(0, 0);
    }
    else
    {
        root   = self;
        parent = undefined;
        
        properties.long_name = properties.name;
    }
    
    //Internal Bento stuff
    ++global.__bento_element_count;
    
    #region Methods
    
    /// @function set_name(string)
    /// @param string
    static set_name = function(_string)
    {
        properties.bento_name = _string;
        
        if (instanceof(parent) == "bento_element_class")
        {
            variable_struct_set(parent, _string, self);
            properties.long_name = parent.properties.long_name + "." + _string;
        }
        else
        {
            properties.long_name = _string;
        }
        
        return self;
    };
    
    #region Layouts
    
    /// @function layout_grid(columnSizes, rowSizes)
    /// @param columnSizes
    /// @param rowSizes
    static layout_grid = function(_columns, _rows)
    {
        if (!is_array(_columns) || !is_array(_rows)) throw "Bento: Column and row definitions must be arrays";
        
        with(style)
        {
            layout       = "grid";
            grid.columns = _columns;
            grid.rows    = _rows;
        }
        
        return self;
    }
    
    /// @function layout_flexbox()
    static layout_flexbox = function()
    {
        style.layout = "flexbox";
        return self;
    }
    
    /// @function layout_newline()
    static layout_newline = function()
    {
        children[@ array_length(children)] = "__bento_layout_newline";
        return self;
    }
    
    #endregion
    
    #region Anchoring
    
    /// @function place(left, top)
    /// @param left
    /// @param top
    static place = function(_left, _top)
    {
        if (instanceof(parent) == "bento_element_class")
        {
            anchor_left(parent.properties.bbox_content, "left", _left, 0);
            anchor_top( parent.properties.bbox_content, "top" , _top , 0);
        }
        
        return self;
    };
    
    /// @function anchor_left(boxStruct, anchorSide, parentOffset, childOffset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param parentOffset
    /// @param childOffset
    static anchor_left = function(_box, _anchor, _parent_offset, _child_offset)
    {
        with(properties.anchor_left)
        {
            box           = _box;
            anchor        = _anchor;
            parent_offset = _parent_offset;
            child_offset  = _child_offset;
        }
    }
    
    /// @function anchor_top(boxStruct, anchorSide, parentOffset, childOffset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param parentOffset
    /// @param childOffset
    static anchor_top = function(_box, _anchor, _parent_offset, _child_offset)
    {
        with(properties.anchor_top)
        {
            box           = _box;
            anchor        = _anchor;
            parent_offset = _parent_offset;
            child_offset  = _child_offset;
        }
    }
    
    /// @function anchor_right(boxStruct, anchorSide, parentOffset, childOffset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param parentOffset
    /// @param childOffset
    static anchor_right = function(_box, _anchor, _parent_offset, _child_offset)
    {
        with(properties.anchor_right)
        {
            box           = _box;
            anchor        = _anchor;
            parent_offset = _parent_offset;
            child_offset  = _child_offset;
        }
    }
    
    /// @function anchor_bottom(boxStruct, anchorSide, parentOffset, childOffset)
    /// @param boxStruct
    /// @param anchorSide
    /// @param parentOffset
    /// @param childOffset
    static anchor_bottom = function(_box, _anchor, _parent_offset, _child_offset)
    {
        with(properties.anchor_bottom)
        {
            box           = _box;
            anchor        = _anchor;
            parent_offset = _parent_offset;
            child_offset  = _child_offset;
        }
    }
    
    #endregion
    
    /// @function position_update()
    static position_update = function()
    {
        var _actual_w = __bento_resolve_width();
        var _actual_h = __bento_resolve_height();
        
        var _margin = style.margin;
        var _padding = style.padding;
        
        with(properties)
        {
            if (!bento_layout_auto)
            {
                var _box_l = anchor_left.box;
                var _box_t = anchor_top.box;
                var _box_r = anchor_right.box;
                var _box_b = anchor_bottom.box;
                
                var _anchored_l = is_struct(_box_l);
                var _anchored_t = is_struct(_box_t);
                var _anchored_r = is_struct(_box_r);
                var _anchored_b = is_struct(_box_b);
                
                if (_anchored_l)
                {
                    if (BENTO_WARNING_ANCHOR_NOT_BOUNDING_BOX
                    && (!variable_struct_exists(_box_l, "l")
                     || !variable_struct_exists(_box_l, "t")
                     || !variable_struct_exists(_box_l, "r")
                     || !variable_struct_exists(_box_l, "b")))
                    {
                        if (BENTO_ANCHOR_ALLOW_ELEMENTS && (instanceof(_box_l) == "bento_element_class"))
                        {
                            _box_l = _box_l.properties.bbox_content;
                        }
                        else
                        {
                            throw "\n \nBento:\nLeft anchor of " + string(other) + "\nStruct passed into anchor should be a bounding box e.g.\n<element>.properties.bbox_content\n<element>.properties.bbox_padding\n<element>.properties.bbox_margin\n ";
                        }
                    }
                
                    switch(anchor_left.anchor)
                    {
                        case "l": case "left":  case "start":                                var _a =  _box_l.l;               break;
                        case "c": case "m":     case "center": case "centre": case "middle": var _a = (_box_l.l + _box_l.r)/2; break;
                        case "r": case "right": case "end":                                  var _a =  _box_l.r;               break;
                        default: throw "Bento: Anchor type \"" + string(anchor_left.anchor) + "\" not recognised for left anchor\n "; break;
                    }
                
                    bbox_margin.l = _a + __bento_width_perc(_box_l, anchor_left.parent_offset) + __bento_width_perc(_actual_w, anchor_left.child_offset);
                    if (!_anchored_r) bbox_margin.r = bbox_margin.l + _actual_w;
                }
                
                if (_anchored_t)
                {
                    if (BENTO_WARNING_ANCHOR_NOT_BOUNDING_BOX
                    && (!variable_struct_exists(_box_t, "l")
                     || !variable_struct_exists(_box_t, "t")
                     || !variable_struct_exists(_box_t, "r")
                     || !variable_struct_exists(_box_t, "b")))
                    {
                        if (BENTO_ANCHOR_ALLOW_ELEMENTS && (instanceof(_box_t) == "bento_element_class"))
                        {
                            _box_t = _box_t.properties.bbox_content;
                        }
                        else
                        {
                            throw "\n \nBento:\nTop anchor of " + string(other) + "\nStruct passed into anchor should be a bounding box e.g.\n<element>.properties.bbox_content\n<element>.properties.bbox_padding\n<element>.properties.bbox_margin\n ";
                        }
                    }
                
                    switch(anchor_top.anchor)
                    {
                        case "t": case "top":    case "start":                                var _a =  _box_t.t;               break;
                        case "c": case "m":      case "center": case "centre": case "middle": var _a = (_box_t.t + _box_t.b)/2; break;
                        case "b": case "bottom": case "end":                                  var _a =  _box_t.b;               break;
                        default: throw "Bento: Anchor type \"" + string(anchor_top.anchor) + "\" not recognised for top anchor\n "; break;
                    }
                
                    bbox_margin.t = _a + __bento_height_perc(_box_t, anchor_top.parent_offset) + __bento_height_perc(_actual_h, anchor_top.child_offset);
                    if (!_anchored_b) bbox_margin.b = bbox_margin.t + _actual_h;
                }
                
                if (_anchored_r)
                {
                    if (BENTO_WARNING_ANCHOR_NOT_BOUNDING_BOX
                    && (!variable_struct_exists(_box_r, "l")
                     || !variable_struct_exists(_box_r, "t")
                     || !variable_struct_exists(_box_r, "r")
                     || !variable_struct_exists(_box_r, "b")))
                    {
                        if (BENTO_ANCHOR_ALLOW_ELEMENTS && (instanceof(_box_r) == "bento_element_class"))
                        {
                            _box_r = _box_r.properties.bbox_content;
                        }
                        else
                        {
                            throw "\n \nBento:\nRight anchor of " + string(other) + "\nStruct passed into anchor should be a bounding box e.g.\n<element>.properties.bbox_content\n<element>.properties.bbox_padding\n<element>.properties.bbox_margin\n ";
                        }
                    }
                
                    switch(anchor_right.anchor)
                    {
                        case "l": case "left":  case "start":                                var _a =  _box_r.l;               break;
                        case "c": case "m":     case "center": case "centre": case "middle": var _a = (_box_r.l + _box_r.r)/2; break;
                        case "r": case "right": case "end":                                  var _a =  _box_r.r;               break;
                        default: throw "Bento: Anchor type \"" + string(anchor_right.anchor) + "\" not recognised for right anchor\n "; break;
                    }
                
                    bbox_margin.r = _a + __bento_width_perc(_box_r, anchor_right.parent_offset) + __bento_width_perc(_actual_w, anchor_right.child_offset);
                    if (!_anchored_l) bbox_margin.l = bbox_margin.r - _actual_w;
                }
                
                if (_anchored_b)
                {
                    if (BENTO_WARNING_ANCHOR_NOT_BOUNDING_BOX
                    && (!variable_struct_exists(_box_b, "l")
                     || !variable_struct_exists(_box_b, "t")
                     || !variable_struct_exists(_box_b, "r")
                     || !variable_struct_exists(_box_b, "b")))
                    {
                        if (BENTO_ANCHOR_ALLOW_ELEMENTS && (instanceof(_box_b) == "bento_element_class"))
                        {
                            _box_b = _box_b.properties.bbox_content;
                        }
                        else
                        {
                            throw "\n \nBento:\nBottom anchor of " + string(other) + "\nStruct passed into anchor should be a bounding box e.g.\n<element>.properties.bbox_content\n<element>.properties.bbox_padding\n<element>.properties.bbox_margin\n ";
                        }
                    }
                
                    switch(anchor_bottom.anchor)
                    {
                        case "t": case "top":    case "start":                                var _a =  _box_b.t;               break;
                        case "c": case "m":      case "center": case "centre": case "middle": var _a = (_box_b.t + _box_b.b)/2; break;
                        case "b": case "bottom": case "end":                                  var _a =  _box_b.b;               break;
                        default: throw "Bento: Anchor type \"" + string(anchor_bottom.anchor) + "\" not recognised for bottom anchor\n "; break;
                    }
                
                    bbox_margin.b = _a + __bento_height_perc(_box_b, anchor_bottom.parent_offset) + __bento_height_perc(_actual_h, anchor_bottom.child_offset);
                    if (!_anchored_t) bbox_margin.t = bbox_margin.b - _actual_h;
                }
                
                if (!_anchored_l && !_anchored_r) bbox_margin.r = bbox_margin.l + _actual_w;
                if (!_anchored_t && !_anchored_b) bbox_margin.b = bbox_margin.t + _actual_h;
            }
            
            if (!is_struct(_margin))
            {
                bbox_padding.l = bbox_margin.l - _margin;
                bbox_padding.t = bbox_margin.t - _margin;
                bbox_padding.r = bbox_margin.r + _margin;
                bbox_padding.b = bbox_margin.b + _margin;
            }
            else
            {
                bbox_padding.l = bbox_margin.l - _margin.l;
                bbox_padding.t = bbox_margin.t - _margin.t;
                bbox_padding.r = bbox_margin.r + _margin.r;
                bbox_padding.b = bbox_margin.b + _margin.b;
            }
            
            if (!is_struct(_padding))
            {
                bbox_content.l = bbox_padding.l - _padding;
                bbox_content.t = bbox_padding.t - _padding;
                bbox_content.r = bbox_padding.r + _padding;
                bbox_content.b = bbox_padding.b + _padding;
            }
            else
            {
                bbox_content.l = bbox_padding.l - _padding.l;
                bbox_content.t = bbox_padding.t - _padding.t;
                bbox_content.r = bbox_padding.r + _padding.r;
                bbox_content.b = bbox_padding.b + _padding.b;
            }
        }
    }
    
    /// @function destroy()
    static destroy = function()
    {
        //Mark us as destroyed
        properties.destroyed = true;
        
        //Mark our children as destroyed too
        var _i = 0;
        repeat(array_length(children))
        {
            var _child = children[_i];
            if (instanceof(_child) == "bento_element_class") _child.destroy();
            ++_i;
        }
    }
    
    /// string() behaviour
    static toString = function()
    {
        return properties.long_name;
    }
    
    #endregion
}