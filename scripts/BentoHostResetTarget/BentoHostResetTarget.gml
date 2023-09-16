/// Resets the currently targeted host to the default host. All further Bento calls will be use the
/// default host as the scope.
/// 
///   N.B. You'll probably never need to use this function. It exists for use with complex setups
///        where multiple users might need separate interfaces that can be used simultaneously.

function BentoHostResetTarget()
{
    static _global = __BentoGlobal();
    _global.__currentHost = _global.__defaultHost;
}