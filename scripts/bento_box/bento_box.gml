/// @param [width]
/// @param [height]
/// @param [templateName]

function bento_box()
{
    var _width  = (argument_count > 0)? argument[0] : "auto";
    var _height = (argument_count > 1)? argument[1] : "auto";
    var _style  = (argument_count > 2)? argument[2] : undefined;
    
    with(new bento_element_class())
    {
        //Set some style variables specific to this kind of element
        with(style)
        {
            color = c_white;
            alpha = 0.0;
            
            outline_color = c_white;
            outline_alpha = 0.0;
            outline_thickness = 1.0;
        }
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions
        properties.width  = _width;
        properties.height = _height;
        
        //Set draw method
        callback.draw = bento_draw_box;
        
        return self;
    }
}

function bento_draw_box()
{
    var _bbox_padding = properties.bbox_padding;
    with(style)
    {
        //Background fill
        bento_draw_rectangle(_bbox_padding.l, _bbox_padding.t,
                                _bbox_padding.r, _bbox_padding.b,
                                color, alpha, 0);
        
        //Outline
        if (outline_thickness > 0.0)
        {
            bento_draw_rectangle(_bbox_padding.l, _bbox_padding.t,
                                 _bbox_padding.r, _bbox_padding.b,
                                 outline_color, outline_alpha,
                                 outline_thickness);
        }
    }
}