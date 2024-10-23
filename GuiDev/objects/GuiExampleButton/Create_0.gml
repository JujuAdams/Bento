// Feather disable all

event_inherited();

if (not variable_instance_exists(id, "text")) text = "Example";
if (not variable_instance_exists(id, "func")) func = function(){};

if (width  == 0) width  = 20 + string_width( text);
if (height == 0) height = 20 + string_height(text);

func = method(self, func);