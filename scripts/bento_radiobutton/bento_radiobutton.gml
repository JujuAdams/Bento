/// @param sprite
/// @param variableScope
/// @param variableName
/// @param value

function bento_radiobutton(_sprite, _variable_scope, _variable_name, _value)
{
    //Create and extend the basic sprite element
    with(bento_sprite(_sprite, 0))
    {
        //Make sure we set this radiobutton to interactive
        style.interactive = true;
        
        //Give ourselves some extra variables to use internally
        properties.radio_button = {
            variable_scope : _variable_scope,
            variable_name : _variable_name,
            value : _value,
            state : false,
        };
        
        //Set up an internal tick function
        properties.internal_tick = function()
        {
            //Update our state based on the variable we're tracking
            with(properties.radio_button)
            {
                state = (value == bento_variable_get(variable_scope, variable_name));
            }
            
            //Set our sprite image based on our internal values
            var _image = 0;
            if (properties.mouse.focus       ) _image  = 1;
            if (properties.mouse.state       ) _image  = 2;
            if (properties.radio_button.state) _image += 3;
            style.image = _image;
        };
        
        properties.internal_mouse_event = function(_event)
        {
            //When the sprite is clicked and released
            if (_event == "released")
            {
                with(properties.radio_button)
                {
                    //Update the variable we're tracking with our value
                    bento_variable_set(variable_scope, variable_name, value);
                }
            }
        }
        
        return self;
    }
}