/// @param string
/// @param [templateName]

function bento_text()
{
    var _text  = argument[0];
    var _style = (argument_count > 1)? argument[1] : undefined;
    
    with(new bento_element_class())
    {
        //Set some style variables specific to this kind of element
        with(style)
        {
            text = {
                font   : -1,
                halign : fa_left,
                valign : fa_top,
                color  : c_white,
                alpha  : 1.0,
            };
        }
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions based on the size of our text in the given font
        var _old_font = draw_get_font();
        draw_set_font(style.text.font);
        properties.width  = string_width( _text);
        properties.height = string_height(_text);
        draw_set_font(_old_font);
        
        //Set our text definition
        properties.text = _text;
        
        //Set draw method
        callback.draw = bento_draw_text;
        
        return self;
    }
}

function bento_draw_text()
{
    //Draw the text
    var _text = style.text;
    if ((_text.alpha > 0.0) && (properties.text != ""))
    {
        var _bbox_padding = properties.bbox_padding;
        
        draw_set_font(_text.font);
        draw_set_colour(_text.color);
        draw_set_alpha(_text.alpha);
        draw_set_halign(_text.halign);
        draw_set_valign(_text.valign);
        
        if (_text.halign == fa_center)
        {
            var _x = (_bbox_padding.l + _bbox_padding.r)/2;
        }
        else if (_text.halign == fa_right)
        {
            var _x = _bbox_padding.r;
        }
        else
        {
            var _x = _bbox_padding.l;
        }
        
        if (_text.halign == fa_middle)
        {
            var _y = (_bbox_padding.t + _bbox_padding.b)/2;
        }
        else if (_text.halign == fa_bottom)
        {
            var _y = _bbox_padding.b;
        }
        else
        {
            var _y = _bbox_padding.t;
        }
        
        draw_text(_x, _y, properties.text);
    }
}