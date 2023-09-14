function BentoHostLTRB(_left, _top, _right, _bottom)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__HostLTRB(_left, _top, _right, _bottom);
}