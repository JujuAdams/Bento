// Feather disable all

/// Applies a *visual* transformation to an element and its children. This is achieved by
/// applying a world transformation matrix when drawing the element via `BentoSystemDraw()`.
/// 
/// This particular function applies a rotation to an element.
/// 
/// N.B. This transformation only applies to how the element is drawn. It does not affect
///      any collisions or navigation. Transformations will not change `bento*` variables either.
///      To move elements around in a way that also moves their collisions, please use the
///      `BentoLayout*()` functions or `BentoSetOffset()`.
/// 
/// Transformations are applied in this order:
/// 1. Scaling
/// 2. Rotation
/// 3. Translation
/// The center of the transform can be set using `BentoTransformSetOrigin()`.
/// 
/// @param [angle]
/// @param [element=self]

function BentoTransformSetAngle(_angle, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (_angle != undefined)
        {
            if (__transformAngle != _angle)
            {
                __transformAngle = _angle;
                __BentoMarkTransformDirty();
            }
        }
    }
}