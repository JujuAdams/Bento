// Feather disable all

/// Applies a *visual* transformation to a UI element and its children. This is achieved by
/// applying a world transformation matrix when drawing the UI element via `GuiDraw()`.
/// 
/// This particular function applies a rotation to a UI instance.
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
/// @param [angle]
/// @param [instance=id]

function GuiTransformSetAngle(_angle, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (_angle != undefined)
        {
            if (__transformAngle != _angle)
            {
                __transformAngle = _angle;
                __GuiMarkTransformAndScrollDirty(_instance);
            }
        }
    }
}