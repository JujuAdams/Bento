/// @param sprite
/// @param variableScope
/// @param variableName

function bento_checkbox(_sprite, _variable_scope, _variable_name)
{
    //Create and extend the basic sprite element
    with(bento_sprite(_sprite, 0))
    {
        with(property)
        {
            //Make sure we set this checkbox to interactive
            interactive = true;
            
            //Give ourselves some extra variables to use internally
            variable_scope = _variable_scope;
            variable_name  = _variable_name;
            state          = false;
            
            //Set up an internal tick function
            fixed_tick = function()
            {
                with(property)
                {
                    //Update our state based on the variable we're tracking
                    state = bento_variable_get(variable_scope, variable_name);
                    
                    //Set our sprite image based on our internal values
                    var _image = 0;
                    if (mouse.focus) _image  = 1;
                    if (mouse.state) _image  = 2;
                    if (state      ) _image += 3;
                    image = _image;
                }
            };
        
            fixed_mouse_event = function(_event)
            {
                //When the sprite is clicked and released
                if (_event == "released")
                {
                    with(property)
                    {
                        //...toggle our state...
                        state = !state;
                    
                        //...and update the variable we're tracking
                        bento_variable_set(variable_scope, variable_name, state);
                    }
                }
            }
        }
        
        return self;
    }
}