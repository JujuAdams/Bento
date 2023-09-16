/// Returns the number of layers that currently exist.

function BentoLayerGetCount()
{
    static _global = __BentoGlobal();
    
    return _global.__currentHost.__GetLayerCount();
}