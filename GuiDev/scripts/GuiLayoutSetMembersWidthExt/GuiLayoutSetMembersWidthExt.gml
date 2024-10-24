// Feather disable all

/// Sets the width of all member instances in a layout which are instances of a particular object.
/// 
/// @param layout
/// @param width
/// @param object
/// @param [hAlign]

function GuiLayoutSetMembersWidthExt(_layout, _width, _object, _hAlign = undefined)
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
                    GuiSetSize(_width, height, id, _hAlign ?? other.__hAlign, fa_middle);
                }
            }
            
            ++_i;
        }
        
        __RecalculateBounds();
    }
}