/// Create a new layer atthe given priority. If the new layer has the same priority as an existing
/// layer, the new layer will be ordered to be handled and drawn ahead of the existing layer.
/// 
/// By default, the layers are created using BENTO_BEHAVIOR_MODAL.
/// 
/// @param path
/// @param layerName
/// @param priority

function BentoFileExecuteLayerPriority(_path, _layerName, _priority)
{
    var _layer = new __BentoClassLayer();
    
    BentoOpen(_layer);
    _layer.Set("priority", _priority);
    BentoFileExecute(_path);
    BentoClose();
}