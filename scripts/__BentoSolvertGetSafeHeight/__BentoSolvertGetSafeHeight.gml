// Feather disable all

/// Returns the height of an element after safely handling various overrides.

function __BentoSolvertGetSafeHeight()
{
    //Determine the preferred height
    if (__layoutHeightPref > 0)
    {
        //If the preferred height is greater than 0 then use the preferred height
        var _height = __layoutHeightPref;
    }
    else if (__elementIsInstance && sprite_exists(__attachedElement.sprite_index))
    {
        //Otherwise use the height of the element's sprite (if it's an instance)
        var _height = sprite_get_height(__attachedElement.sprite_index);
    }
    else
    {
        //Fall back on the minimum height if we can't find a suitable preferred height
        var _height = __layoutHeightMin;
    }
    
    return _height;
}