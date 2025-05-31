// Feather disable all

/// @param level
/// @param [element=self]

function GuiScrollbarSetHoriLevel(_level, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS.__scrollbarHori)
    {
        if (__level != _level)
        {
            __level = _level;
            _element.GUI_VARS.__layer.__layoutDirty = true;
        }
    }
}