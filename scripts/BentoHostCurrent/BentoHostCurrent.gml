/// Returns the current target host.
/// 
///   N.B. You'll probably never need to use this function. It exists for use with complex setups
///        where multiple users might need separate interfaces that can be used simultaneously.

function BentoHostCurrent()
{
    static _global = __BentoGlobal();
    return _global.__currentHost;
}