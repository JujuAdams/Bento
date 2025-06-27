// Feather disable all

/// Applies a *visual* transformation to an element and its children. This is achieved by
/// applying a world transformation matrix when drawing the element via `BentoSystemDraw()`.
/// 
/// This particular function sets the "origin" of transforms. By default, the origin of transforms
/// will be the same as the origin of the instance's `sprite_index`. This function allows you to
/// override that. You may set either of the `x` or `y` arguments to `undefined` to restore the
/// default behavior (using the sprite's origin).
/// 
/// N.B. This transformation only applies to how the element is drawn. It does not affect
///      any collisions or raycasts. Transformations will not change `bento*` variables either.
///      To move elements around in a way that also moves their collisions, please use the
///      `BentoLayout*()` functions or `BentoSetOffset()`.
/// 
/// @param x
/// @param y
/// @param [element=self]

function BentoTransformSetOrigin(_x, _y, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (_x != undefined)
        {
            if (__transformOriginX != _x)
            {
                __transformOriginX = _x;
                __BentoMarkTransformDirty(_element);
            }
        }
        
        if (_y != undefined)
        {
            if (__transformOriginY != _y)
            {
                __transformOriginY = _y;
                __BentoMarkTransformDirty(_element);
            }
        }
    }
}