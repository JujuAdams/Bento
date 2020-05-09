/// @param sprite
/// @param scope
/// @param variableName
/// @param [templateName]

function bento_checkbox()
{
    var _sprite        = argument[0];
    var _scope         = argument[1];
    var _variable_name = argument[2];
    var _style         = (argument_count > 3)? argument[3] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the sprite we're using
        properties.width  = sprite_get_width( _sprite);
        properties.height = sprite_get_height(_sprite);
        
        //Set our sprite definition
        style.sprite.index = _sprite;
        style.sprite.image = 0;
        
        properties.checkbox = {
            scope : _scope,
            variable_name : _variable_name,
            state : false,
        };
        
        if (is_struct(_scope))
        {
            properties.checkbox.state = variable_struct_get(_scope, _variable_name);
        }
        else if (_scope == global)
        {
            properties.checkbox.state = variable_global_get(_variable_name);
        }
        else
        {
            properties.checkbox.state = variable_instance_get(id, _variable_name);
        }
        
        //Set draw method
        callback.draw = bento_draw_box;
        properties.internal_mouse_event = function(_event)
        {
            switch(_event)
            {
                case "leave": style.sprite.image = properties.checkbox.state? 3 : 0; break;
                case "enter": style.sprite.image = properties.checkbox.state? 4 : 1; break;
                
                case "pressed":
                    style.sprite.image = properties.checkbox.state? 5 : 2;
                break;
                
                case "released":
                    with(properties.checkbox)
                    {
                        if (is_struct(scope))
                        {
                            var _state = !variable_struct_get(scope, variable_name);
                            variable_struct_set(scope, variable_name, _state);
                        }
                        else if (scope == global)
                        {
                            var _state = !variable_global_get(variable_name);
                            variable_global_set(variable_name, _state);
                        }
                        else
                        {
                            var _state = !variable_instance_get(id, variable_name);
                            variable_instance_set(id, variable_name, _state);
                        }
                        
                        state = _state;
                    }
                    
                    style.sprite.image = ((properties.mouse.over)? 1 : 0) + (properties.checkbox.state? 3 : 0);
                break;
            }
        }
        
        return self;
    }
}