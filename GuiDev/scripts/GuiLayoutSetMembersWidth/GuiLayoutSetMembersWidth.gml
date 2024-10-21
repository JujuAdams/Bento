// Feather disable all

/// Sets the width of all member instances in a layout.
/// 
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
            with(_instanceArray[_i])
            {
                GuiSetSize(_width, height, id, other.__hAlign, fa_middle);
            }
            
            ++_i;
        }
        
        __RecalculateBounds();
    }
}