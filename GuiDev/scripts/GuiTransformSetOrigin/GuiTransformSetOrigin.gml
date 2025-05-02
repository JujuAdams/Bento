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
///      `GuiLayout*()` functions.
/// 
/// Transformations are applied in this order:
/// 1. Scaling
/// 2. Rotation
/// 3. Translation
/// The center of rotation and translation can be set using `GuiTransformSetOrigin()`.
/// 
/// @param x
/// @param y
/// @param [instance=self]

function GuiTransformSetOrigin(_x, _y, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_x != undefined)
        {
            if (__transformOriginX != _x)
            {
                __transformOriginX = _x;
                __GuiMarkTransformAndScrollDirty(_instance);
            }
        }
        
        if (_y != undefined)
        {
            if (__transformOriginY != _y)
            {
                __transformOriginY = _y;
                __GuiMarkTransformAndScrollDirty(_instance);
            }
        }
    }
}