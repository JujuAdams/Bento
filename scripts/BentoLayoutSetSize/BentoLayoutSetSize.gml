// Feather disable all

/// Sets the baseline width and height for an element. You may use a value of `undefined` to
/// indicate that a value in a particular axis should not be changed from its current value.
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