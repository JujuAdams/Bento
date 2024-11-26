// Feather disable all

// Juju: An example that demonstrates how to make a carousel of discrete qualitative options. It
//       can be manipulated using pointer input or directional input. Clicking on the left or right
//       sides will scroll through options. Directional input uses the x-axis movement to trigger
//       scrolling through options (in this example project, that means pressing the left and right
//       arrow keys).

event_inherited();

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which instance to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `GuiNavLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with scrolling through options.
GuiNavRaycastSetDisable(true, false);

if (not variable_instance_exists(id, "title"      )) title = "Example";
if (not variable_instance_exists(id, "optionArray")) optionArray = []; 
if (not variable_instance_exists(id, "option"     )) option = 0; 
if (not variable_instance_exists(id, "func"       )) func = function(){};

// Gui instances will initialize to have a `width` and `height` of 0. If either is zero when this
// event is executed then we set a reasonable default value by using the maximal size of options in
// the option array.
if (width == 0)
{
    width = string_width(title);
    
    var _i = 0;
    repeat(array_length(optionArray))
    {
        width = max(width, string_width(optionArray[_i]) + 40);
        ++_i;
    }
    
    width += 20;
}

if (height == 0)
{
    height = string_height(title);
    
    if (array_length(optionArray) > 0)
    {
        height += string_height(optionArray[0]);
    }
    
    height += 20;
}