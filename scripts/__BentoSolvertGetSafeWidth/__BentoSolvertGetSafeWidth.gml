// Feather disable all

/// Returns the width of an element after safely handling various overrides.

function __BentoSolvertGetSafeWidth()
{
    //Determine the preferred width
    if (__layoutWidthPref > 0)
    {
        //If the preferred width is greater than 0 then use the preferred width
        return __layoutWidthPref;
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
            return __layoutWidthMin;
        }
    }
}