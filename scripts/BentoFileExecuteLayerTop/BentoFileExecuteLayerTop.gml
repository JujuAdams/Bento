function BentoFileExecuteLayerTop(_path, _layerName, _behavior = 2)
{
    var _layer = new __BentoClassLayer();
    
    BentoOpen(_layer);
    _layer.Set("behavior", _behavior);
    BentoFileExecute(_path);
    BentoClose();
}