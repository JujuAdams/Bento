/// @param scope
/// @param variableName
/// @param width
/// @param [templateName]

function bento_textbox_string()
{
    var _scope         = argument[0];
    var _variable_name = argument[1];
    var _width         = argument[2];
    var _style         = (argument_count > 3)? argument[3] : undefined;
    
    with(new bento_element_class())
    {
        //Set some style variables specific to this kind of element
        with(style)
        {
            color = c_white;
            alpha = 1.0;
            
            textbox = {
                font : -1,
                halign : fa_left,
                scope : _scope,
                variable_name : _variable_name,
            };
            
            with(padding)
            {
                l = 3;
                t = 3;
                r = 3;
                b = 3;
            }
        }
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions based on the size of our text in the given font
        var _old_font = draw_get_font();
        draw_set_font(style.textbox.font);
        properties.width  = _width;
        properties.height = string_height("\n");
        draw_set_font(_old_font);
        
        position_update();
        update_bbox_from_content();
        
        //Set draw method
        callback.draw = bento_draw_textbox;
        
        return self;
    }
}

function bento_draw_textbox()
{
    var _bbox_padding = properties.bbox_padding;
    var _bbox_content = properties.bbox_content;
    
    with(style)
    {
        //Draw the bounding rectangle
        bento_draw_rectangle(_bbox_padding.l, _bbox_padding.t,
                             _bbox_padding.r, _bbox_padding.b,
                             c_black, 1.0, 0);
        
        //Draw the text
        var _content = bento_variable_get(textbox.scope, textbox.variable_name);
        if ((alpha > 0.0) && (_content != ""))
        {
            draw_set_font(textbox.font);
            draw_set_colour(color);
            draw_set_alpha(alpha);
            var _halign = textbox.halign;
            draw_set_halign(_halign);
            draw_set_valign(fa_middle);
            
            if (_halign == fa_center)
            {
                var _x = (_bbox_content.l + _bbox_content.r)/2;
            }
            else if (_halign == fa_right)
            {
                var _x = _bbox_content.r;
            }
            else
            {
                var _x = _bbox_content.l;
            }
            
            draw_text(_x, (_bbox_content.t + _bbox_content.b)/2, _content);
        }
    }
    
    bento_draw_rectangle(_bbox_padding.l, _bbox_padding.t,
                         _bbox_padding.r, _bbox_padding.b,
                         c_white, 1.0, 1);
}