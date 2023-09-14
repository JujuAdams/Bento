/// Gets the current absolute (world-space) position of the pointer.

function BentoPointerGetY(_struct = undefined)
{
    var _layer = __BentoLayerStackTop();
    return is_struct(_layer)? _layer.__pointerY : 0;
}