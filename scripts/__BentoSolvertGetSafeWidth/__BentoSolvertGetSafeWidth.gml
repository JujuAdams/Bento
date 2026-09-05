// Feather disable all

/// Returns the width of an element after safely handling various overrides.
/// 
/// @param rootHeight
/// @param [fallbackWidth=0]

function __BentoSolvertGetSafeWidth(_rootWidth, _fallbackWidth = 0) // FIXME - Typo!
{
    //Determine the preferred width
    var _value = __BentoParsePercentageString(__layoutWidthPref, _rootWidth);
    if (_value > 0)
    {
        //If the preferred width is greater than 0 then use the preferred width
        return _value;
    }
    else
    {
        if (__elementIsInstance && sprite_exists(__attachedElement.sprite_index))
        {
            //Otherwise use the width of the element's sprite (if it's an instance)
            return sprite_get_width(__attachedElement.sprite_index);
        }
        else
        {
            //Fall back on the minimum width if we can't find a suitable preferred width
            return (__layoutWidthMin > 0)? __layoutWidthMin : _fallbackWidth;
        }
    }
}