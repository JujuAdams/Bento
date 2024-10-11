// Feather disable all

/// @param layout

function GuiLayoutNavSelectFirst(_layout)
{
    var _array = _layout.__instanceArray;
    
    var _i = 0;
    repeat(array_length(_array))
    {
        var _instance = _array[_i];
        if (instance_exists(_instance))
        {
            if (_instance.__behavior == GUI_BEHAVIOR_BUTTON)
            {
                GuiNavSelect(_instance);
                break;
            }
        }
        
        ++_i;
    }
}