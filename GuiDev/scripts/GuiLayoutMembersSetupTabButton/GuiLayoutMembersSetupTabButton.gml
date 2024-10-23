// Feather disable all

/// Calls `GuiTabSetupButton()` for each member of a layout.
/// 
/// @param layout
/// @param [tabIdent]

function GuiLayoutMembersSetupTabButton(_layout, _tabIdent = GuiTabGetIdent())
{
    var _array = GuiLayoutGetArray(_layout);
    var _i = 0;
    repeat(array_length(_array))
    {
        GuiTabSetupButton(_tabIdent, _array[_i]);
        ++_i;
    }
}