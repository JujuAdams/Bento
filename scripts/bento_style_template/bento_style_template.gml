/// @param templateName
/// @param [getOnly]

global.__bento_style_map = ds_map_create();

function bento_style_template()
{
    var _name     = argument[0];
    var _get_only = (argument_count > 1)? argument[1] : false;
    
    var _style = global.__bento_style_map[? _name];
    if (!is_struct(_style))
    {
        if (_get_only)
        {
            if (BENTO_WARNING_STYLE_TEMPLATE_DOESNT_EXIST) show_debug_message("Bento: Style template \"" + string(_name) + "\" doesn't exist");
            return undefined;
        }
        else
        {
            _style = new __bento_style_default();
            global.__bento_style_map[? _name] = _style;
        }
    }
    
    return _style;
}