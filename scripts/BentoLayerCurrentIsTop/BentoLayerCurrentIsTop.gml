/// Returns whether the current layer being processed is the top-most layer.
/// 
/// This function will return <undefined> if called outside of the execution of either the
/// .Step() or .Draw() methods on an host struct.

function BentoLayerCurrentIsTop()
{
    static _global = __BentoGlobal();
    
    var _top = __BentoLayerStackTop();
    if (_top == undefined) return false;
    
    return (_top.__name == _global.__currentHost.__GetTopLayer());
}