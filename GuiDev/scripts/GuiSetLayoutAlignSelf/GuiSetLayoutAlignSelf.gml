// Feather disable all

/// @param [hAlign]
/// @param [vAlign]
/// @param [instance=id]

function GuiSetLayoutAlignSelf(_hAlign, _vAlign, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_hAlign != undefined)
        {
            if (__layoutHAlign != _hAlign)
            {
                __layoutHAlign = _hAlign;
                _system.__layoutDirty = true;
            }
        }
        
        if (_vAlign != undefined)
        {
            if (__layoutVAlign != _vAlign)
            {
                __layoutVAlign = _vAlign;
                _system.__layoutDirty = true;
            }
        }
    }
}