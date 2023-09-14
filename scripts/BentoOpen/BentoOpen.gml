/// Opens a box for editing
/// 
/// @param box

function BentoOpen(_box)
{
    static _global = __BentoGlobal();
    
    //Detect if this incoming box is using a different layer to what we have currently
    var _layer = _box.__FindLayer();
    if (_layer != __BentoLayerStackTop())
    {
        //If so, push a new start and mark this box as needing to pop the layer when we close it
        __BentoLayerStackPush(_layer);
        _box.__popLayerOnClose = true;
    }
    
    //Standard scope pushes
    __BentoContextStackPush(_box);
    __BentoScriptScopePush(_box);
    
    return _box;
}