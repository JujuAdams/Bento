/// @param string

function bento_text(_text)
{
    with(new bento_class_element())
    {
        //Set some style variables specific to this kind of element
        with(property)
        {
            text        = _text;
            text_font   = -1;
            text_halign = fa_left;
            text_valign = fa_top;
            
            //Set our dimensions based on the size of our text in the given font
            var _old_font = draw_get_font();
            draw_set_font(text_font);
            width  = string_width(_text);
            height = string_height(_text);
            draw_set_font(_old_font);
        }
        
        //Set draw method
        event.draw = bento_draw_text;
        
        return self;
    }
}

function bento_draw_text()
{
    //Draw the text
    with(property)
    {
        if ((alpha > 0.0) && (text != ""))
        {
            draw_set_font(text_font);
            draw_set_colour(color);
            draw_set_alpha(alpha);
            draw_set_halign(text_halign);
            draw_set_valign(text_valign);
            
            if (text_halign == fa_center)
            {
                var _x = (bbox_base.l + bbox_base.r)/2;
            }
            else if (text_halign == fa_right)
            {
                var _x = bbox_base.r;
            }
            else
            {
                var _x = bbox_base.l;
            }
            
            if (text_valign == fa_middle)
            {
                var _y = (bbox_base.t + bbox_base.b)/2;
            }
            else if (text_valign == fa_bottom)
            {
                var _y = bbox_base.b;
            }
            else
            {
                var _y = bbox_base.t;
            }
            
            draw_text(_x, _y, text);
        }
    }
}