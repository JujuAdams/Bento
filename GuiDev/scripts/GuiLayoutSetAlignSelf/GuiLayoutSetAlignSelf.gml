// Feather disable all

/// @param [hAlign]
/// @param [vAlign]
/// @param [instance=id]

function GuiLayoutSetAlignSelf(_hAlign, _vAlign, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
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