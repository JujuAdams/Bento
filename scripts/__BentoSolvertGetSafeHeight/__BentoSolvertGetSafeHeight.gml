// Feather disable all

/// Returns the height of an element after safely handling various overrides.
/// 
/// @param rootHeight
/// @param [fallbackHeight=0]

function __BentoSolvertGetSafeHeight(_rootHeight, _fallbackHeight = 0) // FIXME - Typo!
{
    //Determine the preferred height
    var _value = __BentoParsePercentageString(__layoutHeightPref, _rootHeight);
    if (_value > 0)
    {
        //If the preferred height is greater than 0 then use the preferred height
        return _value;
    }
    else
    {
        if (__elementIsInstance && sprite_exists(__attachedElement.sprite_index))
        {
            //Otherwise use the height of the element's sprite (if it's an instance)
            return sprite_get_height(__attachedElement.sprite_index);
        }
        else
        {
            //Fall back on the minimum height if we can't find a suitable preferred height
            return (__layoutHeightMin > 0)? __layoutHeightMin : _fallbackHeight;
        }
    }
}