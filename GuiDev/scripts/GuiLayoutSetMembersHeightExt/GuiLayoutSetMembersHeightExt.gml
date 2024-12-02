// Feather disable all

/// Sets the height of all member instances in a layout which are instances of a particular object.
/// 
/// @param layout
/// @param height
/// @param object
/// @param [vAlign]

function GuiLayoutSetMembersHeightExt(_layout, _height, _object, _vAlign = undefined)
{
    with(_layout)
    {
        var _instanceArray = __instanceArray;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            with(_instanceArray[_i])
            {
                if (object_index == _object)
                {
                    GuiSetHeight(_height, id, _vAlign ?? other.__vAlign);
                }
            }
            
            ++_i;
        }
        
        __RecalculateBounds();
    }
}