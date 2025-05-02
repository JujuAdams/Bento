// Feather disable all

/// Applies a *visual* transformation to a UI element and its children. This is achieved by
/// applying a world transformation matrix when drawing the UI element via `GuiSystemDraw()`.
/// 
/// This particular function applies a linear scaling to a UI instance.
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
/// @param [xScale]
/// @param [yScale]
/// @param [instance=self]

function GuiTransformSetScale(_xScale, _yScale, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_xScale != undefined)
        {
            if (__transformScaleX != _xScale)
            {
                __transformScaleX = _xScale;
                __GuiMarkTransformAndScrollDirty(_instance);
            }
        }
        
        if (_yScale != undefined)
        {
            if (__transformScaleY != _yScale)
            {
                __transformScaleY = _yScale;
                __GuiMarkTransformAndScrollDirty(_instance);
            }
        }
    }
}