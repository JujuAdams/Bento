// Feather disable all

/// Returns whether an instance has been disabled by `BentoSetDisable()`.
/// 
/// @param [element=self]

function BentoGetDisable(_element = self)
{
    if (not BentoExists(_element)) return false;
    
    return _element.GUI_VARS.__disable;
}