/// Sets the left/top/right/bottom boundary of the currently targeted Bento host.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom

function BentoHostLTRB(_left, _top, _right, _bottom)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__HostLTRB(_left, _top, _right, _bottom);
}