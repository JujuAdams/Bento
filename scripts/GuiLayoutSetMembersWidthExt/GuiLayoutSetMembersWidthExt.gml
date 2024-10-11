// Feather disable all

/// @param layout
/// @param width
/// @param object

function GuiLayoutSetMembersWidthExt(_layout, _width, _object)
{
    with(_layout)
    {
        var _instanceArray = __instanceArray;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            var _instance = _instanceArray[_i];
            if (instance_exists(_instance) && (_instance.object_index == _object))
            {
                _instance.width = _width;
            }
            
            ++_i;
        }
    }
}