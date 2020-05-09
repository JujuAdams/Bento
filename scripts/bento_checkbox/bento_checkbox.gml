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
        
        //Set draw method
        callback.draw = bento_draw_box;
        properties.internal_tick = function()
        {
            with(properties.checkbox)
            {
                state = bento_variable_get(scope, variable_name);
            }
            
            var _image = 0;
            if (properties.mouse.over) _image = 1;
            if (properties.mouse.state) _image = 2;
            if (properties.checkbox.state) _image += 3;
            style.sprite.image = _image;
        };
        
        properties.internal_tick();
        
        properties.internal_mouse_event = function(_event)
        {
            if (_event == "released")
            {
                with(properties.checkbox)
                {
                    state = !state;
                    bento_variable_set(scope, variable_name, state);
                }
                
                properties.internal_tick();
            }
        }
        
        return self;
    }
}