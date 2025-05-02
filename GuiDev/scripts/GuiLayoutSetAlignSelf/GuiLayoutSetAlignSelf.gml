// Feather disable all

/// @param [hAlign]
/// @param [vAlign]
/// @param [instance=self]

function GuiLayoutSetAlignSelf(_hAlign, _vAlign, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_hAlign != undefined)
        {
            if (__layoutAlignH != _hAlign)
            {
                __layoutAlignH = _hAlign;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_vAlign != undefined)
        {
            if (__layoutAlignV != _vAlign)
            {
                __layoutAlignV = _vAlign;
                __environment.__layoutDirty = true;
            }
        }
    }
}