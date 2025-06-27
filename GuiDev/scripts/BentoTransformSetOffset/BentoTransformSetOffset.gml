// Feather disable all

/// Applies a *visual* transformation to an element and its children. This is achieved by
/// applying a world transformation matrix when drawing the element via `BentoSystemDraw()`.
/// 
/// This particular function applies a linear translation to an element relative to that
/// element's layout position (`bentoX` and `bentoY`). 
/// 
/// N.B. This transformation only applies to how the element is drawn. It does not affect
///      any collisions or raycasts. Transformations will not change `bento*` variables either.
///      To move instances around in a way that also moves their collisions, please use the
///      `BentoLayout*()` functions or `BentoSetOffset()`.
/// 
/// Transformations are applied in this order:
/// 1. Scaling
/// 2. Rotation
/// 3. Translation
/// The center of the transform can be set using `BentoTransformSetOrigin()`.
/// 
/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoTransformSetOffset(_x, _y, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (_x != undefined)
        {
            if (__transformOffsetX != _x)
            {
                __transformOffsetX = _x;
                __BentoMarkTransformDirty(_element);
            }
        }
        
        if (_y != undefined)
        {
            if (__transformOffsetY != _y)
            {
                __transformOffsetY = _y;
                __BentoMarkTransformDirty(_element);
            }
        }
        
        if (__transformOffsetAbsolute)
        {
            __transformOffsetAbsolute = false;
            __BentoMarkTransformDirty(_element);
        }
    }
}