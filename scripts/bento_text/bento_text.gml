/// @param string
/// @param [templateName]

function bento_text()
{
    var _text  = argument[0];
    var _style = (argument_count > 1)? argument[1] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the size of our text in the given font
        var _old_font = draw_get_font();
        draw_set_font(style.text.font);
        properties.width  = string_width( _text);
        properties.height = string_height(_text);
        draw_set_font(_old_font);
        
        //Set our text definition
        properties.text = _text;
        
        //Set draw method
        callback.draw = bento_draw_box;
        
        return self;
    }
}