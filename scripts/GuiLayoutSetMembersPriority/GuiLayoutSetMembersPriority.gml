// Feather disable all

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
            GuiSetPriority(_instanceArray[_i], _priority);
            ++_i;
        }
    }
}