function BentoInputButtonClick(_name, _state)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputButtonClick(_name, _state);
}