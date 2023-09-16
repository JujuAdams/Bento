/// Create a new layer at the top of the layer stack, and then executes a file in the scopr
/// of that layer.
/// 
/// By default, the layers are created using BENTO_BEHAVIOR_MODAL.
/// 
/// @param path
/// @param layerName

function BentoFileExecuteLayerTop(_path, _layerName)
{
    var _layer = new __BentoClassLayer();
    
    BentoOpen(_layer);
    BentoFileExecute(_path);
    BentoClose();
}