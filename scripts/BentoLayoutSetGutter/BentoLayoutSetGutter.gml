// Feather disable all

/// Sets the size of the gutter in each axis, measued in pixels. The "gutter" is the space between
/// child elements when using a list or grid ruleset. Setting the gutter will do nothing for other
/// rulesets.
/// 
/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoLayoutSetGutter(_x, _y, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (_x != undefined)
        {
            if (__layoutGutterX != _x)
            {
                __layoutGutterX = _x;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutGutterY != _y)
            {
                __layoutGutterY = _y;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}