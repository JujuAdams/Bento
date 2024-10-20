// Feather disable all

/// @param layout
/// @param [host]

function GuiLayoutTabs(_layout, _host = GuiLayoutGetParent(_layout))
{
    var _array = GuiLayoutGetArray(_layout);
    var _i = 0;
    repeat(array_length(_array))
    {
        GuiTabSetupButton(_array[_i], _host);
        ++_i;
    }
}