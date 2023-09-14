function BentoLayerGetCount()
{
    static _global = __BentoGlobal();
    
    return _global.__currentHost.__GetLayerCount();
}