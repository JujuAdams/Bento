/// Returns if any layers behaviours have been set to BENTO_BEHAVIOR_MODAL.

function BentoLayerAnyBehaviorModal()
{
    static _global = __BentoGlobal();
    
    return _global.__currentHost.__LayerAnyBehaviorModal();
}