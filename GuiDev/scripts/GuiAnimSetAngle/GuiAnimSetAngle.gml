// Feather disable all

/// @param [angle]
/// @param [instance=id]

function GuiAnimSetAngle(_angle, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (_angle != undefined)
        {
            if (__animAngle != _angle)
            {
                __animAngle = _angle;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
    }
}