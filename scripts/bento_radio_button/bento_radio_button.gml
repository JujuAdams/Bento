/// @param sprite
/// @param scope
/// @param variableName
/// @param value
/// @param [templateName]

function bento_radio_button()
{
    var _sprite        = argument[0];
    var _scope         = argument[1];
    var _variable_name = argument[2];
    var _value         = argument[3];
    var _style         = (argument_count > 4)? argument[4] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the sprite we're using
        properties.width  = sprite_get_width( _sprite);
        properties.height = sprite_get_height(_sprite);
        
        //Set our sprite definition
        style.sprite.index = _sprite;
        style.sprite.image = 0;
        
        properties.radio_button = {
            scope : _scope,
            variable_name : _variable_name,
            value : _value,
            state : false,
        };
        
        //Set draw method
        callback.draw = bento_draw_box;
        properties.internal_tick = function()
        {
            with(properties.radio_button)
            {
                if (is_struct(scope))
                {
                    state = (value == variable_struct_get(scope, variable_name));
                }
                else if (scope == global)
                {
                    state = (value == variable_global_get(variable_name));
                }
                else
                {
                    state = (value == variable_instance_get(id, variable_name));
                }
            }
            
            var _image = 0;
            if (properties.mouse.over) _image = 1;
            if (properties.mouse.state) _image = 2;
            if (properties.radio_button.state) _image += 3;
            style.sprite.image = _image;
        };
        
        properties.internal_mouse_event = function(_event)
        {
            if (_event == "released")
            {
                with(properties.radio_button)
                {
                    if (is_struct(scope))
                    {
                        variable_struct_set(scope, variable_name, value);
                    }
                    else if (scope == global)
                    {
                        variable_global_set(variable_name, value);
                    }
                    else
                    {
                        variable_instance_set(id, variable_name, value);
                    }
                }
            }
        }
        
        properties.internal_tick();
        
        return self;
    }
}