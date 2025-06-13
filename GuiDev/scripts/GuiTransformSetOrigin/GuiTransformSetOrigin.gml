// Feather disable all

/// Applies a *visual* transformation to a UI element and its children. This is achieved by
/// applying a world transformation matrix when drawing the UI element via `GuiSystemDraw()`.
/// 
/// This particular function sets the "origin" of transforms. By default, the origin of transforms
/// will be the same as the origin of the instance's `sprite_index`. This function allows you to
/// override that. You may set either of the `x` or `y` arguments to `undefined` to restore the
/// default behavior (using the sprite's origin).
/// 
/// N.B. This transformation only applies to how the UI instance is drawn. It does not affect
///      any collisions or raycasts. Transformations will not change `gui*` variables either.
///      To move instances around in a way that also moves their collisions, please use the
///      `GuiLayout*()` functions or `GuiSetOffset()`.
/// 
/// @param x
/// @param y
/// @param [element=self]

function GuiTransformSetOrigin(_x, _y, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_x != undefined)
        {
            if (__transformOriginX != _x)
            {
                __transformOriginX = _x;
                __GuiMarkTransformDirty(_element);
            }
        }
        
        if (_y != undefined)
        {
            if (__transformOriginY != _y)
            {
                __transformOriginY = _y;
                __GuiMarkTransformDirty(_element);
            }
        }
    }
}