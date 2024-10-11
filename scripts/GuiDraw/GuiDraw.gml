// Feather disable all

function GuiDraw()
{
    static _system = __GuiSystem();
    
    __GuiScissorReset();
    
    var _drawOrder = __GuiEnsureDrawOrder();
    var _i = 0;
    repeat(array_length(_drawOrder))
    {
        _drawOrder[_i]();
        ++_i;
    }
}