// Feather disable all

/// @param [angle]
/// @param [force]
/// @param [instance=id]

function GuiAnimSetAngle(_angle, _force, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_angle != undefined)
        {
            if (__animAngle != _angle)
            {
                __animAngle = _angle;
                _system.__animationDirty = true;
            }
        }
        
        if (_force != undefined)
        {
            if (__animAngleForce != _force)
            {
                __animAngleForce = _force;
                _system.__animationDirty = true;
            }
        }
    }
}