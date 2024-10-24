// Feather disable all

/// Sets the height of all member instances in a layout.
/// 
/// @param layout
/// @param height
/// @param [vAlign]

function GuiLayoutSetMembersHeight(_layout, _height, _vAlign = undefined)
{
    with(_layout)
    {
        var _instanceArray = __instanceArray;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            with(_instanceArray[_i])
            {
                GuiSetSize(width, _height, id, fa_center, _vAlign ?? other.__vAlign);
            }
            
            ++_i;
        }
        
        __RecalculateBounds();
    }
}