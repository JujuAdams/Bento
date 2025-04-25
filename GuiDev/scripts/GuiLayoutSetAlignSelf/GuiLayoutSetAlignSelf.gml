// Feather disable all

/// @param [hAlign]
/// @param [vAlign]
/// @param [instance=id]

function GuiLayoutSetAlignSelf(_hAlign, _vAlign, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.__gui)
    {
        if (_hAlign != undefined)
        {
            if (__layoutAlignH != _hAlign)
            {
                __layoutAlignH = _hAlign;
                _system.__layoutDirty = true;
            }
        }
        
        if (_vAlign != undefined)
        {
            if (__layoutAlignV != _vAlign)
            {
                __layoutAlignV = _vAlign;
                _system.__layoutDirty = true;
            }
        }
    }
}