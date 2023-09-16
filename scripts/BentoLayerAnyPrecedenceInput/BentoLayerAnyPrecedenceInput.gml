/// Returns if any layers can receive input.

function BentoLayerAnyBehaviorInput()
{
    static _global = __BentoGlobal();
    
    return _global.__currentHost.__LayerAnyBehaviorInput();
}