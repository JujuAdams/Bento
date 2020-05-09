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
        
        if (is_struct(_scope))
        {
            properties.radio_button.state = variable_struct_get(_scope, _variable_name);
        }
        else if (_scope == global)
        {
            properties.radio_button.state = variable_global_get(_variable_name);
        }
        else
        {
            properties.radio_button.state = variable_instance_get(id, _variable_name);
        }
        
        //Set draw method
        callback.draw = bento_draw_box;
        properties.internal_tick = function()
        {
            with(properties.radio_button)
            {
                var _new_state = state;
                if (is_struct(scope))
                {
                    _new_state = (value == variable_struct_get(scope, variable_name));
                }
                else if (scope == global)
                {
                    _new_state = (value == variable_global_get(variable_name));
                }
                else
                {
                    _new_state = (value == variable_instance_get(id, variable_name));
                }
            }
            
            if (_new_state != properties.radio_button.state)
            {
                properties.radio_button.state = _new_state;
                style.sprite.image = ((properties.mouse.over)? 1 : 0) + (_new_state? 3 : 0);
            }
        };
        
        properties.internal_mouse_event = function(_event)
        {
            switch(_event)
            {
                case "leave": style.sprite.image = (properties.radio_button.state)? 3 : 0; break;
                case "enter": style.sprite.image = (properties.radio_button.state)? 4 : 1; break;
                
                case "pressed":
                    style.sprite.image = (properties.radio_button.state)? 5 : 2;
                break;
                
                case "released":
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
                        
                        state = true;
                    }
                    
                    style.sprite.image = (properties.mouse.over)? 4 : 1;
                break;
            }
        }
        
        return self;
    }
}