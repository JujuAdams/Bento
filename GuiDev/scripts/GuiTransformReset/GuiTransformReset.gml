// Feather disable all

/// Reset the angle, scale, and offset transformation valUes applied to an element. This function
/// does not reset the transform origin.
/// 
/// @param [element=self]

function GuiTransformReset(_element = self)
{
    GuiTransformSetAngle(0, _element);
    GuiTransformSetScale(1, 1, _element);
    GuiTransformSetOffset(0, 0, _element);
}