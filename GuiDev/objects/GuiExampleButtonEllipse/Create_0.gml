// Feather disable all

// Juju: This is an example of a simple button. You click it, it executes a callback method. This
//       object eventually inherits from `GuiButtonObject` which is the common ancestor for buttons
//       in the Gui system.
//       
//       This event handles initialization for the instance and is executed as soon as the instance
//       is created. User Event 0 (`GUI_USER_EVENT_STEP`) contains code that is executed by
//       `GuiStep()` and User Event 1 (`GUI_USER_EVENT_DRAW`) contains code that is executed by
//       `GuiDraw()`.

event_inherited();

if (not variable_instance_exists(id, "text")) text = "Example";
if (not variable_instance_exists(id, "func")) func = function(){};

// Set a reasonable default value by using the size of the text label that will be drawn on the button.
GuiSetSize(20 + string_width(text), 20 + string_height(text));

// Ensure that the method set as the callback is guaranteed to be scoped to this instance. This
// avoids confusion about scoping when methods are set in e.g. a parent instance.
func = method(self, func);