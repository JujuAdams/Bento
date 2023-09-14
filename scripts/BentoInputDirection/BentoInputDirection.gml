function BentoInputDirection(_dX, _dY, _retrigger = false, _threshold = 0.2)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputDirection(_dX, _dY, _retrigger, _threshold);
}