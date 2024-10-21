// Feather disable all

event_inherited();

GuiNavRaycastSetDisable(id, true);

if (not variable_instance_exists(id, "title"      )) title = "Example";
if (not variable_instance_exists(id, "optionArray")) optionArray = []; 
if (not variable_instance_exists(id, "option"     )) option = 0; 
if (not variable_instance_exists(id, "func"       )) func = function(){};

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