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
        if (not GUI_EXISTS(__rootInstance))
        {
            if (GUI_CREATE_LAYER != undefined)
            {
                __rootInstance = instance_create_layer(0, 0, GUI_CREATE_LAYER, __oGuiLibRoot);
            }
            else
            {
                __rootInstance = instance_create_depth(0, 0, GUI_CREATE_DEPTH ?? 0, __oGuiLibRoot);
            }
            
            __rootInstance.GUI_VARS.__layer = self;
        }
        
        return __rootInstance;
    }
}