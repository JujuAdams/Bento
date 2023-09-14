function BentoInputButtonCast(_name, _state)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputButtonCast(_name, _state);
}