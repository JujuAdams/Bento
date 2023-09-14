/// Resets the currently targeted host to the default host (BENTO_ONION). All further layer- and
/// UI-related calls will be use the default host as the scope.
/// 
/// This function is provided for complex situations where maintaining multiple independent UI
/// stacks is necessary. You probably don't need this function.

function BentoHostResetTarget()
{
    static _global = __BentoGlobal();
    _global.__currentHost = _global.__defaultHost;
}