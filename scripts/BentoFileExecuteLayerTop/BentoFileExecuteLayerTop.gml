function BentoFileExecuteLayerTop(_path, _layerName, _precedence = 2)
{
    var _layer = new __BentoClassLayer();
    
    BentoOpen(_layer);
    _layer.Set("precedence", _precedence);
    BentoFileExecute(_path);
    BentoClose();
}