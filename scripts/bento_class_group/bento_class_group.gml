function bento_class_group() constructor
{
    l = 0;
    t = 0;
    r = 0;
    b = 0;
    
    children = [];
    
    /// @param element
    add = function(_element)
    {
        if (__bento_array_find(children, _element) < 0)
        {
            __bento_array_add(children, _element);
        }
        
        if (__bento_array_find(_element.alignment.children, self) < 0)
        {
            __bento_array_add(_element.alignment.children, self);
        }
    };
    
    update = function()
    {
        var _children_count = array_length(children);
        if (_children_count <= 0)
        {
            l = 0;
            t = 0;
            r = 0;
            b = 0;
        }
        else
        {
            l =  999999;
            t =  999999;
            r = -999999;
            b = -999999;
            
            var _i = 0;
            repeat(_children_count)
            {
                var _child = children[_i];
                if (instanceof(_child) == "bento_class_element")
                {
                    l = min(l, _child.property.bbox_outer.l);
                    t = min(t, _child.property.bbox_outer.t);
                    r = max(r, _child.property.bbox_outer.r);
                    b = max(b, _child.property.bbox_outer.b);
                    
                    ++_i;
                }
                else if (instanceof(_child) == "bento_class_group")
                {
                    l = min(l, _child.l);
                    t = min(t, _child.t);
                    r = max(r, _child.r);
                    b = max(b, _child.b);
                    
                    ++_i;
                }
                else
                {
                    children = __bento_array_delete(children, _i);
                }
            }
        }
    }
    
    draw = function()
    {
        bento_draw_rectangle(l, t, r, b, c_white, 1.0, 1);
    }
}