// Feather disable all

/// Sets the baseline size for an element.
/// 
/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetSize(_width, _height, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (_width != undefined)
        {
            if (__layoutWidthPref != _width)
            {
                __layoutWidthPref = _width;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightPref != _height)
            {
                __layoutHeightPref = _height;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}