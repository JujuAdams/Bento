// Feather disable all

event_inherited();

GuiNavRaycastSetDisable(id, true);

if (not variable_instance_exists(id, "title"    )) title = "Example";
if (not variable_instance_exists(id, "valueStep")) valueStep = 1;
if (not variable_instance_exists(id, "valueMin" )) valueMin = 0;
if (not variable_instance_exists(id, "valueMax" )) valueMax = 100;
if (not variable_instance_exists(id, "value"    )) value = valueMax;
if (not variable_instance_exists(id, "func"     )) func = function(){};

if (width  == 0) width  = string_width( title) + 20;
if (height == 0) height = string_height(title) + 20;