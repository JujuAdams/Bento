// Feather disable all

/// Returns the current scroll x-offset.
/// 
/// @param [element=self]

function BentoScrollGetX(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    return _element.GUI_VARS.__scrollX;
}