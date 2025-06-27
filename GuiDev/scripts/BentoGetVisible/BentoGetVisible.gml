// Feather disable all

/// @param [element=self]

function BentoGetVisible(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return _element.GUI_VARS.__visible;
}