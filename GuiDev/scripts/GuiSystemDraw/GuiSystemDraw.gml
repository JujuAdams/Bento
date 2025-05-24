// Feather disable all

/// Draws all environments, layers, and elements.

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