// Feather disable all

/// @param layout
/// @param height
/// @param object

function GuiLayoutSetMembersHeightExt(_layout, _height, _object)
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
                _instance.height = _height;
            }
            
            ++_i;
        }
    }
}