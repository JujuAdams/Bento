// Feather disable all

/// Sets the width of all member instances in a layout.
/// 
/// @param layout
/// @param width
/// @param [hAlign]

function GuiLayoutSetMembersWidth(_layout, _width, _hAlign = undefined)
{
    with(_layout)
    {
        var _instanceArray = __instanceArray;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            with(_instanceArray[_i])
            {
                GuiSetWidth(_width, id, _hAlign ?? other.__hAlign);
            }
            
            ++_i;
        }
        
        __RecalculateBounds();
    }
}