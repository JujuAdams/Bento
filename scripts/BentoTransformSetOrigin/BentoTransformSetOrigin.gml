// Feather disable all

/// Applies a *visual* transformation to an element and its children. This is achieved by
/// applying a world transformation matrix when drawing the element via `BentoSystemDraw()`.
/// 
/// This particular function sets the "origin" of transforms. The default origin for an element
/// depends on whether it's an instance or an element.
/// 
/// If the element is an instance then the default origin for transforms will be the same as the
/// origin of the instance's sprite (as determined by the instance's native `sprite_index`
/// variable).
/// 
/// If the element is a struct then the default origin will be located at the calculated x/y
/// position for the element as given by the `bentoX` and `bentoY` variables.
/// 
/// At any rate, this function allows you to override the default origin. You may set either of the
/// `x` or `y` arguments to `undefined` to restore the default behavior (see above). These
/// coordinates are relative to the element's top left corner as given by the `bentoLeft` and
/// `bentoTop` variables.
/// 
/// N.B. This transformation only applies to how the element is drawn. It does not affect
///      any collisions or navigation. Transformations will not change `bento*` variables either.
///      To move elements around in a way that also moves their collisions, please use the
///      `BentoLayout*()` functions or `BentoSetOffset()`.
/// 
/// @param xOffset
/// @param yOffset
/// @param [element=self]

function BentoTransformSetOrigin(_xOffset, _yOffset, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__transformOriginX != _xOffset)
        {
            __transformOriginX = _xOffset;
            __BentoMarkTransformDirty();
        }
        
        if (__transformOriginY != _yOffset)
        {
            __transformOriginY = _yOffset;
            __BentoMarkTransformDirty();
        }
    }
}