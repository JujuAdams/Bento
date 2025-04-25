// Feather disable all

/// @param [angle]
/// @param [force]
/// @param [instance=id]

function GuiAnimSetAngle(_angle, _force, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.__gui)
    {
        if (_angle != undefined)
        {
            if (__animAngle != _angle)
            {
                __animAngle = _angle;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
        
        if (_force != undefined)
        {
            if (__animAngleForce != _force)
            {
                __animAngleForce = _force;
                __GuiMarkAnimAndScrollDirty(_instance);
            }
        }
    }
}