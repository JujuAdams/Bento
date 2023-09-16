/// Create a new layer at over the given target layer. The new layer will have the same priority as
/// the target layer but will be ordered ahead of the target layer.
/// 
/// By default, the layers are created using BENTO_BEHAVIOR_MODAL.
/// 
/// @param path
/// @param layerName
/// @param targetName

function BentoFileExecuteLayerOver(_path, _layerName, _targetName)
{
    var _layer = new __BentoClassLayer();
    
    BentoOpen(_layer);
    _layer.MoveOver(_targetName);
    BentoFileExecute(_path);
    BentoClose();
}