// Feather disable all

function GuiNavGetDragDistance()
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (not __navPointer) return 0;
        
        return point_distance(__mousePressX, __mousePressY, __mouseX, __mouseY);
    }
}