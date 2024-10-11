// Feather disable all

function __GuiNavInputPointer(_x, _y, _buttonHold)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        __mousePrevHold = __mouseHold;
        
        if (__mousePrevHold)
        {
            __mousePrevX = __mouseX;
            __mousePrevY = __mouseY;
        }
        
        __mouseX    = _x;
        __mouseY    = _y;
        __mouseHold = _buttonHold;
    }
}