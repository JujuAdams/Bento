// Feather disable all

/// Returns the focus type for a focused element. If the element is not focused or the element
/// doesn't exist, ths function will return `GUI_FOCUS_NONE`.
/// 
/// @param [element=self]

function BentoFocusGetType(_element = self)
{
    return BentoExists(_element)? _element.GUI_VARS.__focusType : false;
}