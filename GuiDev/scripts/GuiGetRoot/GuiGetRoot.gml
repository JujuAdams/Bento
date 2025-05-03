// Feather disable all

/// Returns the root instance. This should always exist! If it doesn't then something very bad has
/// happened and this function will throw an error accordingly.
/// 
/// @param [layer=current]

function GuiGetRoot(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (not __GuiExists(__rootElement))
        {
            __rootElement = new GuiClassElement();
            __rootElement.GUI_VARS.__layer = self;
        }
        
        return __rootElement;
    }
}