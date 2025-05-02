// Feather disable all

function GuiNavClearFocus()
{
    with(GUI_ENVIRONMENT)
    {
        var _i = 0;
        repeat(array_length(__stepRootStack))
        {
            __stepRootStack[_i].__focused = false;
            ++_i;
        }
        
        array_resize(__stepRootStack, 0);
    }
}