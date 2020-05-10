/// @param element
/// @param templateName

function bento_style_template_apply(_element, _template_name)
{
    if (is_array(_template_name))
    {
        var _i = 0;
        repeat(array_length(_template_name))
        {
            bento_style_template_apply(_element, _template_name[_i]);
            ++_i;
        }
    }
    else
    {
        var _template = bento_style_template(_template_name, true);
        if (_template == undefined) exit;
        __bento_style_template_apply_struct(_template, _element.style);
    }
}

function __bento_style_template_apply_struct(_source, _target)
{
    var _names = variable_struct_get_names(_source);
    var _i = 0;
    repeat(array_length(_names))
    {
        var _name = _names[_i];
        if (string_pos("___struct___", _name) <= 0) //TODO - This fixes a bug in GM
        {
            var _value = variable_struct_get(_source, _name);
            if (is_struct(_value))
            {
                if (variable_struct_exists(_target, _name))
                {
                    __bento_style_template_apply_struct(_value, variable_struct_get(_target, _name));
                }
                else
                {
                    variable_struct_set(_target, _name, __bento_deep_copy(_value));
                }
            }
            else if (is_array(_value))
            {
                var _array = array_create(array_length(_value));
                array_copy(_array, 0, _value, 0, array_length(_value));
                variable_struct_set(_target, _name, _array);
            }
            else if (_value != undefined)
            {
                variable_struct_set(_target, _name, _value);
            }
        }
            
        ++_i;
    }
}