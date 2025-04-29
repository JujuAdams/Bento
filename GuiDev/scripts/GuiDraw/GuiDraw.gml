// Feather disable all

/// Draws the GUI system.

function GuiDraw()
{
    static _system = __GuiSystem();
    static _matrixStack = _system.__matrixStack;
    
    __GuiScissorReset();
    
    var _matrix = matrix_get(matrix_world);
    _matrixStack[0] = _matrix;
    
    var _drawOrder = __GuiEnsureDrawOrder();
    var _i = 0;
    repeat(array_length(_drawOrder))
    {
        _drawOrder[_i]();
        ++_i;
    }
    
    __GuiMatrixPop();
    
    if (GUI_RUNNING_FROM_IDE)
    {
        if (array_length(_matrixStack) != 0)
        {
            __GuiError("Unbalanced matrix push/pop stack");
        }
    }
}