/// Gets the absolute position of the pointer when it clicked on a box. If no button has
/// been clicked then this function returns the current position of the pointer.

function BentoPointerGetStartY()
{
    var _layer = __BentoLayerStackTop();
    return is_struct(_layer)? _layer.__pointerStartY : 0;
}