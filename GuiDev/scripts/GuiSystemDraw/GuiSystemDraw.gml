// Feather disable all

/// Draws the GUI system.

function GuiSystemDraw()
{
    static _environmentArray = __GuiSystem().__environmentArray;
    
    __GuiScissorReset();
    
    var _i = 0;
    repeat(array_length(_environmentArray))
    {
        _environmentArray[_i].__Draw();
        ++_i;
    }
}