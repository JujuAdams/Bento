// Feather disable all

// Juju: An example that demonstrates how to make a carousel of discrete qualitative options. It
//       can be manipulated using pointer input or directional input. Clicking on the left or right
//       sides will increment or decrement a value. Directional input uses the x-axis movement to
//       change a value (in this example project, that means pressing the left and right arrow
//       keys).

event_inherited();

// Disables raycasting in particular axes. This only applies to directional input where raycasting
// is used to work out which instance to jump to when pushing in a particular direction. This does
// not apply to navigation links created with `GuiNavLink*()` functions. We disable horizontal
// raycasting so that it doesn't interfere with changing the scroller value.
GuiNavRaycastSetDisable(id, true, false);

if (not variable_instance_exists(id, "title"    )) title = "Example";
if (not variable_instance_exists(id, "valueStep")) valueStep = 1;
if (not variable_instance_exists(id, "valueMin" )) valueMin = 0;
if (not variable_instance_exists(id, "valueMax" )) valueMax = 100;
if (not variable_instance_exists(id, "value"    )) value = valueMax;
if (not variable_instance_exists(id, "func"     )) func = function(){};

if (width  == 0) width  = string_width( title) + 20;
if (height == 0) height = string_height(title) + 20;