// Feather disable all

/// @param focusType

function BentoFocusToggle(_focusType, _element = self)
{
    if (BentoFocusGetType(_element) == BENTO_FOCUS_NONE)
    {
        BentoFocusOpen(_focusType, _element);
    }
    else
    {
        BentoFocusClose();
    }
}