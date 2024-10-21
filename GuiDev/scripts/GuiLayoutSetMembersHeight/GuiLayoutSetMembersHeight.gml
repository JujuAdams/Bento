// Feather disable all

/// Sets the height of all member instances in a layout.
/// 
/// @param layout
/// @param height

function GuiLayoutSetMembersHeight(_layout, _height)
{
    with(_layout)
    {
        var _instanceArray = __instanceArray;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            var _instance = _instanceArray[_i];
            if (instance_exists(_instance))
            {
                _instance.height = _height;
            }
            
            ++_i;
        }
        
        __RecalculateBounds();
    }
}