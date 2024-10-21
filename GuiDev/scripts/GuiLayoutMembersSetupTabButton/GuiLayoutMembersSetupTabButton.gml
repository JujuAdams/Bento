// Feather disable all

/// Calls `GuiTabSetupButton()` for each member of a layout.
/// 
/// @param layout
/// @param [host]

function GuiLayoutMembersSetupTabButton(_layout, _host = GuiLayoutGetParent(_layout))
{
    var _array = GuiLayoutGetArray(_layout);
    var _i = 0;
    repeat(array_length(_array))
    {
        GuiTabSetupButton(_host, _array[_i]);
        ++_i;
    }
}