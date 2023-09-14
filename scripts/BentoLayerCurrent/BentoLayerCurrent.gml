function BentoLayerCurrent()
{
    static _global = __BentoGlobal();
    
    var _top = __BentoLayerStackTop();
    return (_top == undefined)? undefined : _top.__name;
}