// Feather disable all

/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetSize(_width, _height, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthPref != _width)
            {
                __layoutWidthPref = _width;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightPref != _height)
            {
                __layoutHeightPref = _height;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
    }
}