// Feather disable all

/// Reset the angle, scale, and offset transformation valUes applied to an element. This function
/// does not reset the transform origin.
/// 
/// @param [element=self]

function BentoTransformReset(_element = self)
{
    BentoTransformSetAngle(0, _element);
    BentoTransformSetScale(1, 1, _element);
    BentoTransformSetOffset(0, 0, _element);
}