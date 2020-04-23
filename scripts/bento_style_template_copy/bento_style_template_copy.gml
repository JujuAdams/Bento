/// @param templateName_or_style
/// @param [newTemplateName]

function bento_style_template_copy()
{
    var _src_style      = argument[0];
    var _new_style_name = (argument_count > 1)? argument[1] : undefined;
    
    if (_src_style == undefined)
    {
        var _new_style = new __bento_style_default();
    }
    else
    {
        var _name = _src_style;
        if (!is_struct(_src_style)) _src_style = bento_style_template(_name, true);
        if (_src_style == undefined)
        {
            throw "\n \nBento:\nStyle template \"" + string(_name) + "\" cannot be found\n ";
            return undefined;
        }
        
        var _new_style = __bento_deep_copy(_src_style);
    }
    
    if (_new_style_name != undefined) global.__bento_style_map[? _new_style_name] = _new_style;
    
    return _new_style;
}