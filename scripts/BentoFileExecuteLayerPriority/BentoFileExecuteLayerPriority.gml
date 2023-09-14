function BentoFileExecuteLayerPriority(_path, _layerName, _priority)
{
    var _layer = new __BentoClassLayer();
    
    BentoOpen(_layer);
    _layer.Set("priority", _priority);
    BentoFileExecute(_path);
    BentoClose();
}