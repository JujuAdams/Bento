// Feather disable all

/// Sets the priority of all member instances in a layout.
/// 
/// @param layout
/// @param priority

function GuiLayoutSetMembersPriority(_layout, _priority)
{
    with(_layout)
    {
        var _instanceArray = __instanceArray;
        var _i = 0;
        repeat(array_length(_instanceArray))
        {
            GuiSetPriority(_priority, _instanceArray[_i]);
            ++_i;
        }
    }
}