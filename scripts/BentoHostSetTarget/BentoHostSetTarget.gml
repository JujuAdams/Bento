/// Sets the currently targeted host. All further Bento calls will be use this host as the scope.
/// 
///   N.B. You'll probably never need to use this function. It exists for use with complex setups
///        where multiple users might need separate interfaces that can be used simultaneously.
/// 
/// @param  host

function BentoHostSetTarget(_host)
{
    static _global = __BentoGlobal();
    _global.__currentHost = _host;
}