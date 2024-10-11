// Feather disable all

/// @param layout
/// @param width

function GuiLayoutSetMembersWidth(_layout, _width)
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
                _instance.width = _width;
            }
            
            ++_i;
        }
    }
}